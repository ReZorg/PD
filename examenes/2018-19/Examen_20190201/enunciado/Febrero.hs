-- Declarative Programming
-- Degree in Computer Engineering - Information Technologies
-- February Exam                                  February 1, 2019
-- -------------------------------------------------------------------
-- Surnames:
-- Name:
-- -------------------------------------------------------------------
-- IMPORTANT NOTICES
-- · 1. Before continuing, change the name of this file to:
--                   Febrero_<uvus>.hs
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
{-# LANGUAGE DeriveGeneric #-}

import qualified ColaConDosListas as C
import CodeWorld
import Data.Aeson
import GHC.Generics
import System.Environment (getArgs)
import qualified Data.ByteString.Lazy as B
import Text.CSV
import Data.Matrix

-- ---------------------------------------------------------------------
-- Exercise 1. [1 point]
-- Define the function largas such that (largas xs) is the
-- list of the longest words in list xs. For example,
--    largas ["no", "tengo", "claro", "que", "haga", "sol", "estos", "dias"]
--      == ["tengo", "claro", "estos"]
-- ---------------------------------------------------------------------

largas = undefined

-- -------------------------------------------------------------------
-- Exercise 2. [1 point]
-- Develop a main function (juego) with an
-- interactive program based on CodeWorld, which initially draws a red circle
-- on the left side of the screen and a green square
-- on the right side.
-- From there, if we press the left arrow it should increase
-- the size of the object on the left and decrease the one on the right,
-- and if we press the right arrow, the opposite; in any of the
-- cases, if a size is exceeded that makes the object not fit
-- on the screen, the action should leave the state unchanged.
-- -------------------------------------------------------------------

juego = undefined

-- ---------------------------------------------------------------------
-- Exercise 3. [1.5 points]
-- Consider the function aplicaNSats such that (aplicaNSats n f ps xs)
-- is the list obtained by applying function f to the first n
-- elements of xs that satisfy one of the predicates in ps.
-- For example:
--    aplicaNSats 4 (2+) [even,\x -> mod x 5 == 0]  [1..10]
--      ==  [4,6,7,8]
-- It is requested to define the function in the following three ways:
-- 1. Using list comprehensions
-- 2. Using functions such as map, filter, foldr, foldl, all, any, etc.
-- 3. Using recursion
--
--    ** Note: if you cannot solve this part,
--       at least try to make a simplified version of the problem,
--       and the exercise will be partially graded.
-- ---------------------------------------------------------------------

aplicaNSats1 = undefined

aplicaNSats2 = undefined

aplicaNSats3 = undefined

-- -------------------------------------------------------------------
-- Exercise 4. [1 point]
-- Define the function extremosCola, such that (extremosCola c) returns
-- a pair of elements with its minimum and maximum, after
-- traversing it only once and without converting it to a list. If the queue has fewer
-- than two elements it should return an appropriate error. For example,
--    extremosCola c4 == (-1,10)
--    extremosCola c7 == (1,20)
--    extremosCola c6 == (3,3)
-- -------------------------------------------------------------------

c1, c2, c3, c4, c5, c6, c7 :: C.Cola Int
c1 = foldr C.inserta C.vacia [1..20]
c2 = foldr C.inserta C.vacia [2,5..18]
c3 = foldr C.inserta C.vacia [3..10]
c4 = foldr C.inserta C.vacia [4,-1,7,3,8,10,0,3,3,4]
c5 = foldr C.inserta C.vacia [15..20]
c6 = foldr C.inserta C.vacia [3,3,3,3,3,3,3]
c7 = foldr C.inserta C.vacia ([1..10]++[20,19..10])

extremosCola = undefined

-- ---------------------------------------------------------------------
-- Exercise 5. [1.5 points]
-- A sparse matrix is one whose elements are
-- mostly zero. The representation of sparse matrices is
-- usually compressed into a dense form, where only the nonzero elements
-- arranged in a pair (column,value) are left in the rows.
-- Since some rows may have more elements than others,
-- those rows with fewer elements are filled with (0,0.0).
-- Below are two examples of a sparse matrix and its
-- dense representation.

matrizEjDispersa :: Matrix Double
matrizEjDispersa = fromLists [[0.0,0.0,2.1],[1.6,0.0,-2.5],[0.5,0.0,0.0]]

matrizEjDensa :: Matrix (Int,Double)
matrizEjDensa = fromLists [[(3,2.1),(0,0.0)],[(1,1.6),(3,-2.5)],[(1,0.5),(0,0.0)]]

-- Exercise 5.1. Define the function (coefDispersion m), such that it receives
-- a matrix m in sparse representation, and returns the dispersion coefficient
-- calculated as the number of zero elements divided by the number
-- of nonzero elements. For example,
--   coefDispersion matrizEjDispersa == 1.25

coefDispersion = undefined
     
-- Exercise 5.2. Define the function (matrizDispersa m), which receives
-- a matrix m in dense representation, and returns its corresponding
-- sparse representation. Hint: as the number of columns,
-- use the largest column appearing in the pairs of the dense representation.
-- For example,
--   matrizDispersa matrizEjDensa == matrizEjDispersa

matrizDispersa = undefined
                
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- Exercise 6. [2.5 points]
-- A Trie tree is a search tree where the internal nodes encode
-- an alphabet of Keys and the leaves contain Values associated
-- with the Keys. Below is an example, where the Keys
-- are character strings and the Values are integers.
--
--                              ""
--                             /  \
--                           "J"  "I"
--                            |     \
--                           "U"    "V"
--                           / \      \
--                         "A" "L"    "A"
--                         /     \      \
--                       "N"    "I"     "N"
--                        |      |       |
--                      68972   "A"     69712
--                              / \
--                          67321 62375
--
-- the example tree stores the phone numbers of the following contacts:
--  "JUAN" -> 68972, "JULIA" -> 67321, "JULIA" -> 62375, "IVAN" -> 69712
-- Notice that there are two repeated names ("JULIA"). Also notice that the
-- keys are distributed in the internal nodes, such that each node
-- has only one character associated in the form of a string.

-- Exercise 6.1. Define the data type for a polymorphic Trie tree,
-- where the internal nodes store an element of a Key type and can
-- have more than one child, and the leaves store only one Value. The tree
-- must be printable. In addition, define below a synonym of a
-- Trie tree that uses strings as Keys and integers as Values.



-- Exercise 6.2. Define the following functions:
--    (a) (arbolTrieVacio), which returns a tree with only the root node,
--         which has the empty string ("") as key and no children.
--    (b) (clave n), which returns the key associated with node n. If n is
--         a leaf, return the empty string "".
--    (c) (esHoja n), which indicates with a boolean whether node n is a leaf.

arbolTrieVacio = undefined

clave = undefined

esHoja = undefined

-- Exercise 6.3. Define the function (siguienteNodo hs s), which receives a
-- list of trees as and a one-character string s, and returns a
-- pair such that:
--  1. The first element of the pair will be the node h from list as whose
--     key matches s. If such a node does not exist, then it will be a
--     new node with key equal to s and no children.
--  2. The second element of the pair will be all the nodes in hs whose key does not
--     match s.

siguienteNodo = undefined

-- Exercise 6.4. Define the function (insertaEnArbol a p ), which receives a
-- Trie tree, a, and a pair, p, with (key, value), where key is a character
-- string and value an integer. The function must return tree a
-- including the new pair (key,value).

insertaEnArbol = undefined

-- Exercise 6.5. Define the function (insertaEnArbol a cs), which receives a
-- Trie tree, a, and a list, cs, of pairs (key, value), and returns a
-- tree with all elements inserted. For example, the following
-- should return the tree illustrated in the statement.
--    insertaEnArbol arbolTrieVacio
--        [("IVAN",69712),("JULIA",62375),("JULIA",67321),("JUAN",68972)]

insertaElemsEnArbol = undefined

-- Exercise 6.6. Define (consultaValor a cs), such that it receives a
-- Trie tree a and a Key cs, and returns the values associated with it. If the
-- key is not in the tree or has no associated values, return the
-- empty list.

consultaValor = undefined

-- ---------------------------------------------------------------------

-- -------------------------------------------------------------------
-- Exercise 7. [1.5 points]
-- We want to represent a structure that stores data about
-- sports categories differentiated by the website of an important
-- chain specializing in sports. Regarding this:

-- Exercise 7.1. Define, with record syntax, the appropriate types (new
-- and synonyms) to store a JSON structure like the
-- following:
-- {
--   "dataList": [
--      {
--	 "id": 441,
--	 "attributes": {
--		"name": "Snow hiking",
--		"slug": "snow-hiking"
--	 }
--      },
--      ...
--    ]
-- }



-- Exercise 7.2. Write a main program, (deportes), that:
--    a) Imports the file "sports.json" into an element
--       of the previous type
--    b) Prints on screen a message indicating the number
--       of sports contained in the structure,
--       calculated from it. It should look something like:

--          There are a total of 251 sports

--    c) For each of the first 10 sports,
--       print on screen its ordinal number and its name,
--       followed by its radius (half of its diameter):
--       It should look something like:

--          The names of the first 10 are the following:
--          1: "Sledding"
--          2: "Hiking"
--          3: "Snow hiking"
--          4: "Nordic skiing"
--          5: "Glacier hiking"
--          6: "Mountain hiking"
--          7: "Running"
--          8: "Skiing"
--          9: "Cycling"
--          10: "Horseback western riding"
--
--    ** Note: if you cannot solve this part,
--       at least try to perform basic processing with
--       the imported structure,
--       and the exercise will be partially graded.
-- -------------------------------------------------------------------

deportes = undefined
