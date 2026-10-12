/*
 * gpuload.c - Intel Arc (Battlemage, xe driver) true engine-busy load for Waybar
 *
 * Prints only the load percentage, one line per interval (e.g. "42%").
 *
 * Method: DRM client usage stats (fdinfo). For every process that has the GPU
 * open, the xe driver exposes per-client counters in /proc/<pid>/fdinfo/<fd>:
 *
 *     drm-cycles-<class>:         busy GPU cycles of this client on the class
 *     drm-total-cycles-<class>:   total GPU cycles elapsed for that class
 *     drm-engine-capacity-<class>: number of identical engines in the class
 *
 * Over an interval:  util(class) = sum(delta busy of all clients)
 *                                  / (delta total * capacity)
 * The program prints the highest utilisation across engine classes
 * (rcs = render/3D, ccs = compute, bcs = copy, vcs/vecs = video).
 * This is real engine busyness, not power-state (RC6) residency.
 *
 * Limits: /proc/<pid>/fdinfo is only readable for your own processes (or as
 * root), so work done by other users' processes is not counted.
 *
 * Build:  gcc -O2 -Wall -o gpuload gpuload.c
 * Usage:  ./gpuload [-c cardN | -p PCI_ADDR] [-e class] [-i interval_ms]
 *                   [-a samples] [-n]
 *           -e   only this engine class (rcs, ccs, bcs, vcs, vecs); default: max of all
 *           -a   rolling-average window in samples (default 3)
 *           -m   cosmetic: treat this busy % as 100% (e.g. -m 95); default 100
 *           -n   print the number only, without the % sign
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

#define NC 6
#define MAXC 512
static const char *classes[NC] = { "rcs", "ccs", "bcs", "vcs", "vecs", "other" };

typedef struct {
    char pdev[32];
    unsigned long long id;
    unsigned long long busy[NC];
} client_t;

typedef struct {
    client_t c[MAXC];
    int n;
    unsigned long long total[NC];
    unsigned cap[NC];
} sample_t;

static sample_t sample_a, sample_b;

/* If line starts with prefix, return pointer just after it, else NULL. */
static const char *after(const char *line, const char *prefix)
{
    size_t n = strlen(prefix);
    return strncmp(line, prefix, n) == 0 ? line + n : NULL;
}

/* Class index for the key text up to ':' , or -1. */
static int class_index(const char *s)
{
    const char *colon = strchr(s, ':');
    if (!colon) return -1;
    size_t len = (size_t)(colon - s);
    for (int i = 0; i < NC; i++)
        if (strlen(classes[i]) == len && strncmp(s, classes[i], len) == 0)
            return i;
    return -1;
}

static const char *value(const char *line)
{
    const char *p = strchr(line, ':');
    if (!p) return "";
    p++;
    while (*p == ' ' || *p == '\t') p++;
    return p;
}

