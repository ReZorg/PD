-- Declarative Programming
-- Degree in Computer Engineering - Information Technologies
-- Midterm 2                                       January 17, 2019
-- -------------------------------------------------------------------
-- Surnames:
-- Name:
-- -------------------------------------------------------------------
-- IMPORTANT NOTICES
-- · Before continuing, change the name of this file to:
--                   Parcial2_<uvus>.hs
--   where <uvus> must be your virtual username.
-- · Write the solution to each exercise in the space reserved for
--   it.
-- · Make sure you correctly use the name and type indicated
--   for each requested function. You may add as many helper
--   functions (including the type properly) as you need,
--   describing their purpose.
-- -------------------------------------------------------------------

import Text.CSV
import PilaConTipoDeDatoAlgebraico
import Data.Matrix
import System.Environment (getArgs)

-- -------------------------------------------------------------------
-- Exercise 1. [1,75 points]
-- Regarding the connect four game...
--
-- 1. Define the following types:
--    * A new data type Ficha, indicating a Red or Blue piece.
--    * A type Columna, synonym for a list of pieces.
--    * A new data type CuatroEnRaya,
--      with a list-of-columns constructor.
-- 2. Define the function colocaFicha, which receives a piece, the number of
--    the column in which to place the piece (starting at 1) and a board
--    of type connect four, and returns the updated board.
--
-- ---------------------------------------------------------------------


-- ---------------------------------------------------------------------
-- Exercise 2. [1,75 points]
-- There is a need to work with trees that adopt
-- flexible types. To do this:
--
-- 1. Define a polymorphic tree type that accepts any three data types
-- (possibly different) and admits two constructors:
--    * One for nodes, which receives an element of pair type a and b,
--      and three child trees of the same type as the parent
--    * Another for leaves, which contain an element of pair type a and c
-- 2. Define the function devuelveValidos, which receives a predicate p and a
--    tree of types, and returns a pair of lists, the first containing
--    the data of type b from the nodes that satisfy p and
--    the second of type c from the leaves that do not satisfy p
--
-- ---------------------------------------------------------------------


-- -------------------------------------------------------------------
-- Exercise 3. [2 points]

-- 1. Define, with record syntax, a new type that contains the
--    information about planets that appear in the
--    Star Wars movies:
--    * name, diameter, population, of type String
--    * residents, of type list of String

-- 2. Make the previous type have a default value,
-- so that we can later create elements of the type
-- without needing to provide all the requested data

-- 3. Define a type synonym for a list of planets

-- 4. Write a main program that:
--    a) Imports the file "planets.json",
--    b) For each planet, prints on screen its name,
--       followed by its radius (half of its diameter)
--    ** Note: if you cannot solve this part,
--             you may choose a simplified exercise,
--             for 1.5 points, that instead of "planets.json"
--             processes "planet.json", containing a single
--             planet, and returns its name
--             along with the number of notable residents
--             (see residents)
-- -------------------------------------------------------------------


-----------------------------------------------------------------------
-- Exercise 4. [1 point]
--
-- The following program loads the contents of the file "cars-2018.csv",
-- parses it and then processes header and body, which
-- at this moment are unimplemented.

-- The following implementation is requested for those functions:
-- a) Process the header, printing for each of its fields
--    its number and line, in the following form:
--    1: "year"
--    2: "make"
--    ...
--
--   * Note: for half credit, you may print only
--            the field name.
--
-- b) Process the first 20 records, printing for each one the year,
--    make, model and number of main styles
--    
--   * Note: for half credit, you may limit yourself to
--           processing all records and printing year, make and model
--          
-----------------------------------------------------------------------

coches :: IO ()
coches = do
  args <- getArgs
  let filename = if null args then "cars-2018.csv" else args!!0
  contents <- readFile filename

  let csv = parseCSV filename contents
      filas = case csv of
        (Left _) -> []
        (Right lineas) -> lineas
      filasValidas = filter (\x -> length x == 4) filas

  procesaCabecera (head filasValidas)
  procesaContenido (tail filasValidas)

procesaCabecera = undefined
procesaContenido = undefined

-- Helper function:
pasaALista :: Field -> [String]
pasaALista cadena = read cadena::[String]

-- ---------------------------------------------------------------------
-- Exercise 5. [1,5 points]
-- A sparse matrix is one whose elements are
-- mostly zero. The representation of sparse matrices is
-- usually made in dense form, that is, leaving the nonzero elements
-- but recording in which original position they were. In this exercise
-- it is requested to build the dense representation of a matrix p as follows:
--   - a matrix q of nxm', where n is the number of rows of p and m'
--     is the greatest number of nonzero elements in the rows of p. For
--     example, m' for matrizEj is 2, since the second row has 2
--     nonzero elements.
--   - the elements of matrix q are pairs (Int,Double), where the
--     first of the pair is the column where the element appeared, and the
--     second is the element itself. If the column has fewer
--     nonzero elements than m', then it is filled with pairs (0,0.0).
-- ---------------------------------------------------------------------

matrizEj :: Matrix Double
matrizEj = fromLists [[0.0,0.0,2.1],[1.6,0.0,-2.5],[0.5,0.0,0.0]]

-- Exercise 5.1. Define the function (colsNoNulas i p), such that it returns
-- a list of pairs (j,v) for each nonzero value v in row i, where
-- j is the column where it appears. For example,
--   colsNoNulas 2 matrizEj == [(1,1.6),(3,-2.5)]


-- Exercise 5.2. Define the function (completaLista n xs x), such that
-- it returns a list with n elements, first including those of xs,
-- and filling the rest with x. For example,
--   completaLista 5 [3,4,2] 0 == [3,4,2,0,0]


-- Exercise 5.3. Define the function (matrizDensa p), such that it returns
-- the matrix with dense representation, described above, of p.
-- For example, toLists (matrizDensa matrizEj) ==
--      [[(3,2.1),(0,0.0)],[(1,1.6),(3,-2.5)],[(1,0.5),(0,0.0)]]


-- ---------------------------------------------------------------------
-- Exercise 6. [1 point]
-- We represent stacks using the ADT defined in the file
-- included in the statement header. Using only the functions
-- of the ADT (without converting the data to lists), define the function
-- (ultimoElemPila p pila), which returns exactly the last element of
-- the stack that satisfies predicate p, or Nothing if none satisfies it.
-- For example,
--   ultimoElemPila even ejPila == Just 10
--   ultimoElemPila odd ejPila == Nothing
--   ultimoElemPila (<5) ejPila == Just 4

ejPila :: Pila Int
ejPila = foldr apila vacia [2,4,6,8,10]


-- ---------------------------------------------------------------------
-- Exercise 7.1 [0.5 points]
-- An integer n is square-free if there is no prime number
-- p such that p^2 divides n. For example, 10 is square-free because
-- 10 = 2*5, but 12 is not because it is divisible by 2^2. Define
-- the function (libresDeCuadrado m) that returns the list of booleans
-- indicating for each number between 1 and m whether it is square-free.
-- For example,
--   libresDeCuadrado 10 ==
--          [True,True,True,False,True,True,True,False,False,True]


-- Exercise 7.2 [0.5 points] Parallelize the definition of libresDeCuadrado
-- using the parallel map function seen in theory. Indicate in a
-- comment what speedup is achieved when comparing the
-- sequential version (previous) and parallel version (requested here) with m=5000.



-- Note: use this main function to check each version
{-main = do
    let oxs = parLibresDeCuadrado 5000 
    print $ length $ filter (\a -> a) oxs
    return (oxs) -}

-- speedup = 11,616s / 1,451s = 8x
