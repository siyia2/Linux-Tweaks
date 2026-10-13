/*
 * gpuload.c - Intel Arc xe engine-busy load for Waybar (low-CPU version).
 *
 * How it keeps CPU use down:
 *   - Discovery (the expensive /proc walk) reads each /dev/dri fdinfo once,
 *     keeps only xe clients on the target GPU, and keeps ONE fd per DRM
 *     client. Duplicate/inherited fds and other GPUs are never sampled.
 *   - Each kept /proc/PID/fdinfo/N is held open and re-read with pread().
 *     An open procfs file is bound to the original task, so PID reuse can't
 *     alias it: no per-sample /proc/PID/stat parsing or readlink needed.
 *   - Per sample: 1 pread() per client, one-pass in-place line parser,
 *     no stdio, no large memsets, hash-table matching (no O(n^2) loops).
 *   - Absolute-time sleeping (no drift, no catch-up bursts).
 *   - Output is only written when the displayed value changes, which also
 *     saves Waybar from re-rendering the module.
 *   - If a cached fd dies (client exited) discovery is re-run early
 *     (at most once per second); otherwise a full rescan runs every -d ms.
 *   - Between full rescans, a cheap once-a-second scan checks only new PIDs,
 *     so newly launched GPU apps are picked up within ~1 s regardless of -d.
 *
 * Build: gcc -O2 -Wall -Wextra -o gpuload gpuload.c
 *
 * Usage:
 *   ./gpuload [-c cardN | -p PCI_ADDR] [-e class] [-i interval_ms]
 *             [-a samples] [-m pct] [-d refresh_ms] [-r procroot] [-n]
 *
 *   -c  DRM card (default: first card using xe)
 *   -p  PCI address, e.g. 0000:03:00.0
 *   -e  rcs, ccs, bcs, vcs, or vecs; default: maximum across classes
 *   -i  sampling interval in milliseconds (default 1000)
 *   -a  rolling-average window (default 3, range 1..64)
 *   -m  cosmetic calibration: treat this busy percentage as 100 (default 100)
 *   -d  GPU-FD discovery refresh in milliseconds (default 5000)
 *   -n  print the number without '%'
 *   -r  alternate proc root for testing (default /proc)
 *   -D  debug: per-sample client/engine details on stderr
 */
#define _XOPEN_SOURCE 700

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <limits.h>
#include <dirent.h>
#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/types.h>

#define NC 5
#define MAXC 4096
#define TABBITS 13
#define TABSZ (1u << TABBITS)   /* >= 2 * MAXC, keeps probing short */
#define INFOBUF 8192

static const char *const classes[NC] = {
    "rcs", "ccs", "bcs", "vcs", "vecs"
};

/* ---- tiny open-addressing id set with generation stamps (O(1) reset) ---- */

typedef struct {
    unsigned long long id;
    unsigned gen;
    int idx;
} slot_t;

typedef struct {
    unsigned gen;
    slot_t tab[TABSZ];
} idset_t;

static void set_reset(idset_t *s)
{
    if (++s->gen == 0) {
        memset(s->tab, 0, sizeof s->tab);
        s->gen = 1;
    }
}

static unsigned set_hash(unsigned long long id)
{
    return (unsigned)((id * 0x9E3779B97F4A7C15ULL) >> (64 - TABBITS));
}

static int set_find(const idset_t *s, unsigned long long id)
{
    unsigned h = set_hash(id);

    while (s->tab[h].gen == s->gen) {
        if (s->tab[h].id == id)
            return s->tab[h].idx;
        h = (h + 1) & (TABSZ - 1);
    }

    return -1;
}

static void set_insert(idset_t *s, unsigned long long id, int idx)
{
    unsigned h = set_hash(id);

    while (s->tab[h].gen == s->gen)
        h = (h + 1) & (TABSZ - 1);

    s->tab[h].id = id;
    s->tab[h].gen = s->gen;
    s->tab[h].idx = idx;
}

/* ---- data structures ---- */

typedef struct {
    unsigned long long id;
    unsigned long long busy[NC];
} client_t;

typedef struct {
    idset_t set;                /* id -> index into c[] */
    client_t c[MAXC];
    int n;
    unsigned long long total[NC];
    unsigned cap[NC];
} sample_t;

typedef struct {
    int fd[MAXC];               /* open /proc/PID/fdinfo/N descriptors */
    unsigned long long id[MAXC];/* client id each fd had at discovery */
    int n;
} fd_cache_t;

typedef struct {
    int is_xe;
    int have_id;
    unsigned long long id;
    const char *pdev;           /* points into the parse buffer */
    unsigned long long busy[NC];
    unsigned long long total[NC];
    unsigned cap[NC];
} info_t;