static void parse_fdinfo(const char *path, const char *pdev_filter, sample_t *s)
{
    FILE *f = fopen(path, "r");
    if (!f) return;

    char line[256], pdev[32] = "";
    unsigned long long id = 0, busy[NC] = { 0 }, tot[NC] = { 0 };
    unsigned cap[NC] = { 0 };
    int have_id = 0, is_xe = 0;

    while (fgets(line, sizeof line, f)) {
        const char *rest;
        if (after(line, "drm-driver:")) {
            const char *v = value(line);
            is_xe = strncmp(v, "xe", 2) == 0 && !isalnum((unsigned char)v[2]);
            if (!is_xe) break;
        } else if (after(line, "drm-client-id:")) {
            id = strtoull(value(line), NULL, 10);
            have_id = 1;
        } else if (after(line, "drm-pdev:")) {
            snprintf(pdev, sizeof pdev, "%s", value(line));
            pdev[strcspn(pdev, "\r\n")] = 0;
        } else if ((rest = after(line, "drm-total-cycles-"))) {
            int c = class_index(rest);
            if (c >= 0) tot[c] = strtoull(value(line), NULL, 10);
        } else if ((rest = after(line, "drm-cycles-"))) {
            int c = class_index(rest);
            if (c >= 0) busy[c] = strtoull(value(line), NULL, 10);
        } else if ((rest = after(line, "drm-engine-capacity-"))) {
            int c = class_index(rest);
            if (c >= 0) cap[c] = (unsigned)strtoul(value(line), NULL, 10);
        }
    }
    fclose(f);

    if (!is_xe || !have_id) return;
    if (pdev_filter[0] && strcmp(pdev, pdev_filter) != 0) return;

    /* The same client can appear on several fds/processes: count it once. */
    for (int i = 0; i < s->n; i++)
        if (s->c[i].id == id && strcmp(s->c[i].pdev, pdev) == 0)
            return;
    if (s->n >= MAXC) return;

    client_t *cl = &s->c[s->n++];
    snprintf(cl->pdev, sizeof cl->pdev, "%s", pdev);
    cl->id = id;
    for (int k = 0; k < NC; k++) {
        cl->busy[k] = busy[k];
        if (tot[k] > s->total[k]) s->total[k] = tot[k];
        if (cap[k] > s->cap[k]) s->cap[k] = cap[k];
    }
}

static void scan(const char *procroot, const char *pdev, sample_t *s)
{
    memset(s, 0, sizeof *s);
    DIR *pd = opendir(procroot);
    if (!pd) return;

    struct dirent *e;
    while ((e = readdir(pd))) {
        if (!isdigit((unsigned char)e->d_name[0])) continue;

        char fddir[600];
        snprintf(fddir, sizeof fddir, "%.512s/%.32s/fd", procroot, e->d_name);
        DIR *fd = opendir(fddir);
        if (!fd) continue;

        struct dirent *fe;
        while ((fe = readdir(fd))) {
            if (fe->d_name[0] == '.') continue;

            char lp[PATH_MAX], tgt[PATH_MAX], ip[PATH_MAX];
            snprintf(lp, sizeof lp, "%s/%.32s", fddir, fe->d_name);
            ssize_t n = readlink(lp, tgt, sizeof tgt - 1);
            if (n <= 0) continue;
            tgt[n] = 0;
            if (strncmp(tgt, "/dev/dri/", 9) != 0) continue;

            snprintf(ip, sizeof ip, "%.512s/%.32s/fdinfo/%.32s", procroot, e->d_name, fe->d_name);
            parse_fdinfo(ip, pdev, s);
        }
        closedir(fd);
    }
    closedir(pd);
}

static double compute(const sample_t *prev, const sample_t *cur, int only_class)
{
    double busy[NC] = { 0 };

    /* Only clients present in both samples contribute a meaningful delta. */
    for (int i = 0; i < cur->n; i++) {
        const client_t *c = &cur->c[i];
        const client_t *p = NULL;
        for (int j = 0; j < prev->n; j++)
            if (prev->c[j].id == c->id && strcmp(prev->c[j].pdev, c->pdev) == 0) {
                p = &prev->c[j];
                break;
            }
        if (!p) continue;
        for (int k = 0; k < NC; k++)
            if (c->busy[k] > p->busy[k])
                busy[k] += (double)(c->busy[k] - p->busy[k]);
    }

    double best = 0;
    for (int k = 0; k < NC; k++) {
        if (only_class >= 0 && k != only_class) continue;
        if (cur->total[k] <= prev->total[k]) continue;
        double td = (double)(cur->total[k] - prev->total[k]);
        double cap = cur->cap[k] ? cur->cap[k] : 1;
        double u = 100.0 * busy[k] / (td * cap);
        if (u > 100) u = 100;
        if (u > best) best = u;
    }
    return best;
}

/* PCI address (e.g. 0000:03:00.0) of /sys/class/drm/<card>/device, or "". */
static int card_pdev(const char *card, char *out, size_t n)
{
    char p[PATH_MAX], real[PATH_MAX];
    snprintf(p, sizeof p, "/sys/class/drm/%s/device", card);
    if (!realpath(p, real)) return -1;
    const char *base = strrchr(real, '/');
    snprintf(out, n, "%.31s", base ? base + 1 : real);
    return 0;
}

