#ifndef SRC_GREP_S21_GREP_H_
#define SRC_GREP_S21_GREP_H_

#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <regex.h>

#define ENABLED 1
#define DISABLED 0
#define buffer_size 1024

typedef struct _flags {
    unsigned int e, i, v, c, l, n, h, s, f, o;
    unsigned int special_cases;  // -c, -l and -o flags
} Flags;

typedef struct _files {
    short num_files;
    short num_efiles;  // number of existing files only
    char *file_path[];
} Files;

void init_struct(Flags *flags);
int set_flags(Flags *flags, char **argv, int i, int j);
void read_file(char *file_path, Flags *flags, char *patterns, Files *files);
void store_files(char *file_path, Files *files, Flags *flags);
void store_patterns(char *line, char *patterns, Flags *flags, Files *files);
void parse(int argc, char **argv, Flags *flags, char *patterns, Files *files);
void parse_file(char *patterns, char *file_path, Flags *flags, Files *files);
int find_fe_flag(int argc, char ** argv);
void free_memory(Files *files);

#endif  // SRC_GREP_S21_GREP_H_
