#include <stdio.h>

unsigned long fib_iterative(long n){
	unsigned long i=0, a=0, b=1;
	for(i=0 ; i<n ; i++){
		unsigned long tmp = a+b;
		a = b;
		b=tmp;
	}
	return a;
}

int main(int argc, char ** argv){
	printf("fib(10) = %lu \n", fib_iterative(10));
	return 0;
}