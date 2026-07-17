-- PD-Practice 6.2
-- Binary trees with algebraic data types
-- Department of Computer Science and A.I.
-- University of Seville
-- =====================================================================

-- ---------------------------------------------------------------------
-- Introduction                                                        --
-- ---------------------------------------------------------------------

-- This module presents exercises on binary trees
-- defined as algebraic data types.

-- ---------------------------------------------------------------------
-- Note. In the following exercises we will work with the binary trees
-- defined as follows 
--    data Arbol a = H a
--                 | N a (Arbol a) (Arbol a)
--                 deriving (Show, Eq)
-- Where H represents a Leaf, and N is an internal node
-- For example, the tree
--         9 
--        / \
--       /   \
--      3     7
--     / \  
--    2   4 
-- is represented by
--    N 9 (N 3 (H 2) (H 4)) (H 7) 
-- ---------------------------------------------------------------------

data Arbol a = H a
             | N a (Arbol a) (Arbol a)
             deriving (Show, Eq)

-- ---------------------------------------------------------------------
-- Exercise 1.1. Define the function
--    nHojas :: Arbol a -> Int
-- such that (nHojas x) is the number of leaves of tree x. For example,
--    nHojas (N 9 (N 3 (H 2) (H 4)) (H 7))  ==  3
-- ---------------------------------------------------------------------

nHojas :: Arbol a -> Int
nHojas = undefined

-- ---------------------------------------------------------------------
-- Exercise 1.2. Define the function
--    nNodos :: Arbol a -> Int
-- such that (nNodos x) is the number of nodes of tree x. For example,
--    nNodos (N 9 (N 3 (H 2) (H 4)) (H 7))  ==  2
-- ---------------------------------------------------------------------

nNodos :: Arbol a -> Int
nNodos = undefined

-- ---------------------------------------------------------------------
-- Exercise 2.1. Define the function
--    profundidad :: Arbol a -> Int
-- such that (profundidad x) is the depth of tree x. For example,
--    profundidad (N 9 (N 3 (H 2) (H 4)) (H 7))              ==  2
--    profundidad (N 9 (N 3 (H 2) (N 1 (H 4) (H 5))) (H 7))  ==  3
--    profundidad (N 4 (N 5 (H 4) (H 2)) (N 3 (H 7) (H 4)))  ==  2
-- ---------------------------------------------------------------------

profundidad :: Arbol a -> Int
profundidad = undefined

-- ---------------------------------------------------------------------
-- Exercise 2.2. Define the function
--    anadeHojas :: Arbol a -> a -> a -> Arbol a
-- such that (anadeHojas a x y) adds to each leaf of tree a
-- two leaves with data x and y. For example,
--   anadeHojas (H 5) 0 10 == N 5 (H 0) (H 10)
--   anadeHojas (N 7 (H 5) (H 9)) 1 4 == N 7 (N 5 (H 1) (H 4)) (N 9 (H 1) (H 4))
-- ---------------------------------------------------------------------

anadeHojas :: Arbol a -> a -> a -> Arbol a
anadeHojas = undefined

-- ---------------------------------------------------------------------
-- Exercise 3.1. Define the function
--    preorden :: Arbol a -> [a]
-- such that (preorden x) is the list corresponding to the preorder
-- traversal of tree x; that is, first visits the root of the tree,
-- then traverses the left subtree and, finally, the right subtree.
-- For example,
--    preorden (N 9 (N 3 (H 2) (H 4)) (H 7))  ==  [9,3,2,4,7]
-- ---------------------------------------------------------------------

preorden :: Arbol a -> [a]
preorden = undefined

-- ---------------------------------------------------------------------
-- Exercise 3.2. Define the function
--    inorden :: Arbol a -> [a]
-- such that (inorden x) is the list corresponding to the inorder
-- traversal of tree x; that is, first traverses the left subtree,
-- then the root, and finally the right subtree. For example,
--    inorden (N 9 (N 3 (H 2) (H 4)) (H 7))  ==  [2,3,4,9,7]
-- ---------------------------------------------------------------------

inorden :: Arbol a -> [a]
inorden = undefined

-- ---------------------------------------------------------------------
-- Exercise 3.3. Define the function
--    postorden :: Arbol a -> [a]
-- such that (postorden x) is the list corresponding to the postorder
-- traversal of tree x; that is, first traverses the left subtree,
-- then the right subtree, and finally the root of the tree.
-- For example,
--    postorden (N 9 (N 3 (H 2) (H 4)) (H 7))  ==  [2,4,3,7,9]
-- ---------------------------------------------------------------------

postorden :: Arbol a -> [a]
postorden = undefined

-- ---------------------------------------------------------------------
-- Exercise 4.1. Define the function
--    espejo :: Arbol a -> Arbol a
-- such that (espejo x) is the mirror image of tree x. For example,
--    espejo (N 9 (N 3 (H 2) (H 4)) (H 7)) == N 9 (H 7) (N 3 (H 4) (H 2))
-- ---------------------------------------------------------------------

