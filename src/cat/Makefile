CC	=	gcc
FLAGS	=	-Wall -Werror -Wextra -std=c11 -pedantic 

all: clean s21_cat tests linter

s21_cat:
		$(CC) $(FLAGS) s21_cat.c -o s21_cat

tests:
		chmod +x cat_tests.sh
		./cat_tests.sh

linter:
		cppcheck *.h *.c
		cp ../../materials/linters/CPPLINT.cfg CPPLINT.cfg
		python3 ../../materials/linters/cpplint.py --extension=c *.c *.h

leaks:
		CK_FORK=no leaks --atExit -- ./s21_cat -benstv test-samples/1.txt


valgrind:
		chmod +x valgrind_test.sh
		./valgrind_test.sh

sanitizer:
		$(CC) $(FLAGS) -fsanitize=address s21_cat.c -o s21_cat

clean:
		rm -rf s21_cat *.cfg log.txt cat.txt s21_cat.txt
