module First where

{--
First try implementation.

This just solves the problem.
--}

import Data.List

-- Last element of list
lastElem :: [a] -> a
lastElem (x : [])  = x
lastElem (x : xs)  = lastElem xs

butLastElem :: [a] -> a
butLastElem (x : y : []) = x
butLastElem (x : xs) = butLastElem xs

elementAt :: [a] -> Integer -> a
elementAt [] _          = error "Index out of bound"
elementAt (x : xs) 1    = x -- For some reason it is 1-indexed
elementAt (x : xs) n    = elementAt xs (n-1)

listSize :: [a] -> Integer
listSize [] = 0
listSize (x : xs) = 1 + (listSize xs)

reverseList :: [a] -> [a]
reverseList xs = doReverse [] xs
  where
    doReverse ys []         = ys
    doReverse ys (x : xs)   = doReverse (x : ys) xs

isPalindrome :: Eq a => [a] -> Bool
isPalindrome xs = xs == (reverseList xs)

data NestedList a = Elem a | List [NestedList a]
flattenList :: (NestedList a) -> [a]
flattenList (Elem x)            = [x]
flattenList (List [])           = []
flattenList (List (x : xs))     = (flattenList x) ++ (flattenList  (List xs) )

-- TODO: Implement through combinators
compress :: Eq a => [a] -> [a]
compress xs = doCompress Nothing xs
  where
    doCompress :: Eq a => (Maybe a) -> [a] -> [a]
    doCompress _ [] = []
    doCompress Nothing  (x : xs) = x : (doCompress (Just x) xs)
    doCompress (Just y) (x : xs) | y == x = doCompress (Just y) xs
    doCompress (Just y) (x : xs) | y /= x = x : (doCompress (Just x) xs)

pack :: Eq a => [a] -> [[a]]
pack = group 

encode :: Eq a => [a] -> [(Int, a)]
encode xs = doEncode (pack xs)
  where
    doEncode :: Eq a => [[a]] -> [(Int, a)]
    doEncode []         = []
    doEncode (x:xs)     = (length x, head x) : doEncode xs

data Code a =
     Multiple Int a
   | Single a deriving Show
encodeModed :: Eq a => [a] -> [Code a]
encodeModed xs = doEncodeMod (encode xs)
  where
    doEncodeMod [] = []
    doEncodeMod ((1, x) : xs)    = (Single x) : doEncodeMod xs
    doEncodeMod ((n, x) : xs)    = (Multiple n x) : doEncodeMod xs

decodeMod :: [Code a] -> [a]
decodeMod [] = []
decodeMod ((Single x) : xs)         = x : (decodeMod xs)
decodeMod ((Multiple n x) : xs)     = (doRepeat x n) ++ (decodeMod xs)
  where
    doRepeat x 0 = []
    doRepeat x n = x : (doRepeat x (n-1))

-- Problem 13 admitted: The same as Problem 11?

duplicateElements :: [a] -> [a]
duplicateElements [] = []
duplicateElements (x : xs) = x:x: (duplicateElements xs) 

replicateN :: [a] -> Int -> [a]
replicateN [] _         = []
replicateN (x : xs) n   = (doRepeat x n) ++ (replicateN xs n)
  where
    doRepeat x 0 = []
    doRepeat x n = x : (doRepeat x (n-1))