-- PD- The Queue ADT.
-- Corresponding to Exercise Set 22 of I1M 2019-20
-- Department of Computer Science and A.I.
-- University of Seville
-- =====================================================================

-- ---------------------------------------------------------------------
-- Introduction                                                       --
-- ---------------------------------------------------------------------

-- The goal of this exercise set is to define functions on
-- the Queue ADT, using the implementations studied in
-- topic 15 whose slides can be found at
--    http://www.cs.us.es/~jalonso/cursos/i1m/temas/tema-15.html
-- 
-- To complete the exercises you need to install the I1M library that
-- contains the implementation of the Queue ADT. The steps to
-- install it are the following:
-- + cabal update
-- + cabal install I1M
-- 
-- Another option is to download the implementations of the queues:
-- + ColaConListas.hs    available at http://bit.ly/21z3wQL
-- + ColaConDosListas.hs available at http://bit.ly/21z3AQp

-- ---------------------------------------------------------------------
-- Library imports                                                    --
-- ---------------------------------------------------------------------

import Data.List
import Test.QuickCheck

-- Choose one implementation of the Queue ADT:
import ColaConListas
-- import ColaConDosListas
-- import I1M.Cola
    
-- ---------------------------------------------------------------------
-- Note. Throughout this exercise set we will use the following
-- example queues:
c1, c2, c3, c4, c5, c6 :: Cola Int
c1 = foldr inserta vacia [1..20]
c2 = foldr inserta vacia [2,5..18]
c3 = foldr inserta vacia [3..10]
c4 = foldr inserta vacia [4,-1,7,3,8,10,0,3,3,4]
c5 = foldr inserta vacia [15..20]
c6 = foldr inserta vacia (reverse [1..20])
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- Exercise 1: Define the function
--    ultimoCola :: Cola a -> a
-- such that (ultimoCola c) is the last element of queue c. For
-- example:
--    ultimoCola c4 == 4
--    ultimoCola c5 == 15
-- ---------------------------------------------------------------------

ultimoCola :: Cola a -> a
ultimoCola c = undefined

-- ---------------------------------------------------------------------
-- Exercise 2: Define the function
--    longitudCola :: Cola a -> Int
-- such that (longitudCola c) is the number of elements of queue c. For
-- example, 
--     longitudCola c2 == 6
-- ---------------------------------------------------------------------

longitudCola :: Cola a -> Int
longitudCola c = undefined

-- ---------------------------------------------------------------------
-- Exercise 3: Define the function 
--    todosVerifican :: (a -> Bool) -> Cola a -> Bool
-- such that (todosVerifican p c) holds if all elements of queue c
-- satisfy property p. For example,
--    todosVerifican (>0) c1 == True
--    todosVerifican (>0) c4 == False
-- ---------------------------------------------------------------------

todosVerifican :: (a -> Bool) -> Cola a -> Bool
todosVerifican p c = undefined

-- ---------------------------------------------------------------------
-- Exercise 4: Define the function
--    algunoVerifica :: (a -> Bool) -> Cola a -> Bool
-- such that (algunoVerifica p c) holds if some element of queue c
-- satisfies property p. For example,
--   algunoVerifica (<0) c1 == False
--   algunoVerifica (<0) c4 == True
-- ---------------------------------------------------------------------

algunoVerifica :: (a -> Bool) -> Cola a -> Bool
algunoVerifica p c = undefined

-- ---------------------------------------------------------------------
-- Exercise 5: Define the function
--    ponAlaCola :: Cola a -> Cola a -> Cola a
-- such that (ponAlaCola c1 c2) is the queue resulting from appending
-- the elements of c2 to the end of c1. For example,
--    ponAlaCola c2 c3 == C [17,14,11,8,5,2,10,9,8,7,6,5,4,3]
-- ---------------------------------------------------------------------

ponAlaCola :: Cola a -> Cola a -> Cola a
ponAlaCola c1 c2 = undefined

-- ---------------------------------------------------------------------
-- Exercise 6: Define the function
--    mezclaColas :: Cola a -> Cola a -> Cola a
-- such that (mezclaColas c1 c2) is the queue formed by the elements of
-- c1 and c2 placed alternately, starting with the elements of c1.
-- For example,
--    mezclaColas c2 c4 == C [17,4,14,3,11,3,8,0,5,10,2,8,3,7,-1,4]
-- ---------------------------------------------------------------------

mezclaColas :: Cola a -> Cola a -> Cola a
mezclaColas c1 c2 = undefined

-- ---------------------------------------------------------------------
-- Exercise 7: Define the function
--    agrupaColas :: [Cola a] -> Cola a
-- such that (agrupaColas [c1,c2,c3,...,cn]) is the queue formed by
-- merging the queues in the list as follows: merge c1 with c2, the
-- result with c3, the result with c4, and so on. For example,
--    ghci> agrupaColas [c3,c3,c4]
--    C [10,4,10,3,9,3,9,0,8,10,8,8,7,3,7,7,6,-1,6,4,5,5,4,4,3,3]
-- ---------------------------------------------------------------------

agrupaColas :: [Cola a] -> Cola a
agrupaColas = undefined

