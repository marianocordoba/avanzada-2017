-------------------------------------------------
--                 Practica 8                  --
-------------------------------------------------

-- Ejercicio 1.1
equals :: Eq a => [a] -> Bool
equals [] = True
equals [x] = True
equals (x:xs) = head xs == x && equals xs

-- Ejercicio 1.2
inList :: Eq a => [a] -> a -> Bool
inList [] _ = False
inList (x:xs) y = x == y || inList xs y

-- Ejercicio 1.3
allEqualTo :: Eq a => [a] -> a -> Bool
allEqualTo [] _ = True
allEqualTo (x:xs) y = x == y && allEqualTo xs y

-- Ejercicio 1.3
compareLists :: Eq a => [a] -> [a] -> Bool
compareLists [] [] = True
compareLists (x:xs) [] = False
compareLists [] (y:ys) = False
compareLists (x:xs) (y:ys) = length xs == length ys &&
                             x == y &&
                             compareLists xs ys

-------------------------------------------------

-- Ejercicio 2
isAsc :: Ord a => [a] -> Bool
isAsc [] = True
isAsc [x] = True
isAsc (x:xs) = x < head xs && isAsc xs

-------------------------------------------------

-- Ejercicio 3

minList :: [Int] -> Int
minList [] = maxBound
minList (x:xs) = x `min` (minList xs)

-------------------------------------------------

-- Ejercicio 4
equalSum :: [Int] -> Bool
equalSum xs = equalSum' xs 0

equalSum' :: [Int] -> Int -> Bool
equalSum' [] _ = False
equalSum' (x:xs) n = x == n + sum(xs) || equalSum' xs (x + n)

-------------------------------------------------

-- Ejercicio 5

isSegment :: Eq a => [a] -> [a] -> Bool
isSegment [] ys = True
isSegment (x:xs) [] = False
isSegment (x:xs) (y:ys) = (x == y && isSegment' xs ys) || isSegment (x:xs) ys

isSegment' :: Eq a => [a] -> [a] -> Bool
isSegment' [] ys = True
isSegment' (x:xs) [] = False
isSegment' (x:xs) (y:ys) = x == y && isSegment' xs ys

-------------------------------------------------

-- Ejercicio 6

isSumSegment :: [Int] -> Bool
isSumSegment xs = isSumSegment' 0 xs

isSumSegment' :: Int -> [Int] -> Bool
isSumSegment' n [] = n == 0
isSumSegment' n (x:xs) = x + (sum xs) == n || isSumSegment' (x + n) xs 

-------------------------------------------------

-- Ejercicio 7

minDif :: [Int] -> [Int] -> Int
minDif [] ys = maxBound
minDif xs [] = maxBound
minDif (x:xs) (y:ys) = (abs (x - y)) `min` minDif xs ys

-------------------------------------------------

-- Ejercicio 8

countEvenOdd :: [Int] -> (Int, Int)
countEvenOdd [] = (0,0)
countEvenOdd (x:xs) 
    | x `mod` 2 == 0 = (1 + a, b)
    | otherwise = (a, 1 + b)
    where (a, b) = countEvenOdd xs