static sample_t sample_a, sample_b;
static fd_cache_t cache;
static idset_t seen;            /* discovery-time client dedupe */
static int fresh_fds[MAXC];
static unsigned long long fresh_ids[MAXC];
static int debug;

/* ---- parsing ---- */

#define PFX(s, lit) (strncmp((s), (lit), sizeof(lit) - 1) == 0)

/* Parse "rcs:   123" -> class index, *val -> "123". */
static int class_val(const char *rest, const char **val)
{
    const char *colon = strchr(rest, ':');
    if (!colon)
        return -1;

    size_t len = (size_t)(colon - rest);

    colon++;
    while (*colon == ' ' || *colon == '\t')
        colon++;
    *val = colon;

    for (int i = 0; i < NC; i++) {
        if (strlen(classes[i]) == len &&
            memcmp(rest, classes[i], len) == 0)
            return i;
    }

    return -1;
}

static const char *plain_val(const char *line)
{
    const char *p = strchr(line, ':');
    if (!p)
        return "";

    p++;
    while (*p == ' ' || *p == '\t')
        p++;

    return p;
}

static int want(int k, int only_class)
{
    return k >= 0 && (only_class < 0 || k == only_class);
}

/* Single pass over buf, splitting lines in place. Only "drm-" lines matter. */
static void parse_info(char *buf, int only_class, info_t *o)
{
    memset(o, 0, sizeof *o);
    o->pdev = "";

    char *p = buf;

    while (*p) {
        char *nl = strchr(p, '\n');
        if (nl)
            *nl = '\0';

        if (p[0] == 'd' && p[1] == 'r' && p[2] == 'm' && p[3] == '-') {
            const char *val;
            int k;

            switch (p[4]) {
            case 'd':
                if (PFX(p, "drm-driver:")) {
                    const char *v = plain_val(p);

                    o->is_xe = v[0] == 'x' && v[1] == 'e' &&
                               !isalnum((unsigned char)v[2]);
                    if (!o->is_xe)
                        return;
                }
                break;
            case 'c':
                if (PFX(p, "drm-client-id:")) {
                    o->id = strtoull(plain_val(p), NULL, 10);
                    o->have_id = 1;
                } else if (PFX(p, "drm-cycles-")) {
                    k = class_val(p + sizeof "drm-cycles-" - 1, &val);
                    if (want(k, only_class))
                        o->busy[k] = strtoull(val, NULL, 10);
                }
                break;
            case 'p':
                if (PFX(p, "drm-pdev:"))
                    o->pdev = plain_val(p);
                break;
            case 't':
                if (PFX(p, "drm-total-cycles-")) {
                    k = class_val(p + sizeof "drm-total-cycles-" - 1, &val);
                    if (want(k, only_class))
                        o->total[k] = strtoull(val, NULL, 10);
                }
                break;
            case 'e':
                if (PFX(p, "drm-engine-capacity-")) {
                    k = class_val(p + sizeof "drm-engine-capacity-" - 1, &val);
                    if (want(k, only_class))
                        o->cap[k] = (unsigned)strtoul(val, NULL, 10);
                }
                break;
            default:
                break;
            }
        }

        if (!nl)
            break;
        p = nl + 1;
    }
}

static int read_info(int fd, char *buf, size_t size)
{
    /* Re-reading a procfs seq_file at offset 0 regenerates its content. */
    ssize_t n = pread(fd, buf, size - 1, 0);

    if (n <= 0)
        return -1;

    buf[n] = '\0';
    return 0;
}

/* ---- sampling ---- */

static void sample_reset(sample_t *s)
{
    set_reset(&s->set);
    s->n = 0;
    memset(s->total, 0, sizeof s->total);
    memset(s->cap, 0, sizeof s->cap);
}

/* Returns -1 if this fd no longer yields a valid xe client on our GPU. */
static int sample_one(int fd, unsigned long long expect_id,
                      const char *pdev_filter, int only_class,
                      sample_t *s, char *buf)
{
    info_t in;

    if (read_info(fd, buf, INFOBUF) != 0)
        return -1;

    parse_info(buf, only_class, &in);

    if (!in.is_xe || !in.have_id || strcmp(in.pdev, pdev_filter) != 0)
        return -1;

    /* fd number reused by the target for another client: record what we
     * see, but flag the cache as stale so discovery re-runs. */
    int stale = in.id != expect_id;

    if (set_find(&s->set, in.id) >= 0 || s->n >= MAXC)
        return stale ? -1 : 0;

    client_t *cl = &s->c[s->n];

    cl->id = in.id;

    for (int k = 0; k < NC; k++) {
        cl->busy[k] = in.busy[k];

        if (in.total[k] > s->total[k])
            s->total[k] = in.total[k];
        if (in.cap[k] > s->cap[k])
            s->cap[k] = in.cap[k];
    }

    set_insert(&s->set, in.id, s->n);
    s->n++;

    return stale ? -1 : 0;
}