espejo :: Arbol a -> Arbol a
espejo = undefined


-- ---------------------------------------------------------------------
-- Exercise 5.1. The take function is defined by
--    take :: Int -> [a] -> [a]
--    take 0            = []
--    take (n+1) []     = []
--    take (n+1) (x:xs) = x : take n xs
-- 
-- Define the function 
--    takeArbol ::  Int -> Arbol a -> Arbol a
-- such that (takeArbol n t) is the subtree of t of depth n. For
-- example,
--    takeArbol 0 (N 9 (N 3 (H 2) (H 4)) (H 7)) == H 9
--    takeArbol 1 (N 9 (N 3 (H 2) (H 4)) (H 7)) == N 9 (H 3) (H 7)
--    takeArbol 2 (N 9 (N 3 (H 2) (H 4)) (H 7)) == N 9 (N 3 (H 2) (H 4)) (H 7)
--    takeArbol 3 (N 9 (N 3 (H 2) (H 4)) (H 7)) == N 9 (N 3 (H 2) (H 4)) (H 7)
-- ---------------------------------------------------------------------
 
takeArbol :: Int -> Arbol a -> Arbol a
takeArbol = undefined

-- ---------------------------------------------------------------------
-- Exercise 6.1. The function
--    repeat :: a -> [a]
-- is defined so that (repeat x) is the list of infinitely many x
-- elements. For example,
--    repeat 3  ==  [3,3,3,3,3,3,3,3,3,3,3,3,3,...
-- The definition of repeat is
--    repeat x = xs where xs = x:xs
-- 
-- Define the function
--    repeatArbol :: a -> Arbol a
-- such that (repeatArbol x) is the tree with infinitely many x nodes.
-- For example, 
--    takeArbol 0 (repeatArbol 3) == H 3
--    takeArbol 1 (repeatArbol 3) == N 3 (H 3) (H 3)
--    takeArbol 2 (repeatArbol 3) == N 3 (N 3 (H 3) (H 3)) (N 3 (H 3) (H 3))
-- ---------------------------------------------------------------------

repeatArbol :: a -> Arbol a
repeatArbol x = undefined

-- ---------------------------------------------------------------------
-- Exercise 6.2. The function 
--    replicate :: Int -> a -> [a]
-- is defined by 
--    replicate n = take n . repeat
-- such that (replicate n x) is the list of length n whose elements
-- are x. For example,
--    replicate 3 5  ==  [5,5,5]
-- 
-- Define the function 
--    replicateArbol :: Int -> a -> Arbol a
-- such that (replicateArbol n x) is the tree of depth n whose nodes are
-- x. For example,
--    replicateArbol 0 5  ==  H 5
--    replicateArbol 1 5  ==  N 5 (H 5) (H 5)
--    replicateArbol 2 5  ==  N 5 (N 5 (H 5) (H 5)) (N 5 (H 5) (H 5))
-- ---------------------------------------------------------------------

replicateArbol :: Int -> a -> Arbol a
replicateArbol n = undefined

-- ---------------------------------------------------------------------
-- Exercise 7.1. Define the function
--    mapArbol :: (a -> a) -> Arbol a -> Arbol a
-- such that (mapArbol f x) is the tree obtained by applying f to
-- each node of x. For example,
--    ghci> mapArbol (*2) (N 9 (N 3 (H 2) (H 4)) (H 7)) 
--    N 18 (N 6 (H 4) (H 8)) (H 14)
-- ---------------------------------------------------------------------

mapArbol :: (a -> a) -> Arbol a -> Arbol a
mapArbol = undefined

-- ---------------------------------------------------------------------
-- Exercise 8. Consider trees with boolean operations
-- defined by   
--    data ArbolB = HB Bool 
--                | Conj ArbolB ArbolB
--                | Disy ArbolB ArbolB
--                | Neg ArbolB
-- 
-- For example, the trees
--                Conj                            Conj          
--               /   \                           /   \          
--              /     \                         /     \         
--           Disy      Conj                  Disy      Conj     
--          /   \       /  \                /   \      /   \    
--       Conj    Neg   Neg True          Conj    Neg   Neg  True 
--       /  \    |     |                 /  \    |     |        
--    True False False False          True False True  False     
--
-- are defined by
--    ej1, ej2:: ArbolB
--    ej1 = Conj (Disy (Conj (HB True) (HB False))
--                     (Neg (HB False)))
--               (Conj (Neg (HB False))
--                     (HB True))
--    
--    ej2 = Conj (Disy (Conj (HB True) (HB False))
--                     (Neg (HB True)))
--               (Conj (Neg (HB False))
--                     (HB True))
-- 
-- Define the function 
--    valorB :: ArbolB -> Bool
-- such that (valorB ar) is the result of processing the tree by
-- performing the boolean operations specified at the nodes. For example,
--    valorB ej1 == True
--    valorB ej2 == False
-- ---------------------------------------------------------------------

data ArbolB = HB Bool 
            | Conj ArbolB ArbolB
            | Disy ArbolB ArbolB
            | Neg ArbolB

ej1, ej2:: ArbolB
ej1 = Conj (Disy (Conj (HB True) (HB False))
                 (Neg (HB False)))
           (Conj (Neg (HB False))
                 (HB True))

ej2 = Conj (Disy (Conj (HB True) (HB False))
                 (Neg (HB True)))
           (Conj (Neg (HB False))
                 (HB True))

valorB:: ArbolB -> Bool
valorB = undefined

-- ---------------------------------------------------------------------
-- Exercise 9. General trees can be represented using the
-- following data type  
--    data ArbolG a = N a [ArbolG a]
--                  deriving (Eq, Show)
-- For example, the trees
--      1               3               3
--     / \             /|\            / | \
--    2   3           / | \          /  |  \
--        |          5  4  7        5   4   7
--        4          |     /\       |   |  / \
--                   6    2  1      6   1 2   1
--                                     / \
--                                    2   3
--                                        |
--                                        4
-- are represented by
--    ejG1, ejG2, ejG3 :: ArbolG Int
--    ejG1 = N 1 [N 2 [],N 3 [N 4 []]]
--    ejG2 = N 3 [N 5 [N 6 []], 
--               N 4 [], 
--               N 7 [N 2 [], N 1 []]]
--    ejG3 = N 3 [N 5 [N 6 []], 
--               N 4 [N 1 [N 2 [],N 3 [N 4 []]]], 
--               N 7 [N 2 [], N 1 []]]
-- 
-- Define the function
--     ramifica :: ArbolG a -> ArbolG a -> (a -> Bool) -> ArbolG a
-- such that (ramifica a1 a2 p) is the tree resulting from adding a copy
-- of tree a2 to the nodes of a1 that satisfy predicate p. For
-- example, 
--    ramifica ejG1 (NG 8 []) (>4) =>  NG 1 [NG 2 [],NG 3 [NG 4 []]]
--    ramifica ejG1 (NG 8 []) (>3) =>  NG 1 [NG 2 [],NG 3 [NG 4 [NG 8 []]]]
--    ramifica ejG1 (NG 8 []) (>2) =>  NG 1 [NG 2 [],NG 3 [NG 4 [NG 8 []],NG 8 []]]
--    ramifica ejG1 (NG 8 []) (>1) =>  NG 1 [NG 2 [NG 8 []],NG 3 [NG 4 [NG 8 []],NG 8 []]]
--    ramifica ejG1 (NG 8 []) (>0) =>  NG 1 [NG 2 [NG 8 []],NG 3 [NG 4 [NG 8 []],NG 8 []],NG 8 []]
-- ---------------------------------------------------------------------

data ArbolG a = NG a [ArbolG a]
              deriving (Eq, Show)

ejG1, ejG2, ejG3 :: ArbolG Int
ejG1 = NG 1 [NG 2 [],NG 3 [NG 4 []]]
ejG2 = NG 3 [NG 5 [NG 6 []], 
           NG 4 [], 
           NG 7 [NG 2 [], NG 1 []]]
ejG3 = NG 3 [NG 5 [NG 6 []], 
           NG 4 [NG 1 [NG 2 [],NG 3 [NG 4 []]]], 
           NG 7 [NG 2 [], NG 1 []]]

ramifica :: ArbolG a -> ArbolG a -> (a -> Bool) -> ArbolG a
ramifica = undefined

-- ---------------------------------------------------------------------
-- Exercise 10. Define the function
--    nHojasG :: ArbolG a -> Int
-- such that (nHojasG x) is the number of leaves of tree x. For example,
--    nHojasG ejG1  ==  2
--    nHojasG ejG2  ==  4
--    nHojasG ejG3  ==  5
-- ---------------------------------------------------------------------

nHojasG :: ArbolG a -> Int
nHojasG = undefined

-- ---------------------------------------------------------------------
-- Exercise 11. Define the function
--    profundidadG :: ArbolG a -> Int
-- such that (profundidadG x) is the depth of tree x. For example,
--    profundidadG ejG1  ==  2
--    profundidadG ejG2  ==  2
--    profundidadG ejG3  ==  4
-- ---------------------------------------------------------------------

profundidadG :: ArbolG a -> Int
profundidadG = undefined

-- ---------------------------------------------------------------------
-- Exercise 12. Define the function
--    bin2gen :: ArbolG a -> Int
-- such that (bin2gen x) is the translation of tree x defined with type
-- "Arbol" (i.e., binary tree) to "ArbolG" (i.e., general tree).
-- For example,
--    bin2gen (N 9 (N 3 (H 2) (H 4)) (H 7)) ==  (NG 9 [NG 3 [NG 2 [],NG 4 []], NG 7 []])
-- ---------------------------------------------------------------------

bin2gen :: Arbol a -> ArbolG a
bin2gen = undefined
