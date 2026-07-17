-- Declarative Programming
-- Degree in Computer Engineering - Information Technologies
-- September Exam                          September 12, 2019
-- -------------------------------------------------------------------
-- Surnames:
-- Name:
-- -------------------------------------------------------------------
-- IMPORTANT NOTICES
-- · 1. Before continuing, change the name of this file to:
--                   Septiembre_<uvus>.hs
--   where <uvus> must be your virtual username.
-- · 2. Write the solution to each exercise in the space reserved for
--   it.
-- · 3. Make sure you correctly use the name and type indicated
--   for each requested function. You may add as many helper
--   functions (including the type properly) as you need,
--   describing their purpose.
--   4. It is recommended to submit a file that loads correctly,
--   leaving all code with errors commented out.
-- -------------------------------------------------------------------

{-# LANGUAGE OverloadedStrings #-}

import TADPila
import CodeWorld
import System.Environment (getArgs)
import qualified Data.ByteString.Lazy as B
import Text.CSV
import Data.Matrix

-- ---------------------------------------------------------------------
-- Exercise 1. [2 points]
-- -------------------------------------------------------------------
-- Consider the function multFuncPrimerosNValidos
-- :: (Num a, Num b) => Int -> (a -> b) -> (a -> Bool) -> [a] -> b
-- such that (multFuncPrimerosNValidos n f p xs) returns the product of the
-- results of applying function f to the first n elements of xs
-- that satisfy predicate p.
--
-- For example:
--    multFuncPrimerosNValidos_1 2 (4+) even [1..7]  => 48
-- 
-- (The first two even numbers in [1..7] are 2 and 4,
--  which after applying (4+) become 6 and 8, whose product is 48)

-- It is requested to define the function:
-- 1. using map and filter,
-- 2. by recursion,
-- 3. by recursion with an accumulator,
-- 4. by folding (left or right).
-- ---------------------------------------------------------------------


-- The definition with a list comprehension (not required in the exercise) is
multFuncPrimerosNValidos_0 :: (Num a, Num b) => Int -> (a -> b) -> (a -> Bool) -> [a] -> b
multFuncPrimerosNValidos_0 n f p xs = product (take n [f x | x <- xs, p x])
 
-- The definition with map and filter is
multFuncPrimerosNValidos_1 :: (Num a, Num b) => Int -> (a -> b) -> (a -> Bool) -> [a] -> b
multFuncPrimerosNValidos_1 n f p xs = product (take n (map f (filter p xs)))
 
-- The recursive definition is
multFuncPrimerosNValidos_2 :: (Num a, Num b) => Int -> (a -> b) -> (a -> Bool) -> [a] -> b
multFuncPrimerosNValidos_2 0 _ _ _ = 1
multFuncPrimerosNValidos_2 _ _ _ [] = 1
multFuncPrimerosNValidos_2 n f p (x:xs)
  | p x = f x * multFuncPrimerosNValidos_2 (n-1) f p xs
  | otherwise = multFuncPrimerosNValidos_2 n f p xs
 
-- The folding definition is
multFuncPrimerosNValidos_3 :: (Num a, Num b) => Int -> (a -> b) -> (a -> Bool) -> [a] -> b
multFuncPrimerosNValidos_3 n f p xs = foldr (\x y -> f x * y) 1 (take n (filter p xs))

-- The accumulator-based definition is
multFuncPrimerosNValidos_4 :: (Num a, Num b) => Int -> (a -> b) -> (a -> Bool) -> [a] -> b
multFuncPrimerosNValidos_4 n f p xs = aux 1 (zip xs (replicate (length xs) n))
  where aux acc [] = acc
        aux acc ((x,y):xs) = aux nacc nxs
          where cumple = y > 0 && p x
                nacc = if cumple then (acc*f x) else acc
                nxs = if cumple then [(x,y-1) | (x,_)<- xs] else xs

-- The left-fold definition (not required, since we already had foldr) is
multFuncPrimerosNValidos_5 :: (Num a, Num b) => Int -> (a -> b) -> (a -> Bool) -> [a] -> b
multFuncPrimerosNValidos_5 n f p xs = foldl (\acc x -> acc * f x) 1 (take n (filter p xs))

-- -------------------------------------------------------------------
-- Exercise 2. [1 point]
-- -------------------------------------------------------------------
-- Develop an animation using CodeWorld, so that the scene
-- includes the coordinate axes, a stationary thick rectangle,
-- and a filled circle of another color that rotates around
-- the static rectangle.
-- -------------------------------------------------------------------

anima = animationOf escena

escena :: Double -> Picture
escena t = cuadradoMovil t & fondo & ejes
-- It was decided to keep the coordinate axes

tam = 10

tamCuad :: Int
tamCuad = 1

fondo :: Picture
fondo = coloured azure $ cuadrado (2*(tam-3))

ejes :: Picture
ejes = coordinatePlane

cuadrado :: Double -> Picture
cuadrado n = coloured azure (thickRectangle 0.5 n n)

caminoCircular :: Picture -> Double -> Picture
caminoCircular d a =
  rotated a (translated 6 0 (rotated (-a) d))
  
cuadradoMovil :: Double -> Picture
cuadradoMovil t = caminoCircular (solidCircle 2) ((pi/3) * 0 + t)


-----------------------------------------------------------------------
-- Exercise 3. [2 points]
-- -------------------------------------------------------------------
-- Develop a main program that reads from the file passed
-- as an argument (if none is passed, from "atp_players.csv"),
-- parses it and then does the following with the valid rows
-- of the file:

-- a) Print on screen the number of players in the file.
--    Next, print the names of the fields contained in the
--    file, as follows:

--    "ID" (field 1)
--    "name" (field 2)
--    ...

-- b) Process the records, selecting
--    those that are Spanish (ESP), left-handed (L), and born in the 80s,
--    and for each of them print the name, surname, and
--    date of birth.

-----------------------------------------------------------------------

jugadores :: IO ()
jugadores = do
  args <- getArgs
  let filename = if null args then "atp_players.csv" else args!!0
  contents <- readFile filename

  let csv = parseCSV filename contents
      filas = case csv of
        (Left _) -> []
        (Right lineas) -> lineas
      filasValidas = filter (\x -> length x == 6) filas

  putStrLn $ "There are " ++ show (length filasValidas) ++ " players"
 
  procesaCabecera (head filasValidas)
  procesaContenido (tail filasValidas)

pasaALista :: Field -> [String]
pasaALista cadena = read cadena::[String]

procesaCabecera cab = do
  putStrLn $ "For each player, we have the following data:"
  mapM_ procesaCampo (zip cab [1..])
    where procesaCampo (campo,pos) = putStrLn $ show pos ++ ": " ++ show campo

procesaCabecera' cab = do
  mapM_ procesaCampo (zip cab [1..])
    where procesaCampo (campo,pos) = putStrLn $ show pos ++ ": " ++ show campo
                        
procesaContenido csv = do
  putStrLn "The content is as follows:"
  let esp = filtraEsp csv
      zur = filtraZur esp
      och = filtraOch zur
  mapM_ procesaReg (take 20 och)
    where
      filtraEsp = filter (\[_,_,_,_,_,nac] -> nac == "ESP")
      filtraZur = filter (\[_,_,_,m,_,_] -> m == "L")
      filtraOch = filter (\[_,_,_,_,a,_] -> esOchenta (read (take 4 a) :: Int))
        where esOchenta a = a>= 1980 && a < 1990
              
      procesaReg [_,n,a,m,f,nac] = do
            putStrLn $ n ++ " " ++ a
            
procesaContenido' csv = do
  mapM_ procesaReg (take 20 csv)
    where procesaReg [y,make,model,bstyles] = do
            putStrLn $ show (length (pasaALista bstyles))


-- -------------------------------------------------------------------
-- Exercise 4. [1,5 points]
-- -------------------------------------------------------------------
-- The generalized Fibonacci sequence of degree N
-- (N >= 1) is built starting with number 1 and computing the
-- rest of the terms as the sum of the previous N terms (if
-- they exist). For example,
-- + the generalized Fibonacci sequence of degree 2 is:
--   1, 1, 2, 3, 5, 8, 13, 21, 34, 55
-- + the generalized Fibonacci sequence of degree 4 is:
--   1, 1, 2, 4, 8, 15, 29, 56, 108, 208
-- + the generalized Fibonacci sequence of degree 6 is:
--   1, 1, 2, 4, 8, 16, 32, 63, 125, 248
-- Define the function (fibPila n k), which returns a stack with the
-- terms of the Fibonacci sequence of degree n that are less than k.
-- It is requested to use only the Stack ADT (lists are not allowed).
-- For example:
-- λ> fibPila 6 100
--   63|32|16|8|4|2|1|1|-
-- λ> fibPila 6 200
--   125|63|32|16|8|4|2|1|1|-
-- λ> fibPila 4 200
--   108|56|29|15|8|4|2|1|1|-

fibPila :: Int -> Int -> Pila Int
fibPila n k = fibPilaN (apila 1 (apila 1 vacia))
  where fibPilaN p | (sumaCima n p 0) > k = p
                   | otherwise = fibPilaN (apila (sumaCima n p 0) p)
        sumaCima n p m | (esVacia p) || (n==0) = m
                       | otherwise = sumaCima (n-1) (desapila p) (m + (cima p)) 
                       

