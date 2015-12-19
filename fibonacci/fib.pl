
% Implementation using direct recursion.
fib_direct(0, 0).
fib_direct(1, 1).
fib_direct(N, R) :-
	X1 is N-1,
	X2 is N-2,
	fib_direct(X1, A),
	fib_direct(X2, B),
	R is A + B.

