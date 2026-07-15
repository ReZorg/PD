-- -----------------------------------------------------------------------------
-- Declarative Programming 2022/23
-- Degree in Computer Engineering - Information Technologies
-- September (second sitting)                     September 7, 2022
-- -----------------------------------------------------------------------------
-- Surnames:
-- Name:
-- UVUS:
-- -----------------------------------------------------------------------------

import Test.QuickCheck
import Data.Char
import Data.List
import Data.Array
import System.IO
import Data.List
import Text.CSV

-- -----------------------------------------------------------------------------
-- Exercise 1 (2,5 puntos)
-- Sheldon, Leonard, Penny, Rajesh and Howard are doing tail for a machine
-- of vending double "call tail". There are not more people expecting in the tail. The
-- first person (Sheldon) purchase a tin, drinks of her and duplicates ! This 
-- results in two Sheldon that they go  at the end of the tail. Afterwards it comes the
-- following (Leonard), buys a tin, drinks, duplicates  and the two Leonards
-- go  at the end of the tail, and like this successively. It asks  write a function
-- that say us the name of the person that drinks the n-ésima coca tail.
-- Clue: there are several forms to solve this exercise, for example with clear-cut
-- infinite lists with recursion without basic case, or functions like replicate, 
-- iterate or cycle can be useful.

-- For example,
-- > nCola personas 1
-- "Sheldon"
-- > nCola personas 52
-- "Penny"
-- > nCola personas 10010
-- "Howard"
-- -----------------------------------------------------------------------------

personas :: [String]
personas = ["Sheldon", "Leonard", "Penny", "Rajesh", "Howard"]

-- Recursive solution
nColaAux :: [String] -> [Int] -> [String]
nColaAux (p:ps) (n:ns) = (replicate n p) ++ (nColaAux (ps++[p]) (ns++[2*n]))

nCola :: [String] -> Int -> String
nCola ps n = cola !! (n-1) 
    where cola = nColaAux ps (replicate (length ps) 1)

-- Solution with cycle and iterate
nColaAux2 :: [String] -> [String]
nColaAux2 ps = concat [ replicate i p | (p,i) <- zip (cycle ps) ns' ]
    where ns' = concat $ iterate (map (*2)) ns 
          ns = (replicate (length ps) 1)

nCola2 :: [String] -> Int -> String
nCola2 ps n = nColaAux2 ps !! (n-1) 

-- Solution with recursion only
nCola3 :: [String] -> Int -> String
nCola3 ps n = 
    let p = head ps
        l = length ps
    in if n <= l
        then ps !!(n-1)
        else nCola3 ((tail ps)++[p,p]) (n-1)

-- Solution with recursion only 2
nCola4 :: [String] -> Int -> String
nCola4 ps 1 = head ps
nCola4 ps n = nCola4 ((tail ps)++[p,p]) (n-1)
    where p = head ps

-- Time comparison
-- *Main> nCola personas 10010 
-- "Howard"
-- (0.01 secs, 1,244,592 bytes)
-- *Main> nCola2 personas 10010
-- "Howard"
-- (0.01 secs, 1,220,496 bytes)
-- *Main> nCola3 personas 10010
-- "Howard"
-- (1.01 secs, 704,258,648 bytes)
-- *Main> nCola4 personas 10010
-- "Howard"
-- (1.92 secs, 2,227,369,880 bytes)

-- -----------------------------------------------------------------------------
-- Exercise 2 (2,5 puntos)

-- will define a generic tree with the following type of algebraic data:

-- it dates Arbol to = N to [Arbol to] deriving Show

-- to) Need to mark values of the tree like deleted. To continuation,
-- extends the anterior definition so that a tree also can be
-- a node without value of type to associated, but with a list of trees.
-- Llama to the constructor "R".

data Arbol a = N a [Arbol a] | R [Arbol a]
    deriving Show

