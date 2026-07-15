-- PD- The Stack ADT.
-- Corresponding to Exercise Set 21 of I1M 2010-20
-- Department of Computer Science and A.I.
-- University of Seville
-- =====================================================================

-- ---------------------------------------------------------------------
-- Introduction                                                       --
-- ---------------------------------------------------------------------

-- The goal of this exercise set is to define functions on
-- the Stack ADT, using the implementations studied in
-- topic 14 whose slides can be found at
--    http://www.cs.us.es/~jalonso/cursos/i1m/temas/tema-14.html
-- 
-- To complete the exercises you need to install the I1M library that
-- contains the implementation of the Stack ADT. The steps to
-- install it are the following:
-- + cabal update
-- + cabal install I1M
--
-- Another option is to download the implementations of the stacks:
-- + PilaConTipoDeDatoAlgebraico.hs available at http://bit.ly/21z3g49
-- + PilaConListas.hs               available at http://bit.ly/21z3oAD

-- ---------------------------------------------------------------------
-- Library imports                                                    --
-- ---------------------------------------------------------------------

import Data.List
import Test.QuickCheck

-- Choose one implementation of the Stack ADT.
-- import PilaConTipoDeDatoAlgebraico
-- import PilaConListas
import I1M.Pila

-- ---------------------------------------------------------------------
-- Throughout this exercise set we will use the following
-- example stacks:
-- ---------------------------------------------------------------------

ejP1, ejP2, ejP3, ejP4, ejP5 :: Pila Int
ejP1 = foldr apila vacia [1..20]
ejP2 = foldr apila vacia [2,5..18]
ejP3 = foldr apila vacia [3..10]
ejP4 = foldr apila vacia [4,-1,7,3,8,10,0,3,3,4]
ejP5 = foldr apila vacia [1..5]

-- ---------------------------------------------------------------------
-- Exercise 1: Define the function
--    filtraPila :: (a -> Bool) -> Pila a -> Pila a
-- such that (filtraPila p pila) is the stack with the elements of pila
-- that satisfy predicate p, in the same order. For example,
--    ghci> ejP1
--    1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|-
--    ghci> filtraPila even ejP1
--    2|4|6|8|10|12|14|16|18|20|-

-- ---------------------------------------------------------------------

filtraPila :: (a -> Bool) -> Pila a -> Pila a
filtraPila = undefined

-- ---------------------------------------------------------------------
-- Exercise 2: Define the function
--    mapPila :: (a -> a) -> Pila a -> Pila a
-- such that (mapPila f pila) is the stack formed by the images under f
-- of the elements of pila, in the same order. For example,
--    ghci> mapPila (+7) ejP1
--    8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|-
-- ---------------------------------------------------------------------

mapPila :: (a -> a) -> Pila a -> Pila a
mapPila = undefined

-- ---------------------------------------------------------------------
-- Exercise 3: Define the function
--    pertenecePila :: (Eq a) => a -> Pila a -> Bool
-- such that (pertenecePila y p) holds if and only if y is an element
-- of stack p. For example,
--    pertenecePila 7 ejP1  == True
--    pertenecePila 70 ejP1 == False
-- ---------------------------------------------------------------------

pertenecePila :: (Eq a) => a -> Pila a -> Bool
pertenecePila = undefined

-- ---------------------------------------------------------------------
-- Exercise 4: define the function
--    contenidaPila :: (Eq a) => Pila a -> Pila a -> Bool
-- such that (contenidaPila p1 p2) holds if and only if all elements
-- of p1 are elements of p2. For example,
--    contenidaPila ejP2 ejP1 == True
--    contenidaPila ejP1 ejP2 == False
-- ---------------------------------------------------------------------

contenidaPila :: (Eq a) => Pila a -> Pila a -> Bool
contenidaPila = undefined

-- ---------------------------------------------------------------------
-- Exercise 4: Define the function
--    prefijoPila :: (Eq a) => Pila a -> Pila a -> Bool
-- such that (prefijoPila p1 p2) holds if stack p1 is exactly
-- a prefix of stack p2. For example,
--    prefijoPila ejP3 ejP2 == False
--    prefijoPila ejP5 ejP1 == True
-- ---------------------------------------------------------------------

prefijoPila :: (Eq a) => Pila a -> Pila a -> Bool
prefijoPila = undefined 

-- ---------------------------------------------------------------------
-- Exercise 5: Define the function
--    subPila :: (Eq a) => Pila a -> Pila a -> Bool
-- such that (subPila p1 p2) holds if p1 is a sub-stack of p2.
-- For example, 
--    subPila ejP2 ejP1 == False
--    subPila ejP3 ejP1 == True
-- ---------------------------------------------------------------------

subPila :: (Eq a) => Pila a -> Pila a -> Bool
subPila = undefined 