/* Returns the number of cached fds that failed (cache needs refreshing). */
static int sample_all(const char *pdev, int only_class, sample_t *s, char *buf)
{
    int bad = 0;

    sample_reset(s);

    for (int i = 0; i < cache.n; i++) {
        if (sample_one(cache.fd[i], cache.id[i], pdev, only_class, s, buf) != 0)
            bad++;
    }

    return bad;
}

static double compute(const sample_t *prev, const sample_t *cur,
                      int only_class)
{
    double busy[NC] = { 0 };

    /* Only clients present in both samples contribute a delta. */
    for (int i = 0; i < cur->n; i++) {
        const client_t *c = &cur->c[i];
        int j = set_find(&prev->set, c->id);

        if (j < 0) {
            if (debug)
                fprintf(stderr, "  client %llu: new (no previous sample)\n",
                        c->id);
            continue;
        }

        const client_t *p = &prev->c[j];

        if (debug) {
            fprintf(stderr, "  client %llu:", c->id);
            for (int k = 0; k < NC; k++)
                fprintf(stderr, " %s=%lld", classes[k],
                        (long long)(c->busy[k] - p->busy[k]));
            fputc('\n', stderr);
        }

        for (int k = 0; k < NC; k++) {
            if ((only_class < 0 || k == only_class) &&
                c->busy[k] > p->busy[k])
                busy[k] += (double)(c->busy[k] - p->busy[k]);
        }
    }

    double best = 0;

    for (int k = 0; k < NC; k++) {
        if (only_class >= 0 && k != only_class)
            continue;

        if (cur->total[k] <= prev->total[k])
            continue;

        double td = (double)(cur->total[k] - prev->total[k]);
        double capacity = cur->cap[k] ? cur->cap[k] : 1;
        double utilization = 100.0 * busy[k] / (td * capacity);

        if (debug)
            fprintf(stderr, "  %s: busy=%.0f total=%.0f cap=%.0f -> %.1f%%\n",
                    classes[k], busy[k], td, capacity, utilization);

        if (utilization > 100)
            utilization = 100;
        if (utilization > best)
            best = utilization;
    }

    return best;
}

/* ---- discovery ---- */

/*
 * Two kinds of scan:
 *   full  - every -d ms: walk all of /proc, rebuild the cache from scratch.
 *   quick - every second: list /proc (cheap) and look inside only PIDs that
 *           are new. A new process may open the GPU a little after it starts,
 *           so each PID is re-checked for PID_YOUNG quick scans before it is
 *           considered "known". This is what finds a freshly launched GPU
 *           app within ~1 s, however large -d is.
 */
#define PIDMAX_TRACK (1u << 22)
#define PID_YOUNG 6

static unsigned char pid_age[PIDMAX_TRACK];

/* Look at one process's fds; append any new xe client on our GPU. */
static void scan_pid(const char *procroot, const char *pidname,
                     const char *pdev_filter, int only_class, char *buf,
                     int *fds, unsigned long long *ids, int *nfds)
{
    char fddir[PATH_MAX];
    int n = snprintf(fddir, sizeof fddir, "%s/%s/fd", procroot, pidname);

    if (n < 0 || (size_t)n >= sizeof fddir)
        return;

    DIR *fd = opendir(fddir);
    if (!fd)
        return;

    int dfd = dirfd(fd);
    struct dirent *fe;

    while ((fe = readdir(fd)) && *nfds < MAXC) {
        if (!isdigit((unsigned char)fe->d_name[0]))
            continue;

        char target[64];
        ssize_t len = readlinkat(dfd, fe->d_name, target, sizeof target - 1);
        if (len <= 0)
            continue;

        target[len] = '\0';

        if (strncmp(target, "/dev/dri/", 9) != 0)
            continue;

        char infopath[PATH_MAX];

        n = snprintf(infopath, sizeof infopath, "%s/%s/fdinfo/%s",
                     procroot, pidname, fe->d_name);

        if (n < 0 || (size_t)n >= sizeof infopath)
            continue;

        int ifd = open(infopath, O_RDONLY | O_CLOEXEC);
        if (ifd < 0)
            continue;

        info_t in;
        int keep = 0;

        if (read_info(ifd, buf, INFOBUF) == 0) {
            parse_info(buf, only_class, &in);

            if (in.is_xe && in.have_id &&
                strcmp(in.pdev, pdev_filter) == 0 &&
                set_find(&seen, in.id) < 0) {
                set_insert(&seen, in.id, 0);
                keep = 1;
            }
        }

        if (keep) {
            ids[*nfds] = in.id;
            fds[(*nfds)++] = ifd;
        } else {
            close(ifd);
        }
    }

    closedir(fd);
}

