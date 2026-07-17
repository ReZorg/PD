-- -----------------------------------------------------------------------------
-- Declarative Programming 2021/22
-- Degree in Computer Engineering - Information Technologies
-- Midterm 2                                                 January 14, 2022
-- -----------------------------------------------------------------------------
-- Surnames:
-- Name:
-- UVUS:
-- -----------------------------------------------------------------------------

import Test.QuickCheck
import Data.Char
import Data.List
import Data.Array
import Control.Exception (catch, SomeException)
import PilaConListas

-- -----------------------------------------------------------------------------
-- Exercise 1.1 (2,5 puntos)
-- Given the following definition of binary tree

data Arbol a = H a | N (Arbol a) a (Arbol a)
  deriving Show

-- Defines the function (dropWhileArbol a p), such that receive a tree to, a
-- property p, and give a list of trees (es decir, un bosque). This
-- forest conform it those subárboles of the tree to that they remain after delete
-- nodes, beginning by the root, while they fulfil with the property p. The
-- behaviour is similar to the dropWhile for lists, will leave  of delete
-- nodes when it find  any that do not fulfil with the property. For example: 
-- 
--                3
--              /   \
--             4     5     dropWhile (>2)
--            / \   / \    ------------->      
--           2   1 3  -2                      2      1    -2
--          / \                              / \
--         0  -3                            0  -3
--
-- Dwell examples:
-- λ> dropWhileArbol (>2) ejArbol
-- [N (H 0) 2 (H (-3)),H 1,H (-2)]
-- λ> dropWhileArbol (>3) ejArbol
-- [N (N (N (H 0) 2 (H (-3))) 4 (H 1)) 3 (N (H 3) 5 (H (-2)))]
-- λ> dropWhileArbol odd ejArbol
-- [N (N (H 0) 2 (H (-3))) 4 (H 1),H (-2)]
-- -----------------------------------------------------------------------------

ejArbol :: Arbol Int
ejArbol = N (N (N (H 0) 2 (H (-3))) 4 (H 1)) 3 (N (H 3) 5 (H (-2)))

dropWhileArbol :: (a -> Bool) -> Arbol a -> [Arbol a]
dropWhileArbol = undefined

-- -----------------------------------------------------------------------------
-- Exercise 1.2 (1 punto)
-- In the image attaches to the examination there is an example of a red tree-black
-- (Red-Black tree, en inglés). In these trees, the nodes can be Black
-- (negros) or Net (rojos). The nodes leaf do not contain values. It fulfils  that
-- the root and the leaves are Black, and all node Net always has to have like children
-- nodes Black. It asks:
--   to) Define an algebraic type to represent this type of tree. Do it
--   parametrizado of such form that the type of the values in the tree can
--   be any one.
--   b) Using your new algebraic type, defines the example that there is in the image
--   attaches.

-- It defines the RedBlackTree type below

-- Defines the ejArbolRN example below

-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Exercise 2.1 (2,5 puntos)
-- Softmax is an operation that uses  commonly in machine learning. This
-- function receives a vector z like entrance, of dimension K, and give another
-- vector of dimension K where the values are normalised. In concrete, the
-- value in the position j calculates  eat:
--
--                and^(z[j]) / (sumatorio{k=1..K} e^(z[k]))
--
-- For example, the vector [0.1,0.2,0.9,0.5] would transform  to
-- [0.17174646,0.18980919,0.38222876,0.2562156]. En concreto, el valor en la
-- first position is: and^0.1 / (e^0.1+e^0.2+e^0.9+e^0.5) = 0.17174646, in the
-- second position is: and^0.2 / (e^0.1+e^0.2+e^0.9+e^0.5) = 0.18980919,...

-- It defines the function (softmax p) such that receive a matrix p of two
-- dimensions, and give the result to apply the operation softmax to each
-- column of the matrix.
-- It note 1: in Haskell, the number and can approximate  with (exp 1)
-- Note 2: you can assume that the index of the matrix begins by 1
-- For example,
-- λ> elems $ softmax ejm1
-- [0.17135403,0.20753783,0.23625901,0.24026075,
--  0.3450646, 0.2534873, 0.35245705,0.3584269,
--  0.17135403,0.22936477,0.17502499,0.16105159,
--  0.31222737,0.30961007,0.23625901,0.24026075]
-- λ> elems $ softmax ejm2
-- [2.1639727e-3, 0.2, 1.7809076e-2,
--  0.118148886,  0.2, 2.4101965and-3,
--  7.960811and-4,  0.2, 0.9723425,
--  0.8730087,    0.2, 6.551593and-3,
--  5.8822874and-3, 0.2, 8.8666176and-4]

ejm1, ejm2 :: Array (Int,Int) Float
ejm1 = listArray ((1,1),(4,4)) [0.1, 0.2, 0.3, 0.4, 
                                0.8, 0.4, 0.7, 0.8, 
                                0.1, 0.3, 0.0, 0.0, 
                                0.7, 0.6, 0.3, 0.4]
ejm2 = listArray ((1,1),(5,3)) [1, 0, 3,
                                5, 0, 1, 
                                0, 0, 7,
                                7, 0, 2,
                                2, 0, 0]                                

softmax :: Array (Int,Int) Float ->  Array (Int,Int) Float
softmax = undefined

-- -----------------------------------------------------------------------------
-- Exercise 2.2 (1 punto)
-- Defines the property (normalizada p) such that receive a matrix p and check
-- that his columns are normalised; that is to say, the sum of his values is
-- roughly 1 (con un error de 0.001). For example,
-- λ> normalizada $ softmax ejm1
-- True
-- λ> normalizada ejm1
-- False
-- λ> normalizada $ softmax ejm2
-- True
-- λ> normalizada ejm2
-- False

normalizada :: Array (Int,Int) Float -> Bool
normalizada = undefined

-- ----------------------------------------------------------------------


-- ----------------------------------------------------------------------
-- Exercise 3. (3 puntos) Defines a program that do the following:
--   1. Ask to the user a name of file
--   2. If the file does not exist or is empty, show a message of error and
--      go back to repeat.
--   3. If the file exists or is not empty, upload his content and process it
--      with a small parser.
--   4. The parser so only will indicate if the file is correct or no. What will do
--      will be to check that the parentheses "()" and the keys "{}" are
--      properly enclosed. It is necessary to detect that any parenthesis has closed
--       when there was an open key, and vice versa. Besides, all the 
--      parentheses and keys have to be properly closed before
--      finalising the file. For example:
--       - It is correct: {()}, ({()}), {({})}
--       - it is wrong: ({)}, ({(})), {, ((({})
--      For this, HAVE TO use a battery. When you process the chain with the
--      content of the file, if you find you with a '(' or '{', add it to the
--      battery. If you find you a ')' or a '}', checks that it corresponds to what
--       there is in the peak of the battery. When finalising, the battery has to be empty.
--   5. If there is an error of this type, the program has to write by
--      wrong "screen", whereas if there is not error has to write
--      "correcto".
-- For example:
-- λ> main
-- Enter file name: fich1.cpp
-- Correct
-- λ> main
-- Enter file name: fich2.cpp
-- Incorrect
-- λ> main
-- Enter file name: fich.cpp
-- fich.cpp: openFile: does not exist (No such file or directory)
-- file does not exist Error
-- Enter file name: fich3.cpp
-- Incorrect
-- ----------------------------------------------------------------------

main :: IO ()
main = undefined
  
-- ----------------------------------------------------------------------

