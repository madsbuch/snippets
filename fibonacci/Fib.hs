module Main where

import System.Environment

-- Standard recursive implementaiton, very slow
fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

-- Using an accumulator
fibAcc :: Integer -> Integer
fibAcc n = doFib n (0,1)
    where
        doFib :: Integer -> (Integer, Integer) -> Integer
        doFib 0 (a, b) = a
        doFib n (a, b) = doFib (n-1) (a+b, a)

--main = putStrLn $ show (fibAcc 100000)

main = do
    a <- getArgs
    putStrLn $ show (fibAcc $ read (a !! 0) )