/* Full rebuild. Builds a fresh list first so a failure keeps the old cache. */
static int discover_fds(const char *procroot, const char *pdev_filter,
                        int only_class, char *buf)
{
    DIR *pd = opendir(procroot);
    if (!pd)
        return -1;

    int nfresh = 0;
    struct dirent *pe;

    set_reset(&seen);

    while ((pe = readdir(pd)) && nfresh < MAXC) {
        if (!isdigit((unsigned char)pe->d_name[0]))
            continue;

        unsigned long pid = strtoul(pe->d_name, NULL, 10);

        if (pid < PIDMAX_TRACK)
            pid_age[pid] = PID_YOUNG;

        scan_pid(procroot, pe->d_name, pdev_filter, only_class, buf,
                 fresh_fds, fresh_ids, &nfresh);
    }

    closedir(pd);

    for (int i = 0; i < cache.n; i++)
        close(cache.fd[i]);

    memcpy(cache.fd, fresh_fds, (size_t)nfresh * sizeof cache.fd[0]);
    memcpy(cache.id, fresh_ids, (size_t)nfresh * sizeof cache.id[0]);
    cache.n = nfresh;

    return 0;
}

/* Incremental: add clients from processes we haven't fully vetted yet. */
static void quick_scan(const char *procroot, const char *pdev_filter,
                       int only_class, char *buf)
{
    DIR *pd = opendir(procroot);
    if (!pd)
        return;

    struct dirent *pe;

    set_reset(&seen);
    for (int i = 0; i < cache.n; i++)
        set_insert(&seen, cache.id[i], 0);

    while ((pe = readdir(pd)) && cache.n < MAXC) {
        if (!isdigit((unsigned char)pe->d_name[0]))
            continue;

        unsigned long pid = strtoul(pe->d_name, NULL, 10);

        if (pid >= PIDMAX_TRACK || pid_age[pid] >= PID_YOUNG)
            continue;

        pid_age[pid]++;

        scan_pid(procroot, pe->d_name, pdev_filter, only_class, buf,
                 cache.fd, cache.id, &cache.n);
    }

    closedir(pd);
}

/* ---- GPU selection ---- */

static int card_pdev(const char *card, char *out, size_t n)
{
    char path[PATH_MAX];
    char real[PATH_MAX];

    snprintf(path, sizeof path, "/sys/class/drm/%s/device", card);

    if (!realpath(path, real))
        return -1;

    const char *base = strrchr(real, '/');

    snprintf(out, n, "%.31s", base ? base + 1 : real);

    return 0;
}

static int card_is_xe(const char *card)
{
    char path[PATH_MAX];
    char target[PATH_MAX];

    snprintf(path, sizeof path,
             "/sys/class/drm/%s/device/driver", card);

    ssize_t len = readlink(path, target, sizeof target - 1);
    if (len < 0)
        return 0;

    target[len] = '\0';

    const char *base = strrchr(target, '/');
    base = base ? base + 1 : target;

    return strcmp(base, "xe") == 0;
}

static long long ts_ms(const struct timespec *t)
{
    return (long long)t->tv_sec * 1000 + t->tv_nsec / 1000000;
}

