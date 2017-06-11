-- Se importa Data.Char para acceder a funciones de manejo de caracteres ASCII
import Data.Char

-- Se define el tipo Bit
data Bit = O | I deriving (Eq, Show)

-- Tamaño de la clave
keySize :: Int
keySize = 8

xor :: Bit -> Bit -> Bit
xor I I = O
xor O O = O
xor _ _ = I

-- Rellena la lista hasta que tenga la longitud deseada
pad :: [a] -> a -> Int -> [a]
pad [] _ _ = []
pad xs x n
  | length xs == n = xs
  | length xs < n = pad (x:xs) x n

-- Convierte un entero en bits
intToBits :: Int -> [Bit]
intToBits 0 = [O]
intToBits 1 = [I]
intToBits n = intToBits (n `div` 2) ++ [a]
  where a | n `mod` 2 == 0 = O
          | otherwise = I

-- Convierte bits en un entero
bitsToInt :: [Bit] -> Int
bitsToInt [] = 0
bitsToInt xs = a + 2 * bitsToInt (init xs)
  where a | (last xs) == O = 0
          | otherwise = 1

-- Convierte un caracter en bits
-- Completa con O hasta tener 7 bits (longitud ASCII)
charToBits :: Char -> [Bit]
charToBits c = pad (intToBits (ord c)) O 7

-- Convierte bits en un caracter
bitsToChar :: [Bit] -> Char
bitsToChar b = chr (bitsToInt b)

-- Convierte un texto en bits
textToBits :: [Char] -> [Bit]
textToBits [] = []
textToBits (x:xs) = charToBits x ++ textToBits xs

-- Convierte bits a texto
-- Separa de a 7 bits (longitud de un caracter ASCII)
bitsToText :: [Bit] -> [Char]
bitsToText [] = []
bitsToText xs = [bitsToChar (take 7 xs)] ++ bitsToText (drop 7 xs)

-- Particiona la lista de bits en chunks de n bits
breakIntoChunks :: [Bit] -> Int -> [[Bit]]
breakIntoChunks [] _ = []
breakIntoChunks xs n = [take n xs] ++ breakIntoChunks (drop n xs) n

-- Une los chunks
joinChunks :: [[Bit]] -> [Bit]
joinChunks [] = []
joinChunks (x:xs) = x ++ joinChunks xs

-- Encripta un chunk
encryptChunk :: [Bit] -> [Bit] -> [Bit]
encryptChunk [] _ = []
encryptChunk (x:xs) (k:ks) = [x `xor` k] ++ encryptChunk xs ks

-- Encrypta los chunks
encryptChunks :: [[Bit]] -> [Bit] -> [[Bit]]
encryptChunks [] _ = []
encryptChunks (x:xs) ks = [encryptChunk x ks] ++ encryptChunks xs ks

-- Alias para encryptChunks
decryptChunks :: [[Bit]] -> [Bit] -> [[Bit]]
decryptChunks xs ks = encryptChunks xs ks

encrypt :: [Char] -> [Bit] -> [Char]
encrypt [] _ = []
encrypt xs ks
  | length ks < keySize = error "La clave tiene un formato incorrecto"
  | otherwise = bitsToText (joinChunks (encryptChunks (breakIntoChunks (textToBits xs) keySize) ks))

-- Alias para encrypt
decrypt :: [Char] -> [Bit] -> String
decrypt xs ks = encrypt xs ks
