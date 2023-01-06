#include "s21_cat.h"

int main(int argc, char* argv[]) {
    Flags flags;  // current set of Flags
    init_struct(&flags);
    Files *files = calloc(argc, sizeof(Files));
    if (argc < 2) {
        // no argument passed, hence we print error message on the output screen
        fprintf(stderr, "%s", "No Extra Command Line Argument Passed\n");
    } else if (argc >= 2) {
        for (int i = 1; i != argc; i++) {
            int j = 1;
            if (argv[i][0] == '-') {
                set_options(&flags, argv, i, j);
            } else {
                store_files(argv[i], files);
            }
        }
        for (int i = 0; i < files->num_files; i++) {
            read_file(files->file_path[i], &flags);
        }
    }
    free_memory(files);
    return 0;
}

// initializing structure
void init_struct(Flags *flags) {
    flags -> v = DISABLED;   // display non-printing characters so they are visible.
    flags -> b = DISABLED;   // numbers only non-empty lines
    flags -> e = DISABLED;   // display non-printing characters and $ at the end of each line.
    flags -> n = DISABLED;   // number all output lines
    flags -> s = DISABLED;   // squeeze multiple adjacent blank lines
    flags -> t = DISABLED;   // but also display tabs as ^I
}

/* setting options(flags), GNU flags are included. */
void set_options(Flags *flags, char **argv, int i, int j) {
     while (argv[i][j] != '\0') {
        if (argv[i][j] == 'v') {
            flags -> v = ENABLED;
        } else if (!strcmp(argv[i], "--number")) {
            flags -> n = ENABLED;
            break;
        } else if (!strcmp(argv[i], "--number-nonblank")) {
            flags -> b = ENABLED;
            break;
        } else if (!strcmp(argv[i], "--squeeze-blank")) {
            flags -> s = ENABLED;
            break;
        } else if (argv[i][j] == 'n') {
                flags -> n = ENABLED;
        } else if (argv[i][j] == 'b') {
            flags -> b = ENABLED;
        } else if (argv[i][j] == 's') {
            flags -> s = ENABLED;
        } else if (argv[i][j] == 'e') {
            flags -> e = ENABLED;
            flags -> v = ENABLED;
        } else if (argv[i][j] == 't') {
            flags -> t = ENABLED;
            flags -> v = ENABLED;
        } else if (argv[i][j] == 'T') {
            flags -> t = ENABLED;
        } else if (argv[i][j] == 'E') {
            flags -> e = ENABLED;
        } else {
            continue;
        }
        j++;
     }
}

void read_file(char *file_address, Flags *flags) {
    FILE *pf = fopen(file_address, "r");  // pointer to a file we're going to read
    char previous_char = '\n';
    int extra_blank_line = 0; int c = 0;
    int count_lines = 1;
    if (!pf) {  // if there is no such a file;
        fprintf(stderr, "%s", "No such file or directory\n");
    } else {
        for (; (c = fgetc(pf)) != EOF; previous_char = c) {
            /* flag -s */
            if (flags -> s && previous_char == '\n' && c == '\n') {
                if (extra_blank_line) {
                    continue;
                } else {
                    extra_blank_line = 1;
                }
            } else if (flags -> s && previous_char == '\n' && c != '\n') {
                extra_blank_line = 0;
            }
            /* flags -b and -n */
            if (previous_char == '\n' && ((flags -> n && !flags -> b) || (flags -> b && c != '\n'))) {
                printf("%6d\t", count_lines);
                count_lines++;
            }
            if (flags -> e && c == '\n') {  // flag -e
                printf("%c", '$');
            }
            if (flags -> t && c == '\t') {  // flag -t
                printf("%s", "^I");
                c = '\0'; continue;
            }
            if (flags -> v) {  // flag -v
                if (c <= 31 && c != 9 && c != 10) {
                    putchar('^'); c += 64;
                } else if (c >= 128 && c <= 159) {
                    putchar('M'); putchar('-'); putchar('^'); c += 64;
                } else if (c == 127) {
                    putchar('^'); c -= 64;
                }
            }
            printf("%c", c);
        }
        fclose(pf);
    }
}

/* storing and counting files, but fistly we check if we have access to the file */
void store_files(char *file_path, Files *files) {
    // check if file exist
    FILE *f = fopen(file_path, "r");
    if (!f) {
        fprintf(stderr, "%s: %s", file_path, "No such file or directory\n");
    } else {
        files->file_path[files->num_files] = strdup(file_path);
        files->num_files++;
    }
    if (f != NULL) fclose(f);
}

void free_memory(Files *files) {
    for (int i = 0; i < files->num_files; i++) {
        free(files->file_path[i]);
    }
    free(files);
}