-- ---------------------------------------------------------------------
-- Exercise 8: Define the function
--    perteneceCola :: Eq a => a -> Cola a -> Bool
-- such that (perteneceCola x c) holds if x is an element of queue c.
-- For example, 
--    perteneceCola 7 c1  == True
--    perteneceCola 70 c1 == False
-- ---------------------------------------------------------------------

perteneceCola :: Eq a => a -> Cola a -> Bool
perteneceCola y c = undefined

-- ---------------------------------------------------------------------
-- Exercise 9: Define the function
--    contenidaCola :: Eq a => Cola a -> Cola a -> Bool
-- such that (contenidaCola c1 c2) holds if all elements of c1 are
-- elements of c2. For example, 
--    contenidaCola c2 c1 == True
--    contenidaCola c1 c2 == False
-- ---------------------------------------------------------------------

contenidaCola :: Eq a => Cola a -> Cola a -> Bool
contenidaCola c1 c2 = undefined

-- ---------------------------------------------------------------------
-- Exercise 10: Define the function
--    prefijoCola :: Eq a => Cola a -> Cola a -> Bool
-- such that (prefijoCola c1 c2) holds if queue c1 is a prefix of
-- queue c2. For example, 
--    prefijoCola c3 c2 == False
--    prefijoCola c5 c1 == True
-- ---------------------------------------------------------------------

prefijoCola :: Eq a => Cola a -> Cola a -> Bool
prefijoCola c1 c2 = undefined

-- ---------------------------------------------------------------------
-- Exercise 11: Define the function
--    subCola :: Eq a => Cola a -> Cola a -> Bool
-- such that (subCola c1 c2) holds if c1 is a sub-queue of c2. For
-- example,  
--    subCola c2 c1 == False
--    subCola c3 c1 == True
-- ---------------------------------------------------------------------

subCola :: Eq a => Cola a -> Cola a -> Bool
subCola c1 c2 = undefined

-- ---------------------------------------------------------------------
-- Exercise 12: Define the function
--    ordenadaCola :: Ord a => Cola a -> Bool
-- such that (ordenadaCola c) holds if the elements of queue c are in
-- ascending order. For example,
--    ordenadaCola c6 == True
--    ordenadaCola c4 == False
-- ---------------------------------------------------------------------

ordenadaCola :: Ord a => Cola a -> Bool
ordenadaCola c = undefined

-- ---------------------------------------------------------------------
-- Exercise 13.1: Define a function
--    lista2Cola :: [a] -> Cola a
-- such that (lista2Cola xs) is a queue formed by the elements of xs.
-- For example,
--    lista2Cola [1..6] == C [1,2,3,4,5,6]
-- ---------------------------------------------------------------------

lista2Cola :: [a] -> Cola a
lista2Cola xs = undefined

-- ---------------------------------------------------------------------
-- Exercise 13.2: Define a function
--    cola2Lista :: Cola a -> [a]
-- such that (cola2Lista c) is the list formed by the elements of p.
-- For example,
--    cola2Lista c2 == [17,14,11,8,5,2]
-- ---------------------------------------------------------------------

cola2Lista :: Cola a -> [a]
cola2Lista c = undefined

-- ---------------------------------------------------------------------
-- Exercise 13.3. Check with QuickCheck that the function cola2Lista is
-- the inverse of lista2Cola, and vice versa.
-- ---------------------------------------------------------------------

prop_cola2Lista :: Cola Int -> Bool
prop_cola2Lista c = undefined

-- ghci> quickCheck prop_cola2Lista
-- +++ OK, passed 100 tests.

prop_lista2Cola :: [Int] -> Bool
prop_lista2Cola xs = undefined

-- ghci> quickCheck prop_lista2Cola
-- +++ OK, passed 100 tests.

-- ---------------------------------------------------------------------
-- Exercise 14: Define the function 
--    maxCola :: Ord a => Cola a -> a
-- such that (maxCola c) is the greatest element of queue c. For
-- example, 
--    maxCola c4 == 10
-- ---------------------------------------------------------------------

maxCola :: Ord a => Cola a -> a
maxCola p = undefined

-- ---------------------------------------------------------------------
-- Queue generator                                            --
-- ---------------------------------------------------------------------

-- genCola is an integer queue generator. For example,
--    ghci> sample genCola
--    C ([],[])
--    C ([],[])
--    C ([],[])
--    C ([],[])
--    C ([7,8,4,3,7],[5,3,3])
--    C ([],[])
--    C ([1],[13])
--    C ([18,28],[12,21,28,28,3,18,14])
--    C ([47],[64,45,7])
--    C ([8],[])
--    C ([42,112,178,175,107],[])
genCola :: (Num a, Arbitrary a) => Gen (Cola a)
genCola = frequency [(1, return vacia),
                     (30, do n <- choose (10,100)
                             xs <- vectorOf n arbitrary
                             return (creaCola xs))]
          where creaCola = foldr inserta vacia

-- The Cola type is an instance of Arbitrary.
instance (Arbitrary a, Num a) => Arbitrary (Cola a) where
    arbitrary = genCola

