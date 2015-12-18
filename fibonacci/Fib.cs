public class Fib
{
    public static void Main()
    {
        System.Console.WriteLine(FibRec(10));
    }

    public static int FibRec(int n){
        if(n == 0)
            return 0;
        if(n == 1)
            return 1;
        return FibRec(n-1) + FibRec(n-2);
    }
}