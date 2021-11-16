#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <ctype.h>
#include <dirent.h>
#include <unistd.h>

void rename_all(DIR* dir, const char* baseName);

const char* options = "hvsLIi";
const char* helpStr =
    "Description:\n"
    "\tRenames all files inside the given folders to their lower (default),\n"
    "\tupper or inverse case equivalents\n"
    "Usage:\n"
    "\tbulk-rename [-hvsLIi] parent-dir [more-parent-dirs]\n"
    "Options:\n"
    "\t-h: Prints this helpful text and exits\n"
    "\t-v: Enables verbose mode\n"
    "\t-s: Enables silent mode\n"
    "\t-L: Enables uppercase mode\n"
    "\t-I: Enables inverse-case mode\n"
    "\t-i: Same as -I, but only for multi-case names (leaves others unchanged)\n";

int printMode = 1;
int caseMode = 0;
char answer;


void changeCase(char* str);

int main(int argc, char* argv[])
{
    int opt = 0;
    while((opt = getopt(argc, argv, options)) != -1) {
        switch (opt) {
            case 'h':
                printf(helpStr);
                exit(0);
            break;
            case 'v':
                printMode = 2;
            break;
            case 's':
                printMode = 0;
            break;
            case 'L':
                caseMode = 1;
            break;
            case 'I':
                caseMode = 2;
            break;
            case 'i':
                caseMode = 3;
            break;
            case '?':
            default:
                fprintf(stderr, "Error: Unknown options character '%c'\n", optopt);
                exit(-1);
        }
    }

    if (optind == argc) {
        fprintf(stderr, "Error: Expected parent-dir\n");
        exit(-1);
         
        
    }
    
printf("!!! WARNING OPERATION IRREVERSIBLE !!! \nAre you sure you want to rename the specified target(s) & everything beneath? \nEnter 'y' to commence or 'n' to abort operation \n");
scanf(" %c", &answer);

    if (answer == 'y')
    
    {
	

    for (int i = optind; i < argc; ++i) {
        int len = strlen(argv[i]);
        if (argv[i][len - 1] == '/') {
            argv[i][len - 1] = '\0';
        }

        DIR *baseDir = opendir(argv[i]);
        if (!baseDir) {
            perror(argv[i]);
            exit(-1);
        }

        rename_all(baseDir, argv[i]);
        closedir(baseDir);

        if (printMode > 0) {
            printf("Renamed everything inside \"%s\"\n", argv[i]);
        }

        char* newName = malloc(len + 1);
        strcpy(newName, argv[i]);
        
        char* temp = newName + len;
        for (;;) {
            if (temp <= newName) {
                break;
            }
            if (*temp == '/') {
                ++temp;
                break;
            }
            --temp;
        }
        changeCase(temp);

        if (strcmp(argv[i], newName) != 0) {
            int result = rename(argv[i], newName);
            if (result == 0) {
                if (printMode > 1) {
                    printf("Renamed \"%s\" to \"%s\"\n", argv[i], newName);
                }
            } else {
                perror(argv[i]);
                fprintf(stderr, "Continue (Y/n)? ");
                char answer = 'y';
				scanf(" %c", &answer);
				answer = tolower(answer);
                if (answer == 'n') {
                    exit(-1);
                }
            }
        }

        free(newName);

    }
}
if (answer == 'n'){
	
	printf("\nOperation cancelled by the User\n");
	exit(-1);
	
	}

    return 0;
}

void rename_all(DIR* dir, const char* baseName)
{
    errno = 0;
    struct dirent* curEntry = readdir(dir);
    if (errno != 0) {
        perror(baseName);
        exit(-1);
    }

    while (curEntry) {
        if (strcmp(curEntry->d_name, ".") != 0 &&
            strcmp(curEntry->d_name, "..") != 0) {
            char* oldName = malloc(strlen(baseName) + strlen(curEntry->d_name) + 2);
            strcpy(oldName, baseName);
            strcat(oldName, "/");
            strcat(oldName, curEntry->d_name);

            char* newName = malloc(strlen(oldName) + 1);
            strcpy(newName, oldName);

            char* temp = newName + strlen(baseName) + 1;
            changeCase(temp);

            if (curEntry->d_type == DT_DIR) {
                DIR *baseDir = opendir(oldName);
                if (!baseDir) {
                    perror(oldName);
                    exit(-1);
                }

                rename_all(baseDir, oldName);
                closedir(baseDir);

                if (printMode > 0) {
                    printf("Renamed everything inside \"%s\"\n", oldName);
                }
            }

            if (strcmp(oldName, newName) != 0) {
                int result = rename(oldName, newName);
                if (result == 0) {
                    if (printMode > 1) {
                        printf("Renamed \"%s\" to \"%s\"\n", oldName, newName);
                    }
                } else {
                    perror(oldName);
                    fprintf(stderr, "Continue (Y/n)? ");
                    char answer = 'y';
					scanf(" %c", &answer);
					answer = tolower(answer);
                    if (answer == 'n') {
                        exit(-1);
                    }
                }
            }

            free(oldName);
            free(newName);
        }

        errno = 0;
        curEntry = readdir(dir);
        if (errno != 0) {
            perror(baseName);
            exit(-1);
        }
    }
}

void changeCase(char* str)
{
    if (caseMode == 3) {
        int curCase = 0;
        for (int i = 0; str[i] != '\0'; ++i) {
            if (isupper(str[i])) {
                curCase |= 1;
            } else if (islower(str[i])) {
                curCase |= 2;
            }
        }
        if (curCase != 3) {
            return;
        }
    }

    while (*str != '\0') {
        switch (caseMode) {
            case 0:
                *str = tolower(*str);
            break;
            case 1:
                *str = toupper(*str);
            break;
            case 2:
            case 3:
                if (isupper(*str)) {
                    *str = tolower(*str);
                } else {
                    *str = toupper(*str);
                }
            break;
        }
        ++str;
    }
}
