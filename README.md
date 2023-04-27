# Cat and Grep
---
Implementation of two bash utilities: Cat and Grep;

An educational project designed to teach the organization of the Bash utilities and solidify knowledge of structured programming.
These utilities (cat and grep) are often used in the Linux terminal. 


#### Overview:
---
- Cat is an UNIX command-line utility for displaying files, combining copies of them and creating new ones. Cat GNU Coreutils was taken as a model for the development of the utility.
- Grep is an UNIX command-line utility that searches the given files for lines containing a match to a given pattern list.


#### Technological description:
---
- The programs were developed in C language of C11 standard using gcc compiler. Based on the POSIX.1-2017 standard.
- Integrated tests cover all flag variants and input values, based on a comparison with the behavior of real Bash utilities.
- Third-party libraries used: none
- Supported systems: Linux-based systems

#### cat Usage: 
---
installation:
> $ cd src/cat
> $ make

`$ s21_cat [OPTIONS] [FILE]...`


#### cat Options:
---

| Options  | Description  |
|---|---|
| -b (GNU: --number-nonblank)  | numbers only non-empty lines  |
| -n (GNU: --number)  | number all output lines  |
| -s (GNU: --squeeze-blank)  | squeeze multiple adjacent blank lines  |
| -t implies -v (GNU: -T the same, but without implying -v)  | but also display tabs as ^I  |
|  -e implies -v (GNU only: -E the same, but without implying -v) | but also display end-of-line characters as $  |


#### cat Demo:
---

![](/misc/cat.gif)

#### grep Usage:
---

installation:
> $ cd src/grep
> $ make

`$ s21_grep [OPTIONS] TEMPLATE [FILES]...`


#### grep Options:
---

| Options  | Description   |
|---|---|
| -e  | pattern  |
| -i | Ignore uppercase vs. lowercase.  |
| -v  | Invert match. |
| -c | Output count of matching lines only. |
| -l  | Output matching files only.  |
| -n  | Precede each matching line with a line number.  |
| -h  | Output matching lines without preceding them by file names.  |
| -s  | Suppress error messages about nonexistent or unreadable files.  |
| -f  | Take regexes from a file.  |
| -o  | Output the matched parts of a matching line  |


#### grep Demo:
---

![](/misc/grep.gif)


#### Languages and Tools: 
---
<div>
<img src="https://github.com/devicons/devicon/blob/master/icons/c/c-original.svg" title="C" alt="C" width="20" height="20"/>&nbsp;
<img src="https://github.com/devicons/devicon/blob/master/icons/bash/bash-plain.svg" title="bash" alt="bash" width="20" height="20"/>&nbsp;
</div>