-- b) Defines the function (eliminaRama rs a), such that given a generic tree to and
-- a ready rs that represents a possible branch of the tree, give the tree
-- deleting all the repetitions of said branch. The elimination of a 
-- value in the tree does  simply changing the constructor of the node N
-- by R. We understand by branch a succession of elements that are in the tree,
-- following order of hierarchy: that is to say, the first element is father of the second,
-- the second is father of the third, etc. For example, suppose the following tree:
--
--        __5___ 
--       |  |   |
--       3  2  _5___
--       |    | | | |
--       0    1 0 2 3
-- 
-- If we delete the branch [5,3,0], would obtain:
--
--        __R___ 
--       |  |   |
--       R  2  _5___
--       |    | | | |
--       R    1 0 2 3
-- 
-- However, when trying delete the branch [6,7] obtain the tree without 
-- modifying, since such branch does not exist. Finally, to the delete the branch [5,3],
-- would have to delete all the apparitions:
--
--        __R___ 
--       |  |   |
--       R  2  _R___
--       |    | | | |
--       0    1 0 2 R
--
-- Note 1: By simplicity, can assume that the nodes R of the tree of entrance
-- do not form part of any branch.
-- It note 2: If the branch is empty, does not delete  any node in the tree.
--
-- For example:
-- > eliminaRama [5,3,0] arbol1
-- R [R [R []],N 2 [],N 5 [N 1 [],N 0 [],N 2 [],N 3 []]]
-- > eliminaRama [5,3] arbol1  
-- R [R [N 0 []],N 2 [],N 5 [N 1 [],N 0 [],N 2 [],R []]]
-- > eliminaRama [3,5] arbol1
-- N 5 [N 3 [N 0 []],N 2 [],N 5 [N 1 [],N 0 [],N 2 [],N 3 []]]
-- > eliminaRama [1,1] arbol2
-- R [N 0 [R []],R [R [],N 0 []]]
-- > eliminaRama [0,1] arbol2
-- N 1 [R [R []],N 1 [N 1 [],N 0 []]]
-- > eliminaRama [] arbol2   
-- N 1 [N 0 [N 1 []],N 1 [N 1 [],N 0 []]]

arbol1, arbol2 :: Arbol Int
arbol1 = N 5 [N 3 [N 0 []], N 2 [], N 5 [N 1 [], N 0 [], N 2 [], N 3 []]]
arbol2 = N 1 [N 0 [N 1 []], N 1 [N 1 [], N 0 []]]

eliminaRama :: Eq a => [a] -> Arbol a -> Arbol a 
eliminaRama [] a = a 
eliminaRama rs a@(N v as) 
     | esRamaInmediata rs a = R (map (eliminaRama rs . eliminaRama (tail rs)) as)
     | otherwise = N v (map (eliminaRama rs) as)
eliminaRama _ (R as) = R as      

esRamaInmediata :: Eq a => [a] -> Arbol a -> Bool
esRamaInmediata [] _ = True
esRamaInmediata [r] (N v []) = r == v
esRamaInmediata (r:rs) (N v as) = (v == r && any (esRamaInmediata rs) as) 
esRamaInmediata _ _ = False


-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Exercise 3 (2,5 puntos)
-- In neural nets, the function of pooling is very important. In this
-- exercise asks  make a very basic implementation. In round-up, this 
-- function receives a matrix m, a size of window v and a function f, and 
-- give a matrix that is the result to apply f to the submatrices of
-- size v x v (sin solapamiento) of the matrix m. See it in more detail.
-- Specifically, we will say that the function of pooling receives:
--    a matrix m squared of size n x n, with n >= 1. If the matrix is not
--     squared, then give Nothing.
--    A size of window v. Like restriction, will ask that v was divisor 
--     of n, and v >= 1. If it is not like this, the function give Nothing. 
--    A function of aggregation f on lists, for example, sum, maximum, minimum
--     half, etc.
-- The function of pooling works as follows (ver el ejemplo de abajo):
--    the matrix resulted has a size of n' x n', with n' = n / v
--    form  windows (submatrices) of v x v of the matrix m, without solapamiento.
--    The matrix resulted has a position by window, that corresponds to the 
--     result to apply the function f to the elements of the corresponding 
--     window.
--
-- To clear it, put an example. We suppose that n = 4, v = 2, and m is
--                                                
--  ┌         ┐                                   
--  │ 1 2 3 4 |                                  
--  │ 5 6 7 8 |   
--  │ 9 8 7 6 |                                   
--  │ 5 4 3 2 |                                  
--  └         ┘                                  
--
-- the divisón of the matrix with a window of 2x2 is:  

--  ┌     |     ┐ 
--  │ 1 2 | 3 4 |  
--  │ 5 6 | 7 8 |
--  |-----+-----|
--  │ 9 8 | 7 6 | 
--  │ 5 4 | 3 2 |  
--  └     |     ┘ 
-- 
-- we Suppose that f = maximo. Like the elements of the first window are [1,2.5,6],
-- the result of f is 6. At the end, the result is a matrix of 2x2 (since 
-- n=4, v=2, n/v = 2):
--  ┌     ┐ 
--  | 6 8 |
--  | 9 7 |
--  └     ┘
-- 
-- it asks  define the function (pooling m v f), where m is the matrix of entrance,
-- v the size of the window, and f the function of aggregation. The result is a
-- Maybe Matrix, since if v is not divisor of n, neither main or the same that 1, and m 
-- is not squared, then give Nothing. For example:

type Matriz = Array (Int,Int) Float

