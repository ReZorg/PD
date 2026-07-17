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

extremosCumplenL = undefined
extremosCumplenR = undefined
extremosCumplenR2 = undefined
extremosCumplenO = undefined
extremosCumplenP = undefined
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


-- --------------------------------------------------------------------------
-- Exercise 3. [2 points]
-- --------------------------------------------------------------------------
-- A binary tree can be encoded by associating values only in the
-- leaves. It is requested:
--  a) Define the algebraic data type of the polymorphic binary tree with
-- values only in the leaves. This type must be printable and equatable.

{--- Uncomment this block once you define the Arbol type
ejar1 :: Arbol Int
ejar1 = (N (H 1) (N (N (H 1) (H 2)) (H 1)))
-}

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

elemNivel = undefined
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

comprueba = undefined

--  b) Define the function (transfiere n p1 p2), where p1 and p2 are two rods
--  with disks, n is a natural number, and it returns the result of stacking in p2
--  the first n disks of p1, keeping the order; that is, assume that it is
--  possible to take more than one disk at a time and move them to the second rod. For
--  example,
-- λ> transfiere 3 ejp2 ejp1
-- 1|2|3|4|5|7|10|-
-- λ> transfiere 9 ejp2 ejp1
-- 1|2|3|6|8|9|4|5|7|10|-

transfiere = undefined
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

{--- Uncomment this block once you define the Pieza type
ejm1 :: Matrix Pieza
ejm1 = fromLists [[V, V, V, V],
                  [C, V, C, V],
                  [V, V, A, V],
                  [V,RY,RA, T]]

ejm2 :: Matrix Pieza
ejm2 = fromLists [[V, V, V, V],
                  [C, C, C,RY],
                  [V, V, P, C],
                  [V, V,RA, T]]
-}

--   b) Define the function (jaquecaballo m), which checks whether on the board
--   encoded in matrix m there is any knight giving check to the king. For
--   example,
--    λ> jaquecaballo ejm1
--       True
--    λ> jaquecaballo ejm2
--       False

jaquecaballo = undefined

-- --------------------------------------------------------------------------
