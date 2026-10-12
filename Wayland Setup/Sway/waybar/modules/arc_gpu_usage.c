
/*
 * gpuload.c - Intel Arc xe engine-busy load for Waybar.
 *
 * Cached GPU-FD discovery, with periodic refresh and per-sample fdinfo reads.
 *
 * Build: gcc -O2 -Wall -Wextra -o gpuload gpuload.c
 *
 * Usage:
 *   ./gpuload [-c cardN | -p PCI_ADDR] [-e class] [-i interval_ms]
 *             [-a samples] [-m pct] [-d refresh_ms] [-n]
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
#include <sys/types.h>

#define NC 5
#define MAXC 4096

static const char *classes[NC] = {
    "rcs", "ccs", "bcs", "vcs", "vecs"
};

typedef struct {
    pid_t pid;
    int fd;
    unsigned long long starttime;
    unsigned long long id;
    char pdev[32];
    unsigned long long busy[NC];
} client_t;

typedef struct {
    client_t c[MAXC];
    int n;
    unsigned long long total[NC];
    unsigned cap[NC];
} sample_t;

typedef struct {
    pid_t pid;
    int fd;
    unsigned long long starttime;
    char fdpath[PATH_MAX];
    char infopath[PATH_MAX];
} fd_entry_t;

typedef struct {
    fd_entry_t *items;
    size_t n;
    size_t cap;
} fd_cache_t;

static sample_t sample_a, sample_b;

static int selected_class(int k, int only_class)
{
    return only_class < 0 || k == only_class;
}

static const char *after(const char *line, const char *prefix)
{
    size_t n = strlen(prefix);
    return strncmp(line, prefix, n) == 0 ? line + n : NULL;
}

static const char *value(const char *line)
{
    const char *p = strchr(line, ':');
    if (!p)
        return "";

    p++;
    while (*p == ' ' || *p == '\t')
        p++;

    return p;
}

static int class_index(const char *s)
{
    const char *colon = strchr(s, ':');
    if (!colon)
        return -1;

    size_t len = (size_t)(colon - s);

    for (int i = 0; i < NC; i++) {
        if (strlen(classes[i]) == len &&
            strncmp(s, classes[i], len) == 0)
            return i;
    }

    return -1;
}

/* Read /proc/PID/stat field 22 to detect PID reuse. */
static unsigned long long process_starttime(const char *procroot, pid_t pid)
{
    char path[PATH_MAX], buf[4096];

    int n = snprintf(path, sizeof path, "%s/%ld/stat",
                     procroot, (long)pid);

    if (n < 0 || (size_t)n >= sizeof path)
        return 0;

    FILE *f = fopen(path, "r");
    if (!f)
        return 0;

    if (!fgets(buf, sizeof buf, f)) {
        fclose(f);
        return 0;
    }

    fclose(f);

    /* comm may contain spaces or ')'. Start parsing after its final ')'. */
    char *p = strrchr(buf, ')');
    if (!p || p[1] != ' ')
        return 0;

    p += 2; /* Field 3: state. */

    /* Advance from field 3 to field 22: starttime. */
    for (int field = 3; field < 22; field++) {
        p = strchr(p, ' ');
        if (!p)
            return 0;

        while (*p == ' ')
            p++;
    }

    errno = 0;
    char *end = NULL;
    unsigned long long result = strtoull(p, &end, 10);

    return errno || end == p ? 0 : result;
}

static int append_fd(fd_cache_t *cache, const fd_entry_t *entry)
{
    if (cache->n == cache->cap) {
        size_t newcap = cache->cap ? cache->cap * 2 : 256;

        if (newcap > 1000000)
            return -1;

        fd_entry_t *newitems =
            realloc(cache->items, newcap * sizeof *newitems);

        if (!newitems)
            return -1;

        cache->items = newitems;
        cache->cap = newcap;
    }

    cache->items[cache->n++] = *entry;
    return 0;
}

/*
 * Expensive discovery: walk /proc and find FDs pointing to /dev/dri.
 * Build a fresh cache first, so a failed discovery doesn't destroy the old one.
 */
