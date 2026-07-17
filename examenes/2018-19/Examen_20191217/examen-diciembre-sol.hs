-- Declarative Programming
-- Degree in Computer Engineering - Information Technologies
-- December Exam                                      December 17, 2019
-- --------------------------------------------------------------------------
-- Surnames:
-- Name:
-- UVUS:
-- --------------------------------------------------------------------------
-- IMPORTANT NOTICES
-- · 1. Before continuing, change the name of this file to:
--                   diciembre_<uvus>.hs
--   where <uvus> must be your virtual username.
-- · 2. Please submit a file that loads correctly, leaving
--   all code with errors commented out.
-- · 3. Write the solution to each exercise in the space reserved for
--   it.
-- · 4. Make sure you correctly use the name and type indicated
--   for each requested function. You may add as many helper
--   functions (including the type properly) as you need,
--   describing their purpose.
-- --------------------------------------------------------------------------

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

import Data.Default
import Data.Aeson
import GHC.Generics
import System.Environment (getArgs)
import qualified Data.ByteString.Lazy as B

import Data.Matrix
import TADPila

-- --------------------------------------------------------------------------
-- Exercise 1. [2 points]
-- --------------------------------------------------------------------------
-- The function extremosCumplen receives a predicate p, a function f and
-- a list of lists xss, and returns a list of pairs of elements
-- such that, for each list in the original list of lists, it returns the pair of
-- elements resulting from applying the indicated function to the smallest and
-- largest element that satisfies the predicate. Let's see it through examples:

--  λ> extremosCumplen even (^2) [[1..5],[(-9)..(-1)]]
--     [(4,16),(64,4)]
--
--  λ> extremosCumplen (\x -> length x > 3)
--                     (take 3)
--                     [["paco","es","poco","pico"],
--                      ["tres", "tristes", "tigres"]]
--     [("pac","poc"),("tig","tri")]

-- In short, it is requested to define the previous function using
-- different techniques as the core of its solution:
--  a) List comprehensions: extremosCumplenL
--  b) Non-tail recursion: extremosCumplenR
--  c) Recursion with an accumulator: extremosCumplenR2
--  d) Higher-order functions other than folding: extremosCumplenO
--  e) Folding: extremosCumplenP

extremosCumplen :: (Ord a) => (a -> Bool) -> (a -> b) -> [[a]] -> [(b,b)] 
extremosCumplen p f [] = []
extremosCumplen p f (xs:xss) = (f a, f b):extremosCumplen p f xss
  where a = minimum cumplen
        b = maximum cumplen
        cumplen = filter p xs
        
extremosCumplenR :: (Ord a) => (a -> Bool) -> (a -> b) -> [[a]] -> [(b,b)] 
extremosCumplenR p f [] = []
extremosCumplenR p f (xs:xss) = (f a, f b) : extremosCumplenR p f xss
  where a = minimum cumplen
        b = maximum cumplen
        cumplen = satisfacen p xs
        satisfacen p [] = []
        satisfacen p (x:xs) | p x = x : satisfacen p xs
                            | otherwise = satisfacen p xs

extremosCumplenL :: (Ord a) => (a -> Bool) -> (a -> b) -> [[a]] -> [(b,b)] 
extremosCumplenL p f xss = [extremos xs | xs <- xss]
  where extremos xs = (f a, f b)
          where a = minimum cumplen
                b = maximum cumplen
                cumplen = [x | x <- xs, p x]

extremosCumplenO :: (Ord a) => (a -> Bool) -> (a -> b) -> [[a]] -> [(b,b)] 
extremosCumplenO p f xss = map extremos xss
  where extremos xs = (f a, f b)
          where a = minimum cumplen
                b = maximum cumplen
                cumplen = filter p xs
        
extremosCumplenR2 :: (Ord a) => (a -> Bool) -> (a -> b) -> [[a]] -> [(b,b)] 
extremosCumplenR2 p f xss = aux [] xss
  where aux acc [] = acc
        aux acc (xs:xss) = aux (acc++[exs]) xss
          where exs = (f a, f b)
                  where a = minimum cumplen
                        b = maximum cumplen
                        cumplen = filter p xs

extremosCumplenP :: (Ord a) => (a -> Bool) -> (a -> b) -> [[a]] -> [(b,b)] 
extremosCumplenP p f xss = foldr (\xs y -> e xs : y) [] xss
  where e xs = (f a, f b)
          where a = minimum cumplen
                b = maximum cumplen
                cumplen = filter p xs
                              