int main(int argc, char **argv)
{
    char card[32] = "";
    char pdev[32] = "";
    char classname[16] = "";

    const char *procroot = "/proc";

    int interval = 1000;
    int window = 3;
    int discovery_ms = 5000;
    int no_sign = 0;
    int opt;

    double full_scale = 100.0;

    while ((opt = getopt(argc, argv, "c:p:e:i:a:m:r:d:nDh")) != -1) {
        switch (opt) {
        case 'c':
            snprintf(card, sizeof card, "%s", optarg);
            break;
        case 'p':
            snprintf(pdev, sizeof pdev, "%s", optarg);
            break;
        case 'e':
            snprintf(classname, sizeof classname, "%s", optarg);
            break;
        case 'i':
            interval = atoi(optarg);
            break;
        case 'a':
            window = atoi(optarg);
            break;
        case 'm':
            full_scale = atof(optarg);
            break;
        case 'r':
            procroot = optarg;
            break;
        case 'd':
            discovery_ms = atoi(optarg);
            break;
        case 'n':
            no_sign = 1;
            break;
        case 'D':
            debug = 1;
            break;
        case 'h':
            printf("Usage: %s [-c cardN | -p PCI_ADDR] [-e class] "
                   "[-i interval_ms] [-a samples] [-m pct] "
                   "[-d refresh_ms] [-r procroot] [-n] [-D]\n", argv[0]);
            return 0;
        default:
            fprintf(stderr, "Invalid option. Use -h for help.\n");
            return 1;
        }
    }

    if (interval < 100)
        interval = 100;

    if (window < 1)
        window = 1;
    if (window > 64)
        window = 64;

    if (discovery_ms < 1000)
        discovery_ms = 1000;

    if (full_scale < 1.0 || full_scale > 100.0)
        full_scale = 100.0;

    int only_class = -1;

    if (classname[0]) {
        for (int i = 0; i < NC; i++) {
            if (strcmp(classname, classes[i]) == 0)
                only_class = i;
        }

        if (only_class < 0) {
            fprintf(stderr,
                    "Unknown engine class '%s' "
                    "(rcs, ccs, bcs, vcs, vecs)\n",
                    classname);
            return 1;
        }
    }

    /* Select the target GPU. */
    if (!pdev[0]) {
        if (!card[0]) {
            for (int i = 0; i < 16; i++) {
                char c[32];

                snprintf(c, sizeof c, "card%d", i);

                if (card_is_xe(c)) {
                    snprintf(card, sizeof card, "%s", c);
                    break;
                }
            }
        }

        if (!card[0] || card_pdev(card, pdev, sizeof pdev) != 0) {
            fprintf(stderr,
                    "No GPU bound to the xe driver found "
                    "(use -c cardN or -p PCI_ADDR)\n");
            return 1;
        }
    }

    setvbuf(stdout, NULL, _IOLBF, 0);

    char buf[INFOBUF];

    if (discover_fds(procroot, pdev, only_class, buf) != 0)
        fprintf(stderr,
                "Warning: initial GPU-FD discovery failed; retrying\n");

    struct timespec next;
    clock_gettime(CLOCK_MONOTONIC, &next);

    long long last_discovery = ts_ms(&next);
    long long last_quick = last_discovery;

    sample_t *prev = &sample_a;
    sample_t *cur = &sample_b;

    int dirty = sample_all(pdev, only_class, prev, buf) != 0;

    double hist[64] = { 0 };
    double sum = 0;
    int hist_n = 0;
    int hist_i = 0;

    char last[16] = "";

    for (;;) {
        next.tv_sec += interval / 1000;
        next.tv_nsec += (long)(interval % 1000) * 1000000L;
        if (next.tv_nsec >= 1000000000L) {
            next.tv_sec++;
            next.tv_nsec -= 1000000000L;
        }

        while (clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME,
                               &next, NULL) == EINTR)
            ;

        struct timespec nowts;
        clock_gettime(CLOCK_MONOTONIC, &nowts);
        long long now = ts_ms(&nowts);

        /* Fell far behind (suspend, stall): resync instead of bursting. */
        if (ts_ms(&next) + interval < now)
            next = nowts;

        if (now - last_discovery >= discovery_ms ||
            (dirty && now - last_discovery >= 1000)) {
            if (discover_fds(procroot, pdev, only_class, buf) == 0) {
                last_discovery = now;
                last_quick = now;
                dirty = 0;
            }
        } else if (now - last_quick >= 1000) {
            quick_scan(procroot, pdev, only_class, buf);
            last_quick = now;
        }

        int bad = sample_all(pdev, only_class, cur, buf);

        dirty = bad != 0 || dirty;

        if (debug)
            fprintf(stderr, "sample: cached=%d clients=%d bad=%d\n",
                    cache.n, cur->n, bad);

        double load = compute(prev, cur, only_class);

        /* Optional cosmetic calibration. */
        load = load * 100.0 / full_scale;

        if (load > 100)
            load = 100;
        if (load < 0)
            load = 0;

        sample_t *tmp = prev;
        prev = cur;
        cur = tmp;

        sum -= hist[hist_i];
        hist[hist_i] = load;
        sum += load;
        hist_i = (hist_i + 1) % window;

        if (hist_n < window)
            hist_n++;

        if (sum < 0)
            sum = 0;

        load = sum / hist_n;

        char out[16];

        snprintf(out, sizeof out, no_sign ? "%.0f" : "%.0f%%", load);

        if (strcmp(out, last) != 0) {
            puts(out);
            memcpy(last, out, sizeof last);
        }
    }
}
