/*
 * arc_gpu_usage_rootless.c  (v2 - fixed for Xe's actual fdinfo format)
 *
 * Rootless GPU busy-percentage for an Intel Xe-driven GPU (e.g. Arc B570).
 * No floating point used.
 *
 * IMPORTANT: Xe does NOT use i915's "drm-engine-<name>: <ns> ns" scheme.
 * Per Documentation/gpu/xe/xe-drm-usage-stats.rst, Xe instead exposes, per
 * hardware engine class, TWO monotonic counters:
 *
 *   drm-cycles-<class>:       <RUNTIME>    (GPU cycles this client ran)
 *   drm-total-cycles-<class>: <TIMESTAMP>  (GPU reference clock timestamp,
 *                                           same units, read at the same
 *                                           instant as RUNTIME)
 *
 * Valid <class> values: rcs (render/3D), ccs (compute), bcs (blit/copy),
 * vcs (video decode), vecs (video enhance), other.
 *
 * Busyness is NOT ns-vs-walltime like i915 - it's a pure ratio using the
 * driver's own reference clock:
 *
 *   busy_fraction = (cycles_2 - cycles_1) / (total_cycles_2 - total_cycles_1)
 *
 * taken per-client (matched by drm-client-id across two samples), then
 * summed across all clients using a given engine class (since a single
 * physical engine time-slices between clients rather than running them
 * simultaneously, summing their individual busy fractions approximates
 * that engine's overall occupancy).
 *
 * Rootless because: reading your OWN processes' fdinfo needs no special
 * capability. Only reading OTHER users' fdinfo needs root.
 *
 * Build:
 *   gcc -O2 -Wall -o arc_gpu_usage_rootless arc_gpu_usage_rootless.c
 *
 * Run:
 *   ./arc_gpu_usage_rootless                    (default: card0, 200ms)
 *   ./arc_gpu_usage_rootless /dev/dri/card0 500  (500ms sample window)
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <dirent.h>
#include <ctype.h>
#include <limits.h>
#include <time.h>

#define NUM_CLASSES 6
static const char *CLASS_NAMES[NUM_CLASSES] = { "rcs", "ccs", "bcs", "vcs", "vecs", "other" };

static int class_index(const char *name)
{
    for (int i = 0; i < NUM_CLASSES; i++) {
        if (strcmp(CLASS_NAMES[i], name) == 0)
            return i;
    }
    return -1;
}

/* Per-client sample: cycles/total_cycles for each engine class, plus
 * whether that class was actually present in this client's fdinfo. */
typedef struct {
    uint64_t client_id;
    uint64_t cycles[NUM_CLASSES];
    uint64_t total_cycles[NUM_CLASSES];
    int have[NUM_CLASSES];
} client_record;

typedef struct {
    client_record *items;
    size_t count;
    size_t cap;
} client_list;

static void client_list_free(client_list *l)
{
    free(l->items);
    l->items = NULL;
    l->count = l->cap = 0;
}

static client_record *client_list_find(client_list *l, uint64_t client_id)
{
    for (size_t i = 0; i < l->count; i++) {
        if (l->items[i].client_id == client_id)
            return &l->items[i];
    }
    return NULL;
}

static client_record *client_list_get_or_add(client_list *l, uint64_t client_id)
{
    client_record *existing = client_list_find(l, client_id);
    if (existing)
        return existing; /* dup()/fork()-shared fd - already recorded */

    if (l->count == l->cap) {
        size_t new_cap = l->cap ? l->cap * 2 : 16;
        client_record *grown = realloc(l->items, new_cap * sizeof(client_record));
        if (!grown)
            return NULL;
        l->items = grown;
        l->cap = new_cap;
    }
    client_record *rec = &l->items[l->count++];
    memset(rec, 0, sizeof(*rec));
    rec->client_id = client_id;
    return rec;
}

/* Resolve the PCI bus address (e.g. "0000:03:00.0") for a /dev/dri/cardN or
 * renderDXXX node, purely via sysfs - no need to open the device node. */
