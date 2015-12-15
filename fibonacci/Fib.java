import java.math.BigInteger;

class Fib {
    public static void main(String args[]){
        if( args.length != 1){
            System.out.println("Please provide a number as the only argument.");
            return;
        }

        long n = Long.parseLong(args[0]);
        System.out.println(fib(n));
    }

    /**
     * Iterative implementation using BigInteger for computing large results
     * 
     * @param n
     * @return fib(n)
     */
    private static BigInteger fib(long n){
        BigInteger a = new BigInteger("0");
        BigInteger b = new BigInteger("1");
        
        for (long i=0 ; i<n ;i++){
            BigInteger tmp = a.add(b);
            a = b;
            b = tmp;
        }

        return a;
    }

    /**
     * Recursive implementation of the fibonacci function
     * 
     * @param n
     * @return fib(n)
     */
    private static BigInteger fibRec(long n){
        if(n == 0)
            return new BigInteger("0");
        if(n == 1)
            return new BigInteger("1");
        return fibRec(n-1).add(fibRec(n-2));
    }
}