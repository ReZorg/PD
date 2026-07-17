-- -----------------------------------------------------------------------------
-- Declarative Programming 2021/22
-- Degree in Computer Engineering - Information Technologies
-- January (first sitting)                              January 25, 2022
-- -----------------------------------------------------------------------------
-- Surnames:
-- Name:
-- UVUS:
-- -----------------------------------------------------------------------------

import Test.QuickCheck
import Data.Char
import Data.List
import Data.Array

-- -----------------------------------------------------------------------------
-- Exercise 1.1 (2,5 puntos)
-- Given two chains of text ace and bs, defines the function (convertir as bs) that
-- convert the chain ace in the bs. For this consider  so alone two 
-- possible operations:
--    1. delete The last letter of the chain ace. 
--    2. add A letter at the end of the chain ace.
-- The function has to give the list of necessary operations to make the 
-- conversion. For example:
--
-- > convertir "" "hola"
-- ["add h","add o","add l","add a"]
-- > convertir "hola que tal" "hola"
-- ["delete","delete","delete","delete","delete","delete","delete","delete"]
-- > convertir "holitas" "hola"
-- ["delete","delete","delete","delete","add a"]
-- > convertir "hotla" "hola"
-- ["delete","delete","delete","add l","add a"
-- > convertir "aaa" "ba"    
-- ["delete","delete","delete","add b","add a"]

-- One solution
ultimos :: Int -> [a] -> [a]
ultimos n = reverse . take n . reverse

convertir :: String -> String -> [String]  
convertir so sd = convertir_aux so sd [] []  

convertir_aux :: [Char] -> [Char] -> [Char] -> [[Char]] -> [[Char]]
convertir_aux [] [] sdi op = op ++ ["add " ++ [l] | l <- sdi]
convertir_aux [] sdd [] op = op ++ ["add " ++ [l] | l <- sdd]
convertir_aux so sdd sdi op 
   | lso > lsdd = convertir_aux (take lsdd so) sdd [] (take (lso - lsdd) (repeat "delete"))
   | so == sdd  = convertir_aux [] [] sdi op
   | lso < lsdd = convertir_aux so (take lso sdd) (ultimos (lsdd - lso) sdd) [] 
   | otherwise  = convertir_aux (init so) (init sdd) ((last sdd):sdi) (op ++ ["delete"])
   where 
       lsdd = length sdd 
       lso = length so

-- Another solution
convertir' :: String -> String -> [String]
convertir' as bs 
  | as == bs = []
  | esPrefijo as bs = ("add " ++ c) : convertir' (as++c) bs
  | otherwise = "delete" : convertir' as' bs
  where c = take 1 (drop (length as) bs)
        as' = take (length as - 1) as
        esPrefijo = isPrefixOf     -- Defined in Dates.List
        --esPrefijo [] _ = True    -- Also can  define manually
        --esPrefijo xs ys =  xs == take (length xs) ys

-- Exercise 1.2 (0,5 puntos)
-- Checks with quickCheck that any chain ace can turn bs, that is to say
--, that the sequence of operations never is empty, unless ace was
-- equal that bs.

prop_convierte :: String -> String -> Property 
prop_convierte as bs = as /= bs ==> not (null (convertir as bs))

-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Exercise 2 (2,5 puntos)
-- will use the type of algebraic data of tree with alone values in the nodes:

data Arbol a = H | N a (Arbol a) (Arbol a)
  deriving (Show, Eq)

-- A tree To is subcontenido in another tree B if the elements of To appear
-- in B respecting the order of hierarchy. This is, for each node n of the tree To, 
-- fulfils  the following:
--    The value of the node n is in the tree B. It was m the node with this value in B.
--    The subárbol left of the node n is subcontenido in the subárbol 
--     left of the node m (ídem para el subárbol derecho). 
--    A tree that is a node leaf always is subcontenido in another tree.
-- For example, suppose the following trees:
--  a1:        a2:            a3:        a4:
--      3            2           3           3
--     / \          / \         / \         / \
--    2   1        3   1       4   1       2   4
--                            /           / \
--                           2           6   0
--                                      /     \      
--                                     3       1
--
-- The tree a1 is subcontenido in a3 and the tree a2 is subcontenido in a4. 
-- But a1 is not subcontenido in a4 neither in a2 (share root, and the subárbol
-- left is subcontenido, but no the subárbol right), and neither a2 is 
-- in a3 (el nodo 2 está en a3, pero en a3 no tiene subárboles).
-- It defines the function (subcontenido a1 a2) such that check that the tree a1
-- is subcontenido in a2.

a1,a2,a3,a4 :: Arbol Int 
a1 = N 3 (N 2 H H) (N 1 H H) 
a2 = N 2 (N 3 H H) (N 1 H H)
a3 = N 3 (N 4 (N 2 H H) H) (N 1 H H)
a4 = N 3 (N 2 (N 6 (N 3 H H) H) (N 0 H (N 1 H H))) (N 4 H H)

-- > subcontenido a1 a3
-- True
-- > subcontenido a1 a4
-- False
-- > subcontenido a2 a4
-- True
-- > subcontenido a2 a3
-- False
-- > subcontenido a2 a1
-- False
-- > subcontenido a1 a2
-- False
 
subcontenido :: Eq a => Arbol a -> Arbol a -> Bool
subcontenido H _ = True
subcontenido a1@(N n i1 d1) (N m i2 d2) 
  | n == m = subcontenido i1 i2 && subcontenido d1 d2
  | otherwise = subcontenido a1 i2 || subcontenido a1 d2
subcontenido _ _ = False

-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Exercise 3 (2 puntos)
-- Defines the function (pliegaMatriz m f), where m is a matrix of two dimensions,
-- and f is a function of two arguments, (f x y). Fold a matrix is the result
-- to apply the function f, element to element, to the first column with the last
-- column, the second with the penultimate, the third with the antepenultimate...
-- The penultimate with the second and the last with the first. If the column has a
-- number impar of columns, f applies  to the central column with her same. For example
--, we suppose the following matrix with a number impar of columns and f = +:
--  ┌           ┐            ┌                                         ┐        ┌             ┐
--  │ 1 2 3 4 5 |   it folds   | (f 1 5) (f 2 4) (f 3 3) (f 4 2) (f 5 1) |  f=+   | 6  6 6 6 6  |
--  │ 2 3 1 6 8 |  ------->  | (f 2 8) (f 3 6) (f 1 1) (f 6 3) (f 8 2) |  --->  | 10 9 2 9 10 |
--  └           ┘            └                                         ┘        └             ┘
--  Another example with a number pair of columns and f = ^:             
--  ┌         ┐            ┌                                 ┐        ┌          ┐
--  | 3 4 2 1 |   it folds   | (f 3 1) (f 4 2) (f 2 4) (f 1 3) |  f=^   | 3 16 8 1 |
--  | 2 3 3 2 |  ------->  | (f 2 3) (f 3 3) (f 3 3) (f 2 2) |  --->  | 4 9  9 4 |
--  | 1 2 3 4 |            | (f 1 4) (f 2 3) (f 3 2) (f 4 1) |        | 1 8  9 4 |
--  └         ┘            └                                 ┘        └          ┘                                                     
-- NOTE: it will achieve  the note to the complete if the function accepts any rank of 
-- indexes for the columns; that is to say, no always they have why begin by the 1, 
-- also by the 0, like mej3. If you do not achieve it but you do it work for
-- ranks that begin by 1 (como mej1 y mej2), will obtain the half of the note in the
-- exercise.
--
mej1,mej2,mej3 :: Array (Int,Int) Int
mej1 = listArray ((1,1),(2,5)) [1,2,3,4,5,
                               2,3,1,6,8]
mej2 = listArray ((1,1),(3,4)) [3,4,2,1,
                               2,3,3,2,
                               1,2,3,4]                               
mej3 = listArray ((0,0),(2,5)) [5,6,3,3,2,2,
                               5,2,3,3,0,2,
                               5,2,3,3,2,2]

-- > elems $ pliegaMatriz (+) mej1
-- [6, 6,6,6,6,
--  10,9,2,9,10]
-- > elems $ pliegaMatriz (+) mej2
-- [4,6,6,4,
--  4,6,6,4,
--  5,5,5,5]
-- > elems $ pliegaMatriz (^) mej2
-- [3,16,16,1,
--  4,27,27,4,
--  1,8, 9, 4]
-- *Main> elems $ pliegaMatriz (*) mej3
-- [10,12,9,9,12,10,
--  10,0, 9,9,0, 10,
--  10,4, 9,9,4, 10]

pliegaMatriz f m = listArray (bounds m) [ g i j | (i,j) <- indices m]
  where g i j = f (m!(i,j)) (m!(i,c2-j+c1))
        c2 = snd (snd (bounds m))
        c1 = snd (fst(bounds m))

-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Exercise 4 (2,5 puntos)
-- asks  implement a menu desplegable in ASCII. For this will have to print  
-- by screen a first corresponding line to the options of the main menu
--  (File, Edit, Exit). This first line has to go with the blue fund. The
-- options "File" and "Edit" have associated a submenu. When it selects 
-- one of these options, the submenu corresponding has to show  under her.
-- The options of menu select  by means of a letter that is highlighted in 
-- red. To print by screen in colour, so much the letters like the fund, have to
-- use  the codes of leakage contributed. For example, if we want to print in colour red
--   a text, print by screen the code is red leakage, next 
-- the text and finally the code of white leakage to go back to usual colour.
-- It tries the following example
--
-- > putStrLn (rojo ++ "Hola" ++ blanco ++ " mundo")   
--
-- Also  propocionar a function to clean the screen and a list with the 
-- structure of menu. The tuplas (Int, String), represent the index of the letter to 
-- highlight in red and the text of the option of menu or submenú. Each option of menu can
-- have associated a list of options of submenu. In the case of "Exit", this list 
-- is vacia, since it does not have submenu associated.
--
-- It note: see the video with the functionality expected to implement.

-- This function clears the screen
limpiar = putStr "\ESC[2J"

-- Colour escape codes
rojo = "\ESC[31m" 
blanco = "\ESC[37m"
fondo_azul = "\ESC[44m"
fondo_negro = "\ESC[40m"


menu :: [((Int, String), [(Int, String)])]
menu = [((1, "File"), [(1, "Load"), (1, "Save")]), ((1, "Edit"), [(1, "Redo"), (1, "Copy"), (1, "Paste")]), ((1, "Exit"), [] )]

-- Student code...

colorea :: String -> String -> Int -> String
colorea color opcion pos = concat [if pos == i then color ++ (c:blanco) else [c] | (c, i) <- zip opcion [1..] ]  

espacios n = replicate n ' '

muestra_submenu :: [((Int, String), [(Int, String)])] -> Int -> IO()  
muestra_submenu menu i = do
    let sm = snd (menu!!i)
    let submenu_pos = 1 + sum (take i [1 + (length opcion) | ((_, opcion), _) <- menu])
    sequence_ [putStrLn ((espacios submenu_pos) ++ (colorea rojo opcion pos)) | (pos, opcion) <- sm] 
    putStrLn "" 
        
muestra_menu menu = do
    limpiar
    let opciones = concat [((colorea rojo opcion pos) ++ " ") | ((pos, opcion), _) <- menu] 
    putStrLn (fondo_azul ++ opciones ++ (espacios (157 - length opciones)) ++ fondo_negro)

gestiona_menu submenu letra = do
    if submenu /= (-1) then do   
        muestra_menu menu
        muestra_submenu menu submenu
    else do
        muestra_menu menu
        putStrLn ""

    if letra /= "" then
        putStrLn ("Last key pressed: " ++ letra)
    else
        putStr ""

    putStrLn "Press a menu option letter"
    --c <- getChar   -- In Linux
    c <- fmap head getLine      -- in Windows
    let o = toUpper c
    limpiar
    
    case o of
        'A' -> do 
            gestiona_menu 0 "A"
        'E' -> gestiona_menu 1 "E"
        'S' -> return ()
        _   -> gestiona_menu (-1) [o] 


main = do
    limpiar
    gestiona_menu (-1) ""

-- -----------------------------------------------------------------------------