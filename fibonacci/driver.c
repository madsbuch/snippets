#include <stdio.h>
// This program is for testing other languages support for exporting
// functions. it simply forward declares the function and tries to
// call it.

// Forward decleration of the Fibonacci function
int fib(int n);

int main(int argc, char ** argv){
  printf("fib(5) = %d \n", fib(5));
  printf("fib(10) = %d \n", fib(10));
  return 0;
}
