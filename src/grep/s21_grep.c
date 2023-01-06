#include "s21_grep.h"

int main(int argc, char *argv[]) {
    if (argc < 3) {
        fprintf(stderr, "%s", "Too Few Arguments For Grep To Function\n");
    } else if (argc >= 3) {
        Flags flags;   // current set of options
        Files *files = calloc(argc, sizeof(Files));
        char patterns[buffer_size] = "\0";
        init_struct(&flags);
        parse(argc, argv, &flags, patterns, files);
        for (int i = 0; i < files->num_efiles; i++) {
            if (strlen(patterns) != 0)read_file(files->file_path[i], &flags, patterns, files);
        }
        free_memory(files);
    }
    return 0;
}
/* parsing flags, patterns and files */
void parse(int argc, char **argv, Flags *flags, char *patterns, Files *files) {
    int count_fe = find_fe_flag(argc, argv);
    int state = 0;
    for (int i = 1; i != argc; i++) {
        int j = 1;
        if (flags->e) {
            store_patterns(argv[i], patterns, flags, files);
            flags->e = DISABLED;
            state = 1;
        } else if (flags->f) {
            parse_file(patterns, argv[i], flags, files);
            flags->f = DISABLED;
            state = 1;
        } else if (argv[i][0] == '-') {
            if (set_flags(flags, argv, i, j)) store_patterns(argv[i], patterns, flags, files);
        } else if (state == 1) {
            store_files(argv[i], files, flags);
        } else {
            if (count_fe == 0) {
                store_patterns(argv[i], patterns, flags, files);
                count_fe++;  // without -e flag, it reads one pattern only
            } else {
                store_files(argv[i], files, flags);
            }
        }
    }
    if (flags->e || flags-> f) {   // if user's input ends by flag -e or -f
        fprintf(stderr, "grep: option requires an argument --\n");
        fprintf(stderr, "Usage: grep [OPTION]... PATTERNS [FILE]...\n");
        fprintf(stderr, "Try 'grep --help' for more information.'\n");
        exit(EXIT_FAILURE);
    }
}
/* initializing structure */
void init_struct(Flags *flags) {
    flags->e = DISABLED;  // an input line is selected if it matches any of the specified patterns.
    flags->i = DISABLED;  // perform case insensitive matching. By default, grep is case sensitive.
    flags->v = DISABLED;  // selected lines are those not matching any of the specified patterns.
    flags->c = DISABLED;  // output count of matching lines only.
    flags->l = DISABLED;  // only the names of files containing selected lines.
    flags->n = DISABLED;  // each output line is preceded by its relative line number in the file.
    flags->h = DISABLED;  // suppress the file name prefix on output
    flags->s = DISABLED;  // suppress  error  messages  about  nonexistent or unreadable files.
    flags->f = DISABLED;  // obtain patterns from FILE, one per line.
    flags->o = DISABLED;  // print  only  the  matched  (non-empty)  parts of a matching line.
    flags->special_cases = DISABLED;  // flags that excludes other flags such as -o -c -l.
}

/* Setting flags by simple parsing. If -o, -c or -l flags are set on,
then we are enabling *special cases* flag, to deal with a confilcting pairs of flags  */

int set_flags(Flags *flags, char **argv, int i, int j) {
    int flag = 0;
    if (strlen(argv[i]) != strspn(argv[i], "-eivclnhsfo"))
        flag = 1;
    while (argv[i][j] != '\0' && flag == 0) {
        if (argv[i][j] == 'e') {
            flags->e = ENABLED;
        } else if (argv[i][j] == 'i') {
            flags->i = ENABLED;
        } else if (argv[i][j] == 'v') {
            flags->v = ENABLED;
        } else if (argv[i][j] == 'c') {
            flags->c = ENABLED;
            flags->special_cases = ENABLED;
        } else if (argv[i][j] == 'l') {
            flags->l = ENABLED;
            flags->special_cases = ENABLED;
        } else if (argv[i][j] == 'n') {
            flags->n = ENABLED;
        } else if (argv[i][j] == 'h') {
            flags->h = ENABLED;
        } else if (argv[i][j] == 's') {
            flags->s = ENABLED;
        } else if (argv[i][j] == 'f') {
            flags->f = ENABLED;
            flags->e = DISABLED;
        } else if (argv[i][j] == 'o') {
            flags->o = ENABLED;
            flags->special_cases = ENABLED;
        } else {
            if (flags->e) {
                j++;
            } else {
                fprintf(stderr, "grep:  invalid option -- '%c'\n", argv[i][j]);
                fprintf(stderr, "Usage: grep [OPTION]... PATTERNS [FILE]...\n");
                fprintf(stderr, "Try 'grep --help' for more information.'\n");
                exit(EXIT_FAILURE);
            }
        }
        j++;
    }
    return flag;
}

/* find out if there is -f or -e flag */

int find_fe_flag(int argc, char ** argv) {
    int count = 0;
    for (int i = 1; i < argc; i++) {
        if (argv[i][0] == '-') {
            if (strchr(argv[i], 'e')) count++;
            if (strchr(argv[i], 'f')) count++;
        }
    }
    return count;
}

/* storing and counting files, but fistly we check if we have access to the file */
void store_files(char *file_path, Files *files, Flags *flags) {
    files->num_files += 1;  // number of files the user enters, whether they exist or not
    // check if file exist
    FILE *f = fopen(file_path, "r");
    if (!f) {
        if (!flags->s) fprintf(stderr, "grep: %s: No such file or directory\n", file_path);
    } else {
        files->file_path[files->num_efiles] = strdup(file_path);
        files->num_efiles++;
    }
    if (f != NULL) fclose(f);
}

