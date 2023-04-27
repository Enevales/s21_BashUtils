#!/bin/bash

TESTS_FAILED=0
TESTS_SUCCEEDED=0
TEST_COUNTER=1
DIFF_RES=""

for flag in -b -e -n -s -t -v
    do
    for file in test-samples/*
    do
        echo "TEST _$TEST_COUNTER"
        ./s21_cat $flag $file > s21_cat.txt
        cat $flag $file > cat.txt
        echo "$flag $file"
        DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
        if [ "$DIFF_RES" == "Files s21_cat.txt and cat.txt are identical" ]
                then
                TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
                echo "Test succeeded!"
                else
                TESTS_FAILED=$((TESTS_FAILED+=1))
                echo "Test failed!"
                echo "$flag $file" >> log.txt

        fi
        rm s21_cat.txt cat.txt
        TEST_COUNTER=$((TEST_COUNTER+=1))
    done
done

for flag in -b -e -n -s -t -v
    do
    for flag2 in -b -e -n -s -t -v
    do
    if [ $flag != $flag2 ]
        then
        for file in test-samples/*
            do
            echo "TEST _$TEST_COUNTER"
            ./s21_cat $flag $flag2 $file > s21_cat.txt
            cat $flag $flag2 $file > cat.txt
            echo "$flag $flag2 $file"
            DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
            if [ "$DIFF_RES" == "Files s21_cat.txt and cat.txt are identical" ]
                    then
                    TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
                    echo "Test succeeded!"
                    else
                    TESTS_FAILED=$((TESTS_FAILED+=1))
                    echo "Test failed!"
                    echo "$flag $flag2 $file" >> log.txt
            fi
            rm s21_cat.txt cat.txt
            TEST_COUNTER=$((TEST_COUNTER+=1))
        done
    fi
    done    
done

for flag in -b -e -n -s -t -v
    do
    for flag2 in -b -e -n -s -t -v
        do
        for flag3 in -b -e -n -s -t -v
        do
        if [ $flag != $flag2 ] && [ $flag != $flag3 ] && [ $flag2 != $flag3 ]
            then
            for file in test-samples/*
                do
                echo "TEST _$TEST_COUNTER"
                ./s21_cat $flag $flag2 $flag3 $file > s21_cat.txt
                cat $flag $flag2 $flag3 $file > cat.txt
                echo "$flag $flag2 $flag3 $file"
                DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
                if [ "$DIFF_RES" == "Files s21_cat.txt and cat.txt are identical" ]
                        then
                        TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
                        echo "Test succeeded!"
                        else
                        TESTS_FAILED=$((TESTS_FAILED+=1))
                        echo "Test failed!"
                        echo "$flag $flag2 $flag3 $file" >> log.txt
                fi
                rm s21_cat.txt cat.txt
                TEST_COUNTER=$((TEST_COUNTER+=1))
            done
        fi
        done
    done    
done

echo "TEST _$TEST_COUNTER"
for file in test-samples/*
    do
    ./s21_cat -benstv $file > s21_cat.txt
    cat -benstv $file > cat.txt
    echo "-b -e -n -s -t -v $file"
    DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
    if [ "$DIFF_RES" == "Files s21_cat.txt and cat.txt are identical" ]
        then
            TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
            echo "Test succeeded!"
        else
            TESTS_FAILED=$((TESTS_FAILED+=1))
            echo "Test failed!"
            echo "-b -e -n -s -t -v $file" >> log.txt
    fi
    rm s21_cat.txt cat.txt
done

#TESTS FOR LINUX SYSTEM ONLY

# for flag in  -b -e -n -s -t -v --number-nonblank --number -E --squeeze-blank -T
#     do
#     for flag2 in -b -e -n -s -t -v --number-nonblank --number -E --squeeze-blank -T
#     do
#     if [ $flag != $flag2 ]
#         then
#             echo "TEST _$TEST_COUNTER"
#             ./s21_cat $flag $flag2 test-samples/1.txt > s21_cat.txt
#             cat $flag $flag2 test-samples/1.txt > cat.txt
#             echo "$flag $flag2 data-samples/1.txt"
#             DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
#             if [ "$DIFF_RES" == "Files s21_cat.txt and cat.txt are identical" ]
#                     then
#                     TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+=1))
#                     echo "Test succeeded!"
#                     else
#                     TESTS_FAILED=$((TESTS_FAILED+=1))
#                     echo "Test failed!"
#                     echo "$flag $flag2 data-samples/1.txt" >> log.txt
#             fi
#             rm s21_cat.txt cat.txt
#             TEST_COUNTER=$((TEST_COUNTER+=1))
#     fi
#     done    
# done

echo "Tests failed = $TESTS_FAILED"
echo "Tests succeeded = $TESTS_SUCCEEDED"