static int get_pci_addr_for_dev(const char *dev_path, char *out, size_t outlen)
{
    const char *base = strrchr(dev_path, '/');
    base = base ? base + 1 : dev_path;

    char sysfs_path[PATH_MAX];
    snprintf(sysfs_path, sizeof(sysfs_path), "/sys/class/drm/%s/device", base);

    char resolved[PATH_MAX];
    if (!realpath(sysfs_path, resolved)) {
        fprintf(stderr, "realpath(%s) failed: %s\n", sysfs_path, strerror(errno));
        return -1;
    }

    const char *last = strrchr(resolved, '/');
    last = last ? last + 1 : resolved;
    snprintf(out, outlen, "%s", last);
    return 0;
}

/* Take one snapshot: walk /proc/<pid>/fdinfo/<fd>, and for every fdinfo
 * block belonging to target_pdev, record its drm-cycles-<class> /
 * drm-total-cycles-<class> pairs under its drm-client-id. */
static void snapshot_clients(const char *target_pdev, client_list *out)
{
    DIR *proc = opendir("/proc");
    if (!proc) {
        fprintf(stderr, "opendir(/proc) failed: %s\n", strerror(errno));
        return;
    }

    struct dirent *pid_ent;
    while ((pid_ent = readdir(proc)) != NULL) {
        if (!isdigit((unsigned char)pid_ent->d_name[0]))
            continue;

        char fdinfo_dir[PATH_MAX];
        snprintf(fdinfo_dir, sizeof(fdinfo_dir), "/proc/%s/fdinfo", pid_ent->d_name);

        DIR *fdd = opendir(fdinfo_dir);
        if (!fdd)
            continue;

        struct dirent *fd_ent;
        while ((fd_ent = readdir(fdd)) != NULL) {
            if (fd_ent->d_name[0] == '.')
                continue;

            char fdinfo_path[PATH_MAX + NAME_MAX + 2];
            snprintf(fdinfo_path, sizeof(fdinfo_path), "%s/%s", fdinfo_dir, fd_ent->d_name);

            FILE *f = fopen(fdinfo_path, "r");
            if (!f)
                continue;

            char line[256];
            int is_drm_fd = 0;
            int pdev_matches = 0;
            int have_client_id = 0;
            uint64_t client_id = 0;

            uint64_t cyc[NUM_CLASSES] = {0};
            uint64_t tot[NUM_CLASSES] = {0};
            int have_cyc[NUM_CLASSES] = {0};
            int have_tot[NUM_CLASSES] = {0};

            while (fgets(line, sizeof(line), f)) {
                if (strncmp(line, "drm-pdev:", 9) == 0) {
                    is_drm_fd = 1;
                    char pdev[64];
                    if (sscanf(line + 9, " %63s", pdev) == 1 &&
                        strcmp(pdev, target_pdev) == 0) {
                        pdev_matches = 1;
                    }
                } else if (strncmp(line, "drm-client-id:", 14) == 0) {
                    if (sscanf(line + 14, " %lu", &client_id) == 1)
                        have_client_id = 1;
                } else if (strncmp(line, "drm-total-cycles-", 17) == 0) {
                    char *colon = strchr(line, ':');
                    if (colon) {
                        size_t name_len = (size_t)(colon - (line + 17));
                        char cname[16];
                        if (name_len < sizeof(cname)) {
                            memcpy(cname, line + 17, name_len);
                            cname[name_len] = '\0';
                            int idx = class_index(cname);
                            if (idx >= 0) {
                                unsigned long v = 0;
                                if (sscanf(colon + 1, " %lu", &v) == 1) {
                                    tot[idx] = v;
                                    have_tot[idx] = 1;
                                }
                            }
                        }
                    }
                } else if (strncmp(line, "drm-cycles-", 11) == 0) {
                    char *colon = strchr(line, ':');
                    if (colon) {
                        size_t name_len = (size_t)(colon - (line + 11));
                        char cname[16];
                        if (name_len < sizeof(cname)) {
                            memcpy(cname, line + 11, name_len);
                            cname[name_len] = '\0';
                            int idx = class_index(cname);
                            if (idx >= 0) {
                                unsigned long v = 0;
                                if (sscanf(colon + 1, " %lu", &v) == 1) {
                                    cyc[idx] = v;
                                    have_cyc[idx] = 1;
                                }
                            }
                        }
                    }
                }
            }
            fclose(f);

            if (!is_drm_fd || !pdev_matches || !have_client_id)
                continue;

            client_record *rec = client_list_get_or_add(out, client_id);
            if (!rec)
                continue;

            for (int i = 0; i < NUM_CLASSES; i++) {
                if (have_cyc[i] && have_tot[i]) {
                    rec->cycles[i] = cyc[i];
                    rec->total_cycles[i] = tot[i];
                    rec->have[i] = 1;
                }
            }
        }
        closedir(fdd);
    }
    closedir(proc);
}

