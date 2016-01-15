module Part1 where

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