file="test-samples/1.txt"
file1="test-samples/2.txt"
file2="test-samples/3.txt"
TEST_COUNTER=1
echo "" >> valglog.txt

for flag in -b -e -n -s -t -v --number 
    do
        echo "TEST _$TEST_COUNTER"
        TEST_="./s21_cat $flag $file $file1 $file2"
        echo "$TEST"
        valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes -s ./s21_cat $flag $file $file1 $file2 >> valglog.txt
        TEST_COUNTER=$((TEST_COUNTER+=1))
done