/* storing patterns and dealing with -e<pattern> case */
void store_patterns(char *line, char *patterns, Flags *flags, Files *files) {
    FILE *pf = fopen(line, "r");
    if (pf) {
        if (!flags->f) store_files(line, files, flags);
        fclose(pf);
    } else {
        char *pline = line;
        // if (strspn(line, "-") == 1) {
        //     // pointer to the pattern, that comes immediately after e flag
        //     pline += strchr(line, 'e') - line +1;
        //     if (*pline == '\0') return;
        // }
        if (!strlen(patterns)) {
            if (*pline == 0 && !flags->o) {
                strcpy(patterns, "$");
            } else if (*pline   != 0) {
               strcpy(patterns, pline);
            }
        } else {
            if (*pline == 0 && !flags->o) {
                strcpy(patterns, "$");
            } else if (*pline   != 0) {
               strcat(patterns, "|");
                strcat(patterns, pline);
            }
        }
    }
    flags->e = DISABLED;
}

/* open file and printing what's inside line-by-line considering flags */
void read_file(char *file_path, Flags *flags, char *patterns, Files *files) {
    FILE *pf = fopen(file_path, "r");  // pointer to a file we're going to read
    char *str = NULL;
    short match_count = 0;
    short nomatch_count = 0;
    short count_lines = 0;
    size_t len = 0;
    regex_t reg = {0};
    regmatch_t pmatch = {0, 0};
    int read = 0;
    int error = 0;
    char error_buffer[100];
    int cflags = (flags->i) ? REG_ICASE | REG_EXTENDED : REG_EXTENDED;
    // compiling regular expressions
    if ((error = regcomp(&reg, patterns, cflags)) != 0) {
        regerror(error, &reg, error_buffer, 100);
        printf("regcomp() failed with '%s'\n", error_buffer);
        exit(1);
    }
    if (!pf) {
        if (!flags->s) fprintf(stderr, "grep: %s: No such file or directory\n", file_path);
    } else {
        while ((read = getline(&str, &len, pf)) != -1) {
            int match = 0;
            int no_match = 0;
            count_lines++;

            /* if flag -v is disactivated */
            match = (regexec(&reg, str, 1, &pmatch, 0) != REG_NOMATCH);
            if (match) match_count++;
            if (!flags->v && !flags->special_cases && match) {
                if (!flags->h && files->num_files > 1) printf("%s:", file_path);
                if (flags->n) printf("%d:", match_count + nomatch_count);
                printf("%s", str);
                if (str[strlen(str) - 1] != '\n') putc('\n', stdout);  // if file doesn't end with a newline
            }

            /* if flag -v is activated */
            no_match = (regexec(&reg, str, 1, &pmatch, 0) == REG_NOMATCH);
            if (no_match) nomatch_count++;
            if (flags->v && !flags->special_cases && no_match) {
                if (!flags->h && files->num_files > 1) printf("%s:", file_path);
                if (flags->n) printf("%d:", match_count + nomatch_count);
                printf("%s", str);
                if (str[strlen(str) - 1] != '\n') putc('\n', stdout);  // if file doesn't end with a newline
            }
            /* if flag -o IS activated! */
            if (flags->o && !flags->l && !flags->c && !flags->v && !flags->f) {
                char *substr = str;  // can't modify the string that we're going to free
                while ((regexec(&reg, substr, 1, &pmatch, REG_NOTBOL) != REG_NOMATCH)) {
                    if (files->num_files > 1 && !flags->h) printf("%s:", file_path);
                    if (flags->n) printf("%d:", match_count + nomatch_count);
                    for (int i = (&pmatch)->rm_so; i < (&pmatch)->rm_eo; i++) {
                        putc(substr[i], stdout);
                    }
                    printf("\n");
                    if ((&pmatch)->rm_eo == (&pmatch)->rm_so) break;
                    substr += (&pmatch)->rm_eo;
                }
            }
        }
        regfree(&reg);

        /* if flag -c is activated */
        if (flags->c && !flags->l) {
            if (files->num_files > 1 && !flags->h) printf("%s:", file_path);
            if (!flags->v) printf("%d\n", count_lines - nomatch_count);
            if (flags->v) printf("%d\n", count_lines - match_count);
        }
    }
    /* if flag -l is activated */
    if (match_count > 0 && flags->l && !flags->v) {
        printf("%s\n", file_path);
    } else if (flags->l && flags->v) {
        printf("%s\n", file_path);
    }

    if (str != NULL) free(str);
    if (pf != NULL) fclose(pf);
}

/* if flag -f is set on */

void parse_file(char *patterns, char *file_path, Flags *flags, Files *files) {
    FILE *pf = fopen(file_path, "r");
    char str[500];
    if (!pf) {
        fprintf(stderr, "grep: %s: No such file or directory\n", file_path);
        exit(EXIT_FAILURE);
    } else {
        while (fgets(str, 500, pf)) {
            // to rid of newline at the end of pattern
            char *p = NULL;
            if ((p = strchr(str, '\n')) != NULL) {
                *p = '\0';
                store_patterns(str, patterns, flags, files);
            } else {
                store_patterns(str, patterns, flags, files);
            }
        }
    }
    if (pf != NULL) fclose(pf);
}

void free_memory(Files *files) {
    for (int i = 0; i < files->num_efiles; i++) {
        free(files->file_path[i]);
    }
    free(files);
}