extremosCumplenP2 :: (Ord a) => (a -> Bool) -> (a -> b) -> [[a]] -> [(b,b)] 
extremosCumplenP2 p f xss = foldl (\acc xs -> acc ++ [e xs]) [] xss
  where e xs = (f a, f b)
          where a = minimum cumplen
                b = maximum cumplen
                cumplen = filter p xs
-- --------------------------------------------------------------------------


-- --------------------------------------------------------------------------
-- Exercise 2. [2 points]
-- --------------------------------------------------------------------------
-- 1. Define, with record syntax, the types needed to store
--    the information about Star Wars characters contained in the
--    file personajes.json, ignoring data that is not required
--    for the following parts.
--
-- Note: keep in mind that the characters are in an array inside
--       a field of a higher-level object.
--
-- 2. Assign default values to the considered fields.
--
-- 3. Write a main program that:
--    a) Imports the file "personajes.json",
--    b) Indicates the total number of characters returned by the API
--    c) For each character, prints on screen their name, height, weight,
--       and number of films in which they appear
--    d) Indicates the name and height of the tallest character returned.
-- -------------------------------------------------------------------

data Personaje = Pers {
  name::String, height::String, mass::String, films::[String]
  } deriving (Show, Generic)
    
instance Default Personaje where
  def = Pers {
    name="nobody", height="100", mass="100",films=def
    }
 
instance FromJSON Personaje

type Personajes = [Personaje]

data Contenedor = Cont {
  count::Integer, results::Personajes
  } deriving (Show, Generic)

instance Default Contenedor where
  def = Cont {
    count=def, results=def
    }

instance FromJSON Contenedor

main3 :: IO ()
main3 = do
  args <- getArgs
  let filename = if null args then "personajes2.json" else args!!0
  contents <- B.readFile filename

  let cont = decode contents :: Maybe Contenedor
  case cont of
    Just cont -> do
      putStrLn $ "There are a total of " ++ show (count cont) ++ " characters."
      let perss = results cont
      processPersonajes perss
      masAlto perss
    _ -> putStrLn "Not valid people"

processPersonajes :: Personajes -> IO ()
processPersonajes personajes = do
  mapM_ processPersonaje personajes

processPersonaje :: Personaje -> IO ()
processPersonaje personaje = do
  putStrLn $
    show (name personaje) ++
    " is " ++ show (fromIntegral (read (height personaje)::Int) / 100) ++
    " meters tall, weighs " ++ show (read (mass personaje)::Int) ++
    " kilos and appears in " ++ show (length (films personaje)) ++
    " films."

masAlto :: Personajes -> IO ()
masAlto personajes = do
  putStrLn $
    "The tallest character is " ++ show a ++ ", who is " ++
    show (fromIntegral b/100) ++ " meters tall."
  where (a,b) = (per h, h)
        h = maximum (map (\p -> read (height p)::Int) personajes)
        per he = name $ head (filter (\p -> height p == show he) personajes)
-- --------------------------------------------------------------------------


-- --------------------------------------------------------------------------
-- Exercise 3. [2 points]
-- --------------------------------------------------------------------------
-- A binary tree can be encoded by associating values only in the
-- leaves. It is requested:
--  a) Define the algebraic data type of the polymorphic binary tree with
-- values only in the leaves. This type must be printable and equatable.

data Arbol a = H a | N (Arbol a) (Arbol a)
  deriving (Show,Eq)

--  b) Define the function (elemNivel a x), such that it determines the shallowest
--  level where x occurs. The root counts as level 0, its children as level 1,
--  etc. This function must return a Maybe, since if the element is not
--  found, it returns Nothing. If it is found, it simply returns the level.
--  For example,
--    λ> ejar1
--       N (H 1) (N (N (H 1) (H 2)) (H 1))
--    λ> elemNivel ejar1 2
--       Just 3
--    λ> elemNivel ejar1 1
--       Just 1
--    λ> elemNivel ejar1 5
--       Nothing

ejar1 :: Arbol Int
ejar1 = (N (H 1) (N (N (H 1) (H 2)) (H 1)))

elemNivel a x = elemNivel' a x 0

elemNivel' (H y) x n | x == y = Just n
                     | otherwise = Nothing
