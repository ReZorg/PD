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
-- · 4. It is recommended to submit a file that loads correctly,
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
-- ---------------------------------------------------------------------
-- Consider the function multFuncPrimerosNValidos
-- :: (Num a, Num b) => Int -> (a -> b) -> (a -> Bool) -> [a] -> b
-- such that (multFuncPrimerosNValidos n f p xs) returns the sum of the
-- results of applying function f to the first n elements of xs
-- that satisfy predicate p.
--
-- For example:
--    multFuncPrimerosNValidos_1 2 (4+) even [1..7]  => 48
-- 
-- (The first two even numbers in [1..7] are 2 and 4,
--  which after applying (4+) become 6 and 8, whose product is 48)
--
-- It is requested to define the function:
-- 1. using map and filter,
-- 2. by recursion,
-- 3. by recursion with an accumulator,
-- 4. by folding (left or right).
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- Exercise 2. [1 point]
-- ---------------------------------------------------------------------
-- Develop an animation using CodeWorld, so that the scene
-- includes the coordinate axes, a stationary thick rectangle,
-- and a filled circle of another color that rotates around
-- the static rectangle.
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- Exercise 3. [2 points]
-- ---------------------------------------------------------------------
-- Develop a main program that reads from the file passed
-- as an argument (if none is passed, from "atp_players.csv"),
-- parses it and then does the following with the valid rows
-- of the file:
--
-- a) Print on screen the number of players in the file.
--    Next, print the names of the fields contained in the
--    file, as follows:
--
--    "ID" (field 1)
--    "name" (field 2)
--    ...
--
-- b) Process the records, selecting
--    those that are Spanish (ESP), left-handed (L), and born in the 80s,
--    and for each of them print the name, surname, and
--    date of birth.
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- Exercise 4. [1,5 points]
-- ---------------------------------------------------------------------
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
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- Exercise 5. [1,5 points]
-- ---------------------------------------------------------------------
-- Given the following tree definition using lists
--
data Arbol = N Int [Arbol]
  deriving (Eq, Show)
--
-- define the function (aumentaNiveles a), such that it expands tree 'a'
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
--         N 1 [N 2 [N 2 []],N 3 []]
-- Ej.2: λ> aumentaNiveles (N 1 [N 2 [], N 3 [N 4 []]])
--         N 1 [N 2 [N 2 []],N 3 [N 4 [N 4 []],N 7 []],N 6 []]
-- ---------------------------------------------------------------------

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
-- ---------------------------------------------------------------------

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
-- ---------------------------------------------------------------------