-- ---------------------------------------------------------------------
-- Exercise 6: Define the function
--    ordenadaPila :: (Ord a) => Pila a -> Bool
-- such that (ordenadaPila p) holds if the elements of stack p
-- are in ascending order. For example,
--    ordenadaPila ejP1 == True
--    ordenadaPila ejP4 == False
-- ---------------------------------------------------------------------

ordenadaPila :: (Ord a) => Pila a -> Bool
ordenadaPila = undefined 

-- ---------------------------------------------------------------------
-- Exercise 7.1: Define a function
--    lista2Pila :: [a] -> Pila a
-- such that (lista2Pila xs) is a stack formed by the elements of xs.
-- For example,
--    lista2Pila [1..6] == 1|2|3|4|5|6|-
-- ---------------------------------------------------------------------

lista2Pila :: [a] -> Pila a
lista2Pila xs = undefined

-- ---------------------------------------------------------------------
-- Exercise 7.2: Define a function
--  pila2Lista :: Pila a -> [a]
-- such that (pila2Lista p) is the list formed by the elements of p.
-- For example,
--    pila2Lista ejP2 == [2,5,8,11,14,17]
-- ---------------------------------------------------------------------

pila2Lista :: Pila a -> [a]
pila2Lista = undefined

-- ---------------------------------------------------------------------
-- Exercise 7.3: Check with QuickCheck that the function pila2Lista is
-- the inverse of lista2Pila, and vice versa.
-- ---------------------------------------------------------------------

prop_pila2Lista :: Pila Int -> Bool
prop_pila2Lista p = undefined

-- ghci> quickCheck prop_pila2Lista
-- +++ OK, passed 100 tests.

prop_lista2Pila :: [Int] -> Bool
prop_lista2Pila xs = undefined

-- ghci> quickCheck prop_lista2Pila
-- +++ OK, passed 100 tests.

-- ---------------------------------------------------------------------
-- Exercise 9.1: Define the function 
--    ordenaInserPila :: (Ord a) => Pila a -> Pila a
-- such that (ordenaInserPila p) is a stack with the elements of stack
-- p sorted by insertion. For example,
--    ghci> ordenaInserPila ejP4
--    -1|0|3|3|3|4|4|7|8|10|-
-- ---------------------------------------------------------------------

ordenaInserPila :: (Ord a) => Pila a -> Pila a
ordenaInserPila = undefined

-- ---------------------------------------------------------------------
-- Exercise 9.2: Check with QuickCheck that the stack 
---    (ordenaInserPila p) 
-- is correctly sorted.

prop_ordenaInserPila :: Pila Int -> Bool
prop_ordenaInserPila p = undefined

-- ghci> quickCheck prop_ordenaInserPila
-- +++ OK, passed 100 tests.

-- ---------------------------------------------------------------------
-- Exercise 10.1: Define the function
--    nubPila :: (Eq a) => Pila a -> Pila a
-- such that (nubPila p) is a stack with the elements of p without
-- repetitions. For example,
--    ghci> ejP4
--    4|-1|7|3|8|10|0|3|3|4|-
--    ghci> nubPila ejP4
--    -1|7|8|10|0|3|4|-
-- ---------------------------------------------------------------------

nubPila :: (Eq a) => Pila a -> Pila a
nubPila = undefined

-- ---------------------------------------------------------------------
-- Exercise 10.2: Define the following property: "the composition of
-- the functions nub and pila2Lista coincides with the composition of
-- the functions pila2Lista and nubPila", and check it with quickCheck.
-- If it is false, redefine nubPila so that the property holds.
-- ---------------------------------------------------------------------

-- The property is
prop_nubPila :: Pila Int -> Bool
prop_nubPila p = undefined

-- The check is

-- ---------------------------------------------------------------------
-- Exercise 11: Define the function 
--    maxPila :: (Ord a) => Pila a -> a
-- such that (maxPila p) is the greatest element of stack p. For
-- example, 
--    ghci> ejP4
--    4|-1|7|3|8|10|0|3|3|4|-
--    ghci> maxPila ejP4
--    10
-- ---------------------------------------------------------------------

maxPila :: (Ord a) => Pila a -> a
maxPila = undefined

-- ---------------------------------------------------------------------
-- Stack generator                                                    --
-- ---------------------------------------------------------------------

-- genPila is a stack generator. For example,
--    ghci> sample genPila
--    -
--    0|0|-
--    -
--    -6|4|-3|3|0|-
--    -
--    9|5|-1|-3|0|-8|-5|-7|2|-
--    -3|-10|-3|-12|11|6|1|-2|0|-12|-6|-
--    2|-14|-5|2|-
--    5|9|-
--    -1|-14|5|-
--    6|13|0|17|-12|-7|-8|-19|-14|-5|10|14|3|-18|2|-14|-11|-6|-
genPila :: (Arbitrary a, Num a) => Gen (Pila a)
genPila = do xs <- listOf arbitrary
             return (foldr apila vacia xs)
  
-- The Pila type is an instance of Arbitrary. 
instance (Arbitrary a, Num a) => Arbitrary (Pila a) where
    arbitrary = genPila