static int discover_fds(const char *procroot, fd_cache_t *cache)
{
    fd_cache_t fresh = { 0 };

    DIR *pd = opendir(procroot);
    if (!pd)
        return -1;

    struct dirent *pe;

    while ((pe = readdir(pd))) {
        if (!isdigit((unsigned char)pe->d_name[0]))
            continue;

        char *endpid = NULL;
        long pidlong = strtol(pe->d_name, &endpid, 10);

        if (!endpid || *endpid || pidlong <= 0 || pidlong > INT_MAX)
            continue;

        pid_t pid = (pid_t)pidlong;
        unsigned long long starttime = process_starttime(procroot, pid);

        if (!starttime)
            continue;

        char fddir[PATH_MAX];
        int n = snprintf(fddir, sizeof fddir, "%s/%ld/fd",
                         procroot, pidlong);

        if (n < 0 || (size_t)n >= sizeof fddir)
            continue;

        DIR *fd = opendir(fddir);
        if (!fd)
            continue;

        struct dirent *fe;

        while ((fe = readdir(fd))) {
            if (!isdigit((unsigned char)fe->d_name[0]))
                continue;

            char *endfd = NULL;
            long fdlong = strtol(fe->d_name, &endfd, 10);

            if (!endfd || *endfd || fdlong < 0 || fdlong > INT_MAX)
                continue;

            char linkpath[PATH_MAX];
            char target[PATH_MAX];

            n = snprintf(linkpath, sizeof linkpath, "%s/%s",
                         fddir, fe->d_name);

            if (n < 0 || (size_t)n >= sizeof linkpath)
                continue;

            ssize_t len = readlink(linkpath, target, sizeof target - 1);
            if (len <= 0)
                continue;

            target[len] = '\0';

            if (strncmp(target, "/dev/dri/", 9) != 0)
                continue;

            fd_entry_t item = { 0 };

            item.pid = pid;
            item.fd = (int)fdlong;
            item.starttime = starttime;

            n = snprintf(item.fdpath, sizeof item.fdpath, "%s", linkpath);
            if (n < 0 || (size_t)n >= sizeof item.fdpath)
                continue;

            n = snprintf(item.infopath, sizeof item.infopath,
                         "%s/%ld/fdinfo/%ld",
                         procroot, pidlong, fdlong);

            if (n < 0 || (size_t)n >= sizeof item.infopath)
                continue;

            if (append_fd(&fresh, &item) != 0) {
                closedir(fd);
                closedir(pd);
                free(fresh.items);
                return -1;
            }
        }

        closedir(fd);
    }

    closedir(pd);

    free(cache->items);
    *cache = fresh;

    return 0;
}

/*
 * Sample a cached FD.
 *
 * - Verify process identity to detect PID reuse.
 * - Validate that the FD still points to a DRM device.
 * - Parse only the selected engine's counter lines when -e is specified.
 * - Deduplicate clients by PCI device and DRM client ID.
 */
static void parse_cached_fdinfo(const fd_entry_t *entry,
                                const char *procroot,
                                const char *pdev_filter,
                                int only_class,
                                sample_t *s)
{
    unsigned long long starttime =
        process_starttime(procroot, entry->pid);

    if (!starttime || starttime != entry->starttime)
        return;

    char target[PATH_MAX];

    ssize_t len = readlink(entry->fdpath, target, sizeof target - 1);
    if (len <= 0)
        return;

    target[len] = '\0';

    if (strncmp(target, "/dev/dri/", 9) != 0)
        return;

    FILE *f = fopen(entry->infopath, "r");
    if (!f)
        return;

    char line[256];
    char pdev[32] = "";

    unsigned long long id = 0;
    unsigned long long busy[NC] = { 0 };
    unsigned long long total[NC] = { 0 };
    unsigned cap[NC] = { 0 };

    int have_id = 0;
    int is_xe = 0;

    while (fgets(line, sizeof line, f)) {
        const char *rest;

        if (after(line, "drm-driver:")) {
            const char *v = value(line);

            is_xe = strncmp(v, "xe", 2) == 0 &&
                    !isalnum((unsigned char)v[2]);

            if (!is_xe)
                break;
        } else if (after(line, "drm-client-id:")) {
            id = strtoull(value(line), NULL, 10);
            have_id = 1;
        } else if (after(line, "drm-pdev:")) {
            snprintf(pdev, sizeof pdev, "%s", value(line));
            pdev[strcspn(pdev, "\r\n")] = '\0';
        } else if ((rest = after(line, "drm-total-cycles-"))) {
            int k = class_index(rest);

            if (k >= 0 && selected_class(k, only_class))
                total[k] = strtoull(value(line), NULL, 10);
        } else if ((rest = after(line, "drm-cycles-"))) {
            int k = class_index(rest);

            if (k >= 0 && selected_class(k, only_class))
                busy[k] = strtoull(value(line), NULL, 10);
        } else if ((rest = after(line, "drm-engine-capacity-"))) {
            int k = class_index(rest);

            if (k >= 0 && selected_class(k, only_class))
                cap[k] = (unsigned)strtoul(value(line), NULL, 10);
        }
    }

    fclose(f);

    if (!is_xe || !have_id)
        return;

    if (pdev_filter[0] && strcmp(pdev, pdev_filter) != 0)
        return;

    for (int i = 0; i < s->n; i++) {
        if (s->c[i].id == id &&
            strcmp(s->c[i].pdev, pdev) == 0)
            return;
    }

    if (s->n >= MAXC)
        return;

    client_t *cl = &s->c[s->n++];

    cl->pid = entry->pid;
    cl->fd = entry->fd;
    cl->starttime = entry->starttime;
    cl->id = id;

    snprintf(cl->pdev, sizeof cl->pdev, "%s", pdev);

    for (int k = 0; k < NC; k++) {
        cl->busy[k] = busy[k];

        if (total[k] > s->total[k])
            s->total[k] = total[k];

        if (cap[k] > s->cap[k])
            s->cap[k] = cap[k];
    }
}

