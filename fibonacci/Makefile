Fib.class: Fib.java 
	javac Fib.java

java-test: Fib.class
	java Fib 42

haskell-fib: Fib.hs 
	ghc Fib.hs -o haskell-fib

haskell-test: haskell-fib
	./haskell-fib 42

clean:
	rm -rf Fib.class Fib.hi Fib.o haskell-fib