elemNivel' (N a1 a2) x n
  | en1 == Nothing = en2
  | en2 == Nothing = en1
  | otherwise = Just (min en1' en2')
  where en1 = elemNivel' a1 x (n+1)
        en2 = elemNivel' a2 x (n+1)
        Just en1' = en1
        Just en2' = en2
-- --------------------------------------------------------------------------


-- --------------------------------------------------------------------------
-- Exercise 4. [2 points]
-- --------------------------------------------------------------------------
-- In the towers of Hanoi problem, three rods are considered where
-- disks of different sizes are stacked. One way to encode the rods is
-- to use the abstract data type stack with integers, where each integer
-- indicates the disk size (from smallest to largest)

ejp1, ejp2, ejp3 :: Pila Int
ejp1 = foldr apila vacia [4,5,7,10]
ejp2 = foldr apila vacia [1,2,3,6,8,9]
ejp3 = foldr apila vacia [4,5,1,2]

-- It is requested:
--  a) Define the function (comprueba p), where p is a stack that encodes a
--  rod of disks, and check whether the rod is correct; that is, that
--  no disk has a larger one above it. For example,
--   λ> comprueba ejp2
--      True
--   λ> comprueba ejp3
--      False

comprueba :: Pila Int -> Bool
comprueba p | esVacia p = True
            | todosMayores cp dp = comprueba dp
            | otherwise = False
  where cp = cima p
        dp = desapila p
        todosMayores x q | esVacia q = True
                         | otherwise = (x < cima q) && todosMayores x (desapila q)

--  b) Define the function (transfiere n p1 p2), where p1 and p2 are two rods
--  with disks, n is a natural number, and it returns the result of stacking in p2
--  the first n disks of p1, keeping the order; that is, assume that it is
--  possible to take more than one disk at a time and move them to the second rod. For
--  example,
-- λ> transfiere 3 ejp2 ejp1
-- 1|2|3|4|5|7|10|-
-- λ> transfiere 9 ejp2 ejp1
-- 1|2|3|6|8|9|4|5|7|10|-

transfiere :: Int -> Pila Int -> Pila Int -> Pila Int
transfiere n p1 p2 | n==0 || esVacia p1 = p2
                   | otherwise = apila cp1 (transfiere (n-1) dp1 p2)
  where cp1 = cima p1
        dp1 = desapila p1
-- --------------------------------------------------------------------------


-- --------------------------------------------------------------------------
-- Exercise 5. [2 points]
-- --------------------------------------------------------------------------
-- We represent the chessboard with a matrix where the elements are
-- of type Pieza. This type has as possible values: V, C, T, A, P, RY and
-- RA, which mean empty, knight, rook, bishop, pawn, king and queen,
-- respectively. It is requested:
--   a) Define the new data type Pieza so that examples ejm1 and ejm2
-- can be loaded correctly once uncommented. Apply the
-- necessary derivations to be able to use it in the rest of the exercises.

data Pieza = V | C | T | A | P | RY | RA
  deriving (Show,Eq)

ejm1 :: Matrix Pieza
ejm1 = fromLists [replicate 4 (V),
                 [C, V, C, V],
                 [V, V, A, V],
                 [V,RY,RA, T]]

ejm2 :: Matrix Pieza
ejm2 = fromLists [replicate 4 (V),
                 [C, C, C,RY],
                 [V, V, P,C],
                 [V, V,RA,T]]

--   b) Define the function (jaquecaballo m), which checks whether on the board
--   encoded in matrix m there is any knight giving check to the king. For
--   example,
--    λ> jaquecaballo ejm1
--       True
--    λ> jaquecaballo ejm2
--       False

jaquecaballo :: Matrix Pieza -> Bool
jaquecaballo m = or [ compruebaRey i j | i <- [1..nf], j <- [1..nc], m!(i,j) == C]
  where compruebaRey i j = (esRey (i-2) (j-1)) || (esRey (i-2) (j+1)) ||
                           (esRey (i+2) (j-1)) || (esRey (i+2) (j+1)) ||
                           (esRey (i-1) (j-2)) || (esRey (i+1) (j-2)) ||
                           (esRey (i-1) (j+2)) || (esRey (i+1) (j+2)) 
        esRey i j | i < 1 || i > nf || j < 1 || j > nc = False
                  | otherwise = m!(i,j) == RY
        nf = nrows m
        nc = ncols m
-- --------------------------------------------------------------------------