static void sample_cached(const char *procroot,
                          const char *pdev,
                          const fd_cache_t *cache,
                          int only_class,
                          sample_t *s)
{
    memset(s, 0, sizeof *s);

    for (size_t i = 0; i < cache->n; i++) {
        parse_cached_fdinfo(&cache->items[i], procroot,
                            pdev, only_class, s);
    }
}

static double compute(const sample_t *prev,
                      const sample_t *cur,
                      int only_class)
{
    double busy[NC] = { 0 };

    /* Only clients present in both samples contribute a delta. */
    for (int i = 0; i < cur->n; i++) {
        const client_t *c = &cur->c[i];
        const client_t *p = NULL;

        for (int j = 0; j < prev->n; j++) {
            if (prev->c[j].id == c->id &&
                strcmp(prev->c[j].pdev, c->pdev) == 0) {
                p = &prev->c[j];
                break;
            }
        }

        if (!p)
            continue;

        for (int k = 0; k < NC; k++) {
            if (selected_class(k, only_class) &&
                c->busy[k] > p->busy[k]) {
                busy[k] += (double)(c->busy[k] - p->busy[k]);
            }
        }
    }

    double best = 0;

    for (int k = 0; k < NC; k++) {
        if (!selected_class(k, only_class))
            continue;

        if (cur->total[k] <= prev->total[k])
            continue;

        double td = (double)(cur->total[k] - prev->total[k]);
        double capacity = cur->cap[k] ? cur->cap[k] : 1;

        double utilization = 100.0 * busy[k] / (td * capacity);

        if (utilization > 100)
            utilization = 100;

        if (utilization > best)
            best = utilization;
    }

    return best;
}

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

static int is_xe(const char *card)
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

static long long monotonic_ms(void)
{
    struct timespec ts;

    if (clock_gettime(CLOCK_MONOTONIC, &ts) != 0)
        return 0;

    return (long long)ts.tv_sec * 1000 +
           ts.tv_nsec / 1000000;
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

    while ((opt = getopt(argc, argv, "c:p:e:i:a:m:r:d:nh")) != -1) {
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
        case 'h':
            printf("Usage: %s [-c cardN | -p PCI_ADDR] [-e class] "
                   "[-i interval_ms] [-a samples] [-m pct] "
                   "[-d refresh_ms] [-r procroot] [-n]\n", argv[0]);
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

                if (is_xe(c)) {
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

    fd_cache_t cache = { 0 };

    if (discover_fds(procroot, &cache) != 0)
        fprintf(stderr,
                "Warning: initial GPU-FD discovery failed; retrying\n");

    long long last_discovery = monotonic_ms();

    sample_t *prev = &sample_a;
    sample_t *cur = &sample_b;

    sample_cached(procroot, pdev, &cache, only_class, prev);

    double hist[64] = { 0 };
    int hist_n = 0;
    int hist_i = 0;

    for (;;) {
        struct timespec req = {
            .tv_sec = interval / 1000,
            .tv_nsec = (long)(interval % 1000) * 1000000L
        };

        while (nanosleep(&req, &req) != 0 && errno == EINTR)
            ;

        long long now = monotonic_ms();

        if (now - last_discovery >= discovery_ms) {
            if (discover_fds(procroot, &cache) == 0)
                last_discovery = now;
        }

        sample_cached(procroot, pdev, &cache, only_class, cur);

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

        hist[hist_i] = load;
        hist_i = (hist_i + 1) % window;

        if (hist_n < window)
            hist_n++;

        double sum = 0;

        for (int k = 0; k < hist_n; k++)
            sum += hist[k];

        load = sum / hist_n;

        printf(no_sign ? "%.0f\n" : "%.0f%%\n", load);
    }
}
