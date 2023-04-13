#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>
#include <sys/stat.h>

int has_media_files(char *path) {
    struct dirent *entry;
    DIR *dir = opendir(path);
    int valid = 0;
    while ((entry = readdir(dir)) != NULL) {
        if (entry->d_name[0] == '.') continue;
        if (entry->d_type == DT_REG) {
            char *ext = strrchr(entry->d_name, '.');
            if (ext && (strcmp(ext, ".mkv") == 0 || strcmp(ext, ".mp4") == 0 || strcmp(ext, ".avi") == 0)) {
                valid = 1;
                break;
            }
        }
    }
    closedir(dir);
    return valid;
}

void delete_folder(char *path) {
    printf("Deleting folder: %s\n", path);
    char cmd[1024];
    snprintf(cmd, sizeof(cmd), "rm -rf \"%s\"", path);
    system(cmd);
}

void delete_folders(char *root) {
    struct dirent *entry;
    DIR *dir = opendir(root);
    while ((entry = readdir(dir)) != NULL) {
        if (entry->d_name[0] == '.') continue;
        char path[1024];
        snprintf(path, sizeof(path), "%s/%s", root, entry->d_name);
        if (entry->d_type == DT_DIR) {
            if (has_media_files(path)) {
                delete_folders(path);
            } else {
                delete_folder(path);
            }
        }
    }
    closedir(dir);
}

void delete_zip_files(char *path) {
    struct dirent *entry;
    DIR *dir = opendir(path);
    while ((entry = readdir(dir)) != NULL) {
        if (entry->d_name[0] == '.') continue;
        char full_path[1024];
        snprintf(full_path, sizeof(full_path), "%s/%s", path, entry->d_name);
        if (entry->d_type == DT_REG) {
            char *ext = strrchr(entry->d_name, '.');
            if (ext && (strcmp(ext, ".zip") == 0)) {
                printf("Deleting file: %s\n", full_path);
                remove(full_path);
            }
        }
    }
    closedir(dir);
}

int main() { // change the paths accoding to your needs
    delete_folders("/home/siyia/Βίντεο");
    delete_zip_files("/home/siyia/Firefox");
    return 0;
}

