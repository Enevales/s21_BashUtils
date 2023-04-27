#!/bin/bash

TESTS_FAILED=0
TESTS_SUCCEEDED=0
TEST_COUNTER=1
DIFF_RES=""
file="test-samples/1.txt"
file1="test-samples/2.txt"
file2="test-samples/3.txt"
file3="test-samples/4.txt"
echo "TESTS FAILED:" >> log.txt

for flag in -e -i -v -c -l -n -h -s -o
    do
        echo "TEST _$TEST_COUNTER"
        TEST_="$flag 8 $file $file1 $file2 $file3"
        ./s21_grep $TEST_> s21_grep.txt
        grep $TEST_ > grep.txt
        echo "$flag 8 $file $file1 $file2 $file3"
        DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
        if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
                then
                TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
                echo "Test succeeded!"
                else
                TESTS_FAILED=$((TESTS_FAILED+=1))
                echo "Test failed!"
                echo "$flag 8 $file $file1 $file2 $file3" >> log.txt
        fi
        rm s21_grep.txt grep.txt
        TEST_COUNTER=$((TEST_COUNTER+=1))
done

for flag in -e -i -v -c -l -n -h -s -o
    do
    for flag1 in -i -v -c -l -n -h -s -o
    do
    if [ $flag != $flag1 ]
        then
        echo "TEST _$TEST_COUNTER"
        TEST_="$flag 8 $flag1 $file $file1"
        ./s21_grep $TEST_> s21_grep.txt
        grep $TEST_ > grep.txt
        echo "$flag 8 $flag1 $file $file1"
        DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
        if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
                then
                TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
                echo "Test succeeded!"
                else
                TESTS_FAILED=$((TESTS_FAILED+=1))
                echo "Test failed!"
                echo "$flag 8 $flag1 $file $file1" >> log.txt
        fi
        rm s21_grep.txt grep.txt
        TEST_COUNTER=$((TEST_COUNTER+=1))
    fi
    done
done

for flag in -e -i -v -c -l -n -h -s -o
    do
    for flag1 in -i -v -c -l -n -h -s -o
    do
    if [ $flag != $flag1 ]
        then
        echo "TEST _$TEST_COUNTER"
        TEST_="$flag 8 $file $file1 $flag1 $file2 $file3"
        ./s21_grep $TEST_> s21_grep.txt
        grep $TEST_ > grep.txt
        echo "$flag 8  $file $file1 $flag1 $file2 $file3"
        DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
        if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
                then
                TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
                echo "Test succeeded!"
                else
                TESTS_FAILED=$((TESTS_FAILED+=1))
                echo "Test failed!"
                echo "$flag 8  $file $file1 $flag1 $file2 $file3" >> log.txt
        fi
        rm s21_grep.txt grep.txt
        TEST_COUNTER=$((TEST_COUNTER+=1))
    fi
    done
done

#TESTS FOR LINUX SYSTEM ONLY
for flag in -i -v -c -l -n -h -s -o
    do
        echo "TEST _$TEST_COUNTER"
        TEST_="-e 8 -e 1 $flag -e the $file $file1"
        ./s21_grep $TEST_> s21_grep.txt
        grep $TEST_ > grep.txt
        echo "-e 8 -e 1 $flag -e the $file $file1"
        DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
        if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
                then
                TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
                echo "Test succeeded!"
                else
                TESTS_FAILED=$((TESTS_FAILED+=1))
                echo "Test failed!"
                echo "-e 8 -e 1 $flag -e the $file $file1" >> log.txt
        fi
        rm s21_grep.txt grep.txt
        TEST_COUNTER=$((TEST_COUNTER+=1))
done

for flag in -i -v -c -l -n -h -s -o
    do
        echo "TEST _$TEST_COUNTER"
        TEST_="-e 1 -e the $flag -e up $file $file1"
        ./s21_grep $TEST_> s21_grep.txt
        grep $TEST_ > grep.txt
        echo "-e 1 -e the $flag -e up $file $file1"
        DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
        if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
                then
                TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
                echo "Test succeeded!"
                else
                TESTS_FAILED=$((TESTS_FAILED+=1))
                echo "Test failed!"
                echo "-e 1 -e the $flag -e up $file $file1" >> log.txt
        fi
        rm s21_grep.txt grep.txt
        TEST_COUNTER=$((TEST_COUNTER+=1))
