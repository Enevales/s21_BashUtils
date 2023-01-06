CC	=	gcc
FLAGS	=	-Wall -Werror -Wextra -std=c11 -pedantic

all: clean s21_grep tests linter

s21_grep:
		$(CC) $(FLAGS) s21_grep.c -o s21_grep


tests:
		chmod +x grep_tests.sh
		./grep_tests.sh

linter:
		cppcheck *.h *.c
		cp ../../materials/linters/CPPLINT.cfg CPPLINT.cfg
		python3 ../../materials/linters/cpplint.py --extension=c *.c *.h

leaks:
 		CK_FORK=no leaks --atExit -- ./s21_grep -f pattern.txt test-samples/1.txt test-samples/2.txt


valgrind:
		chmod +x ./valgrind_test.sh
		./valgrind_test.sh
sanitizer:
		$(CC) $(FLAGS) -fsanitize=address s21_grep.c -o s21_grep

clean:
		rm -rf s21_grep *.cfg log.txt grep.txt s21_grep.txt valglog.txt