mej1,mej2 :: Matriz
mej1 = listArray ((1,1),(4,4)) [1,2,3,4,
                                5,6,7,8,
                                9,8,7,6,
                                5,4,3,2]                               
mej2 = listArray ((1,1),(10,10)) [1..100]

-- > pooling mej1 2 maximum
-- Just (array ((1,1),(2,2)) [((1,1),6.0),((1,2),8.0),((2,1),9.0),((2,2),7.0)])
-- > pooling mej1 2 sum    
-- Just (array ((1,1),(2,2)) [((1,1),14.0),((1,2),22.0),((2,1),26.0),((2,2),18.0)])
-- > pooling mej2 5 minimum
-- Just (array ((1,1),(2,2)) [((1,1),1.0),((1,2),6.0),((2,1),51.0),((2,2),56.0)])
-- > pooling mej2 5 (\xs -> sum xs / (fromIntegral (length xs)))
-- Just (array ((1,1),(2,2)) [((1,1),23.0),((1,2),28.0),((2,1),73.0),((2,2),78.0)])
-- > pooling (listArray ((1,1),(1,2)) [3,4]) 2 maximum
-- Nothing
-- > pooling mej2 3 minimum                                     
-- Nothing
-- > pooling mej2 0 minimum                                     
-- Nothing

-- It note: by simplicity, can assume that the indexes of m begin in (1,1)


pooling :: Matriz -> Int -> ([Float] -> Float) -> Maybe Matriz
pooling m v f 
    | n1 /= n2 || mod n1 v /= 0 || v <= 0 = Nothing 
    | otherwise = Just $ listArray ((1,1),(n',n')) [ g i j | i <- [0..n'-1], j <- [0..n'-1] ]
  where g i j = f [ m!(x,y) | x <- [i*v+1 .. (i+1)*v], y <- [j*v+1 .. (j+1)*v] ]
        n2 = snd (snd (bounds m))
        n1 = fst (snd (bounds m))
        n' = div n1 v



-- -----------------------------------------------------------------------------
-- Exercise 4 (2,5 puntos)
--
-- Years backwards, before the boom of the data, did not exist a format of 
-- storage standardised and almost each programmer defined his own
-- format of storage in way text. To be able to do use of these
-- historical data in the new algorithms of automatic learning 
-- is necessary to convert these formats to a format estandar as for example
--  CSV. 
--
-- In this exercise asks  make a function that convert the file
-- note.txt To a format CSV valid using like separador of columns
-- the comma ",". Once converted, save the result in "notes.csv"
-- And read with the package Text.CSV Showing by screen his content.
--
-- Expected result on disk for Notes.csv:
--
-- Name,Surnames,Note
-- David,Martinez Rojas,7.5
-- Juan,Perez Vera,6.4
-- Manuel,Durán Veleño,4.5
-- Miguel,Pereila Rodriguez,3.1
-- Sandra,Sánchez Rojas,6.5 
--
-- Expected screen output after reading with Test.CSV:
--
-- "Nombre","Apellidos","Nota"
-- "David","Martinez Rojas","7.5"
-- "Juan","Perez Vera","6.4"
-- "Manuel","Durán Veleño","4.5"
-- "Miguel","Pereila Rodriguez","3.1"
-- "Sandra","Sánchez Rojas","6.5"
--
-- Help: The function intrecalate carry the union of a list of chains
-- using another chain that intercalará among each one of the elements of the 
-- chain.
--
-- > intercalate "," ["uno", "dos", "tres"]
-- "uno,dos,tres"



reemplazar :: Eq a => a -> a -> [a] -> [a]
reemplazar c1 c2 = map $ \c -> if c == c1 then c2 else c

recortarInicio :: String -> String
recortarInicio "" = ""
recortarInicio cadena 
 | head cadena == ' ' = recortarInicio (tail cadena)
 | otherwise = cadena
 
recortar :: String -> String 
recortar = recortarInicio . reverse . recortarInicio . reverse

formatearLinea :: String -> String
formatearLinea = (intercalate ",") . (map recortar) . lines . (reemplazar '|' '\n') . init . tail

formatearLineas :: [String] -> String
formatearLineas = (intercalate "\n") . map formatearLinea

convertir :: FilePath -> IO ()
convertir fichero = do
 contenido <- readFile fichero
 let lineas = lines contenido
 let lineasFormateadas = formatearLineas ((lineas!!1):((iterate tail (init lineas)) !! 3))

 writeFile "notas.csv" lineasFormateadas
 
 return ()

main = do
  convertir "notas.txt"
  
  contenido <- readFile "notas.csv"
  let csv = parseCSV "notas.csv" contenido
      filas = case csv of
          (Right lineasCSV) -> lineasCSV
          _ -> []
          
  putStrLn $ printCSV filas
