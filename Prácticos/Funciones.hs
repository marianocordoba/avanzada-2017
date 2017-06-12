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