done

for flag in i l n h s o f
    do
        echo "TEST _$TEST_COUNTER"
        TEST_="$file1 $flagf pattern.txt $file $file2 $file3"
        ./s21_grep $TEST_> s21_grep.txt
        grep $TEST_ > grep.txt
        echo "$file1 -f$flag pattern.txt $file $file2 $file3"
        DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
        if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
                then
                TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
                echo "Test succeeded!"
                else
                TESTS_FAILED=$((TESTS_FAILED+=1))
                echo "Test failed!"
                echo "$file1 -f$flag pattern.txt $file $file2 $file3" >> log.txt
        fi
        rm s21_grep.txt grep.txt
        TEST_COUNTER=$((TEST_COUNTER+=1))
done

for flag in -i -v -c -l -n -h -s -o
    do
        echo "TEST _$TEST_COUNTER"
        TEST_="-f pattern.txt $file $file1 $flag $file2 $file3"
        ./s21_grep $TEST_> s21_grep.txt
        grep $TEST_ > grep.txt
        echo "-f pattern.txt $file $file1 $flag $file2 $file3"
        DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
        if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
                then
                TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
                echo "Test succeeded!"
                else
                TESTS_FAILED=$((TESTS_FAILED+=1))
                echo "Test failed!"
                echo "-f pattern.txt $file $file1 $flag $file2 $file3" >> log.txt
        fi
        rm s21_grep.txt grep.txt
        TEST_COUNTER=$((TEST_COUNTER+=1))
done

#TESTS FOR LINUX SYSTEM ONLY 
for flag in  i v c l n h s o
    do
    for flag2 in i v c l n h s o
    do
        for flag3 in i v c l n h s o
        do    
        if [ $flag != $flag2 ] && [ $flag != $flag3 ] && [ $flag2 != $flag3 ]
                then
                echo "TEST _$TEST_COUNTER"
                TEST_="-e 8 -$flag$flag2 $file $file1 -e up $file2 $file3 -$flag3"
                ./s21_grep $TEST_> s21_grep.txt
                grep $TEST_ > grep.txt
                echo "-e 8 -$flag$flag2 $file $file1 -e up $file2 $file3 -$flag3"
                DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
                if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
                        then
                        TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
                        echo "Test succeeded!"
                        else
                        TESTS_FAILED=$((TESTS_FAILED+=1))
                        echo "Test failed!"
                        echo "-e 8 -$flag$flag2 $file $file1 -e up $file2 $file3 -$flag3" >> log.txt
                fi
                rm s21_grep.txt grep.txt 
                TEST_COUNTER=$((TEST_COUNTER+=1))
        fi
        done
    done
done

# no such file or directory error

for flag in -i -v -c -l -n -h -s -o
    do
        echo "TEST _$TEST_COUNTER"
        TEST_="coarsely nonexist.txt $flag $file2 $file3"
        ./s21_grep $TEST_> s21_grep.txt
        grep $TEST_ > grep.txt
        echo "coarsely nonexist.txt $flag $file2 $file3"
        DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
        if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
                then
                TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
                echo "Test succeeded!"
                else
                TESTS_FAILED=$((TESTS_FAILED+=1))
                echo "Test failed!"
                echo "coarsely nonexist.txt $flag $file2 $file3" >> log.txt
        fi
        rm s21_grep.txt grep.txt
        TEST_COUNTER=$((TEST_COUNTER+=1))
done