-- ---------------------------------------------------------------------
-- Exercise 5. [1,5 points]
-- ---------------------------------------------------------------------
-- Given the following tree definition using lists

data Arbol = N Int [Arbol]
  deriving (Eq, Show)

-- define the function (aumentaNiveles a), such that it expands tree a
-- by adding a new child to each node, whose value is the result of
-- the sum of its siblings plus the parent. Two examples are shown
-- below, visually and evaluated in code:
--
-- Ej.1:    1         1          Ej.2:          1             1
--          |  ==>   / \                       / \    ==>    /|\
--          2       2   3                     2   3         2 3 6
--                  |                             |         | |\
--                  2                             4         2 4 7
--                                                            |
--                                                            4
-- Ej.1: λ> aumentaNiveles (N 1 [N 2 []])
--  N 1 [N 2 [N 2 []],N 3 []]
-- Ej.2: λ> aumentaNiveles (N 1 [N 2 [], N 3 [N 4 []]])
--   N 1 [N 2 [N 2 []],N 3 [N 4 [N 4 []],N 7 []],N 6 []]

valor (N x _) = x

aumentaNiveles (N x as) = N x ([ aumentaNiveles a | a <- as ]
                            ++ [N (x+sum [ valor a | a <- as ]) [] ])

-- ---------------------------------------------------------------------
-- Exercise 6. [1 point]
-- ---------------------------------------------------------------------
-- Define the following functions and data types:
---   * Define the type 'Binario', such that it allows us to represent a
--      binary number using integers. It must be displayable on screen.
--      See the function examples to know the constructors.
--    * Define the function (int2binario n), for example:
--       λ> int2binario 1  ==   B 1 BFin
--       λ> int2binario 110 ==  B 1 (B 1 (B 0 BFin))
--       λ> int2binario 121 ==  *** Exception: The input value is not binary
--    * Define the function (binario2int b), for example:
--       λ> binario2int (B 1 (B 1 (B 0 BFin))) == 110
--       λ> binario2int (B 0 (B 1 (B 0 BFin))) == 10

data Binario = B Int Binario | BFin
  deriving (Show)

int2binario :: Int -> Binario
int2binario n = int2bin n (BFin)
int2bin x b | r > 1 = error "The input value is not binary"
            | d == 0 = B r b
            | otherwise = int2bin d (B r b)
  where r = rem x 10
        d = div x 10

binario2int :: Binario -> Int
binario2int b = bin2int b 0
bin2int BFin n = n
bin2int (B x b) n = (bin2int b (n*10+x))

-- ---------------------------------------------------------------------
-- Exercise 6. [1 point]
-- ---------------------------------------------------------------------
-- Some image compression algorithms make use of bit planes,
-- or bitplanes. Given a matrix m of numbers in binary, the
-- bitplanes are the bit matrices corresponding to the n-th bit of
-- each element in m. That is, the matrix with the first bit of all
-- elements is the first bitplane, the matrix with the second bit of all
-- elements is the second bitplane, ... Assume a little-endian
-- representation (the least significant bit (in position 1) is the last one,
-- bit 2 is the third-to-last, etc.). For example, the bitplanes of matrix
--  ┌             ┐
--  │ 101   1  10 │
--  │   0  11 100 │
--  │  10 110   1 │
--  └             ┘
-- is the following list of matrices (from the third bitplane to the first):
--  ┌       ┐   ┌       ┐   ┌       ┐
--  │ 1 0 0 │   │ 0 0 1 │   │ 1 1 0 │
--  │ 0 0 1 │   │ 0 1 0 │   │ 0 1 0 │
--  │ 0 1 0 │   │ 1 1 0 │   │ 0 0 1 │
--  └       ┘ , └       ┘ , └       ┘
--
-- Define the function (bitplanes m), such that it receives a matrix
-- of numbers in binary (for type simplicity, assume Int and that it only
-- contains 0s and 1s), and returns a list of matrices with the bitplanes
-- from the most significant one (the most significant '1' of all the
-- elements in the matrix) to the least significant one. The following
-- example matrix corresponds to the previous one.

matrizEj :: Matrix Int
matrizEj = fromLists [[101, 1, 10], [0, 11, 100], [10, 110, 1]]

bitplanes :: Matrix Int -> [Matrix Int]
bitplanes m = [ fmap (bit b) m | b <- [numBitPlanes, numBitPlanes-1 .. 1]]
  where numBits x = length (show x)
        numBitPlanes = maximum (map numBits (toList m))

bit k x | n < k = 0
        | otherwise = read [(show x)!!(n-k)]
  where n = length (show x)
