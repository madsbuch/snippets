
% Implementation using direct recursion.
fib_direct(0, 0).
fib_direct(1, 1).
fib_direct(N, R) :-
	X1 is N-1,
	X2 is N-2,
	fib_direct(X1, A),
	fib_direct(X2, B),
	R is A + B.

% Definiition of the Peano numbers
nat(0).
nat(s(_)).

% Readable nats
read_nat(0, 0).
read_nat(s(N), R) :-
	read_nat(N, R1),
	R is R1 + 1.

% Definition of addition ( add(A, B, Result ))
add(0, B, B).
add(s(A), B, R) :- add(A, s(B), R).
	
fib_peano(0, 0).
fib_peano(s(0), s(0)).
fib_peano(s(s(N)), R) :-
	fib_peano(N, A),
	fib_peano(s(N), B),
	add(A, B, R).