for flag in   -ii -vv -cc -ll -nn -hh -ss -oo
    do
    for flag1 in -ii -vv -cc -ll -nn -hh -ss -oo
    do
    if [ $flag != $flag1 ]
        then
        echo "TEST _$TEST_COUNTER"
        TEST_="$flag 8 $flag1 $file $file1"
        ./s21_grep $TEST_> s21_grep.txt
        grep $TEST_ > grep.txt
        echo "$flag 8 $flag1 $file $file1"
        DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
        if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
                then
                TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
                echo "Test succeeded!"
                else
                TESTS_FAILED=$((TESTS_FAILED+=1))
                echo "Test failed!"
                echo "$flag 8 $flag1 $file $file1" >> log.txt
        fi
        rm s21_grep.txt grep.txt
        TEST_COUNTER=$((TEST_COUNTER+=1))
    fi
    done
done

for flag in  i v c l n h s o
    do
    for flag2 in i v c l n h s o
    do
        for flag3 in i v c l n h s o
        do    
        if [ $flag != $flag2 ] && [ $flag != $flag3 ] && [ $flag2 != $flag3 ]
                then
                echo "TEST _$TEST_COUNTER"
                TEST_="-$flag$flag2 8 -$flag3 $file2 $file3 $file $file1"
                ./s21_grep $TEST_> s21_grep.txt
                grep $TEST_ > grep.txt
                echo "-$flag$flag2 8 -$flag3 $file2 $file3 $file $file1"
                DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
                if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
                        then
                        TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
                        echo "Test succeeded!"
                        else
                        TESTS_FAILED=$((TESTS_FAILED+=1))
                        echo "Test failed!"
                        echo "-$flag$flag2 8 -$flag3 $file2 $file3 $file $file1" >> log.txt
                fi
                rm s21_grep.txt grep.txt 
                TEST_COUNTER=$((TEST_COUNTER+=1))
        fi
        done
    done
done


for flag in  -e -i -v -c -l -n -h -s -o -f
    do
    for flag2 in -e -i -v -c -l -n -h -s -o -f
    do
        for flag3 in -e -i -v -c -l -n -h -s -o -f
        do    
        if [ $flag != $flag2 ] && [ $flag != $flag3 ] && [ $flag2 != $flag3 ]
                then
                echo "TEST _$TEST_COUNTER"
                TEST_="the $file2 $file3 $file $file1 $flag $flag2 $flag3"
                ./s21_grep $TEST_> s21_grep.txt
                grep $TEST_ > grep.txt
                echo "the $file2 $file3 $file $file1 $flag $flag2 $flag3"
                DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
                if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
                        then
                        TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
                        echo "Test succeeded!"
                        else
                        TESTS_FAILED=$((TESTS_FAILED+=1))
                        echo "Test failed!"
                        echo "the $file2 $file3 $file $file1 $flag $flag2 $flag3" >> log.txt
                fi
                rm s21_grep.txt grep.txt 
                TEST_COUNTER=$((TEST_COUNTER+=1))
        fi
        done
    done
done

for flag in i l n h s o f
    do
        echo "TEST _$TEST_COUNTER"
        TEST_="$file1 -$flag pattern.txt $file $file2 $file3 -f"
        ./s21_grep $TEST_> s21_grep.txt
        grep $TEST_ > grep.txt
        echo "$file1 -$flag pattern.txt $file $file2 $file3 -f"
        DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
        if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
                then
                TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
                echo "Test succeeded!"
                else
                TESTS_FAILED=$((TESTS_FAILED+=1))
                echo "Test failed!"
                echo "$file1 -f$flag pattern.txt $file $file2 $file3 -f" >> log.txt
        fi
        rm s21_grep.txt grep.txt
        TEST_COUNTER=$((TEST_COUNTER+=1))
done

echo "TEST _$TEST_COUNTER"
TEST_="the 8 up $file1 $file2 $file3"
./s21_grep $TEST_> s21_grep.txt
grep $TEST_ > grep.txt
echo "the 8 up $file $file1 $file2 $file3"
DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
        then
        TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
        echo "Test succeeded!"
        else
        TESTS_FAILED=$((TESTS_FAILED+=1))
        echo "Test failed!"
        echo "the 8 up $file1 $file2 $file3" >> log.txt
fi
rm s21_grep.txt grep.txt
TEST_COUNTER=$((TEST_COUNTER+=1))


echo "Tests failed=$TESTS_FAILED"
echo "Tests succeeded=$TESTS_SUCCEEDED"

