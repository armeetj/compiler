# Run tests with command-line options which should trigger garbage collection.
# The file `runtime.c` is compiled with garbage collection debugging turned on.

if [ $1 = '-arm64' ]; then
  OPTS='-arch x86_64'
else
  OPTS=
fi

gcc $OPTS -c runtime.c -DGC_DEBUG=1

./compile tests/vectors_test_10.src -init-heap-size 400 > test1.s
gcc $OPTS -c test1.s
gcc $OPTS test1.o runtime.o -o test1
./test1
echo $?

./compile tests/vectors_test_11.src -init-heap-size 800 > test2.s
gcc $OPTS -c test2.s
gcc $OPTS test2.o runtime.o -o test2
echo 41 42 | ./test2
echo $?

./compile tests/vectors_test_15.src -init-heap-size 1200 > test3.s
gcc $OPTS -c test3.s
gcc $OPTS test3.o runtime.o -o test3
./test3
echo $?

rm test1 test2 test3 *.s *.o