/* Compute the summed busy percentage for one engine class across all
 * clients present in BOTH snapshots. Returns -1 if the class was not
 * present for any matched client (i.e. unsupported/unused on this GPU). */
static int class_percent(client_list *snap1, client_list *snap2, int class_idx)
{
    int any_present = 0;
    uint64_t percent_sum = 0;

    for (size_t i = 0; i < snap2->count; i++) {
        client_record *c2 = &snap2->items[i];
        if (!c2->have[class_idx])
            continue;

        client_record *c1 = client_list_find(snap1, c2->client_id);
        if (!c1 || !c1->have[class_idx])
            continue; /* can't compute a delta for a client not seen twice */

        any_present = 1;

        uint64_t d_cycles = (c2->cycles[class_idx] > c1->cycles[class_idx])
                                ? (c2->cycles[class_idx] - c1->cycles[class_idx]) : 0;
        uint64_t d_total = (c2->total_cycles[class_idx] > c1->total_cycles[class_idx])
                                ? (c2->total_cycles[class_idx] - c1->total_cycles[class_idx]) : 0;

        if (d_total == 0)
            continue;

        uint64_t pct = (d_cycles * 100ULL) / d_total;
        percent_sum += pct;
    }

    if (!any_present)
        return -1;

    if (percent_sum > 100)
        percent_sum = 100;

    return (int)percent_sum;
}

int main(int argc, char **argv)
{
    const char *dev_path = (argc > 1) ? argv[1] : "/dev/dri/card0";
    long interval_ms = (argc > 2) ? atol(argv[2]) : 200;
    if (interval_ms <= 0)
        interval_ms = 200;

    char pci_addr[PATH_MAX];
    if (get_pci_addr_for_dev(dev_path, pci_addr, sizeof(pci_addr)) != 0)
        return 1;

    client_list snap1 = {0};
    client_list snap2 = {0};

    snapshot_clients(pci_addr, &snap1);

    struct timespec req;
    req.tv_sec = interval_ms / 1000;
    req.tv_nsec = (interval_ms % 1000) * 1000000L;
    nanosleep(&req, NULL);

    snapshot_clients(pci_addr, &snap2);

    int rcs_idx = class_index("rcs");
    int ccs_idx = class_index("ccs");

    int rcs_pct = class_percent(&snap1, &snap2, rcs_idx);
    int ccs_pct = class_percent(&snap1, &snap2, ccs_idx);

    int best = -1;
    if (rcs_pct > best) best = rcs_pct;
    if (ccs_pct > best) best = ccs_pct;

    /* Fallback: neither render nor compute engines showed up for any
     * matched client - check every other class before giving up. */
    if (best < 0) {
        for (int i = 0; i < NUM_CLASSES; i++) {
            int pct = class_percent(&snap1, &snap2, i);
            if (pct > best)
                best = pct;
        }
    }

    if (best < 0)
        best = 0; /* no clients using the GPU at all during the sample window */

    printf("%d%%\n", best);

    client_list_free(&snap1);
    client_list_free(&snap2);
    return 0;
}
