#ifndef SRC_CAT_S21_CAT_H_
#define SRC_CAT_S21_CAT_H_

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define ENABLED 1
#define DISABLED 0

#define is_control(ch) (ch <= 31 && ch != 9 && ch != 10)  // checking for control character
#define is_meta(ch) (ch > 127 && ch <= 159)  // checking for meta-character (Non-ASCII) character
#define is_del(ch) (ch == 127)  // checking for delete character

typedef struct _options {
    unsigned int b, e, n, s, t, v;
} Flags;

typedef struct _files {
    short num_files;  // number of existing files only
    char *file_path[];
}Files;

void init_struct(Flags *flags);
void set_options(Flags *flags, char **option, int position, int j);
void read_file(char *file_address, Flags *flags);
void store_files(char *file_path, Files *files);
void free_memory(Files *files);

#endif  // SRC_CAT_S21_CAT_H_