static int is_xe(const char *card)
{
    char p[PATH_MAX], target[PATH_MAX];
    snprintf(p, sizeof p, "/sys/class/drm/%s/device/driver", card);
    ssize_t n = readlink(p, target, sizeof target - 1);
    if (n < 0) return 0;
    target[n] = 0;
    const char *base = strrchr(target, '/');
    base = base ? base + 1 : target;
    return strcmp(base, "xe") == 0;
}

int main(int argc, char **argv)
{
    char card[32] = "", pdev[32] = "", classname[16] = "";
    const char *procroot = "/proc";
    int interval = 1000, window = 3, no_sign = 0, opt;
    double full_scale = 100.0;

    while ((opt = getopt(argc, argv, "c:p:e:i:a:m:r:nh")) != -1) {
        switch (opt) {
        case 'c': snprintf(card, sizeof card, "%s", optarg); break;
        case 'p': snprintf(pdev, sizeof pdev, "%s", optarg); break;
        case 'e': snprintf(classname, sizeof classname, "%s", optarg); break;
        case 'i': interval = atoi(optarg); break;
        case 'a': window = atoi(optarg); break;
        case 'm': full_scale = atof(optarg); break;
        case 'r': procroot = optarg; break;   /* testing: alternate /proc root */
        case 'n': no_sign = 1; break;
        default:
            fprintf(stderr,
                    "Usage: %s [-c cardN | -p PCI_ADDR] [-e class] [-i interval_ms] [-a samples] [-m pct] [-n]\n",
                    argv[0]);
            return opt == 'h' ? 0 : 1;
        }
    }
    if (interval < 100) interval = 100;
    if (window < 1) window = 1;
    if (window > 64) window = 64;
    if (full_scale < 1.0 || full_scale > 100.0) full_scale = 100.0;

    int only_class = -1;
    if (classname[0]) {
        for (int i = 0; i < NC; i++)
            if (strcmp(classname, classes[i]) == 0) only_class = i;
        if (only_class < 0) {
            fprintf(stderr, "Unknown engine class '%s' (rcs, ccs, bcs, vcs, vecs)\n", classname);
            return 1;
        }
    }

    /* Work out which GPU to watch: -p, else -c, else the first xe card. */
    if (!pdev[0]) {
        if (!card[0]) {
            for (int i = 0; i < 16; i++) {
                char c[32];
                snprintf(c, sizeof c, "card%d", i);
                if (is_xe(c)) { snprintf(card, sizeof card, "%s", c); break; }
            }
        }
        if (!card[0] || card_pdev(card, pdev, sizeof pdev) != 0) {
            fprintf(stderr, "No GPU bound to the xe driver found (use -c cardN or -p PCI_ADDR)\n");
            return 1;
        }
    }

    setvbuf(stdout, NULL, _IOLBF, 0);

    sample_t *prev = &sample_a, *cur = &sample_b;
    scan(procroot, pdev, prev);

    double hist[64];
    int hist_n = 0, hist_i = 0;

    for (;;) {
        struct timespec req = { interval / 1000, (interval % 1000) * 1000000L };
        nanosleep(&req, NULL);

        scan(procroot, pdev, cur);
        double load = compute(prev, cur, only_class);

        /* Optional cosmetic calibration: treat `full_scale`% busy as 100%. */
        load = load * 100.0 / full_scale;
        if (load > 100) load = 100;

        sample_t *t = prev; prev = cur; cur = t;

        hist[hist_i] = load;
        hist_i = (hist_i + 1) % window;
        if (hist_n < window) hist_n++;
        double sum = 0;
        for (int k = 0; k < hist_n; k++) sum += hist[k];
        load = sum / hist_n;

        printf(no_sign ? "%.0f\n" : "%.0f%%\n", load);
        fflush(stdout);
    }
}
