file="test-samples/1.txt"
file1="test-samples/2.txt"
file2="test-samples/5.txt"
TEST_COUNTER=1
echo "" >> valglog.txt

for flag in -e -i -v -c -l -n -h -s -o
    do
        echo "TEST _$TEST_COUNTER"
        TEST_="./s21_grep $flag 8 $file nonexist.txt $file1 $file2"
        echo "$TEST"
        valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --tool=memcheck -s ./s21_grep $flag 8 $file nonexist.txt $file1 $file2 >> valglog.txt
        TEST_COUNTER=$((TEST_COUNTER+=1))
done

echo "TEST _$TEST_COUNTER"
        TEST_="./s21_grep -f pattern.txt 8 $file $file1 $file2"
        echo "$TEST"
        valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes -s ./s21_grep $flag 8 $file $file1 $file2 >> valglog.txt
        TEST_COUNTER=$((TEST_COUNTER+=1))
rm -rf s21_grep 