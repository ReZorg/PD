-- -----------------------------------------------------------------------------
-- Declarative Programming 2021/22
-- Degree in Computer Engineering - Information Technologies
-- Midterm 1 (group 1)                                   November 10, 2021
-- -----------------------------------------------------------------------------
-- Surnames:
-- Name:
-- UVUS:
-- -----------------------------------------------------------------------------

import Test.QuickCheck
import Data.Char
import Data.List

-- -----------------------------------------------------------------------------
-- Exercise 1 (2 puntos)
-- Define the operator infijo (/++) such that receive two lists xs and ys, and give 
-- the result to concatenate them, but removing the last element of xs and the 
-- the first of ys. It has to have the same precedence that the operator (++), which
-- can use  for the solution of this exercise. For example:
-- > [] /++ [3,4]
-- [4]
-- > [1] /++ []
-- []
-- > [2,3] /++ [4,3,5] /++ [6,7]
-- [2,3,7]
-- > [1,2] /++ [3,4] ++ [5,6]
-- [1,4,5,6]
-- -----------------------------------------------------------------------------

(/++) :: [a] -> [a] -> [a]   
[] /++ [] = []
[] /++ ys = tail ys
xs /++ [] = init xs
xs /++ ys = init xs ++ tail ys
     
infixr 5 /++   

-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Exercise 2.1 (1 punto) Defines the function (mediaDeMediasR xss) such that receive
-- a list of lists of numbers, and calculate the average of the averages of the 
-- sublistas. It will not calculate  the average for sublistas empty, although yes it will count
-- for the total average; that is to say, the average of the sublistas empty is 0.
-- It defines the function employing only RECURSION for xss. For example,
--  > mediaDeMediasR [[2,4]]
--  3.0
--  > mediaDeMediasR [[2,4],[]]
--  1.5
--  > mediaDeMediasR [[2,4],[2,3],[3,4,5,6]]
--  3.3333333333333335

mediaDeMediasR :: Floating a => [[a]] -> a 
mediaDeMediasR xss = sumaDeMediasR xss / genericLength xss

sumaDeMediasR :: Floating a => [[a]] -> a 
sumaDeMediasR [] = 0
sumaDeMediasR ([]:xss) = sumaDeMediasR xss
sumaDeMediasR (xs:xss) = (media xs) + sumaDeMediasR xss

media :: Floating a => [a] -> a 
media xs = sum xs / genericLength xs
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Exercise 2.2 (1 punto) Defines the function (mediaDeMediasO xss) like the anterior,
-- but using UPPER ORDER to visit the elements of xss. For example,
--  > mediaDeMediasO [[2,4]]
--  3.0
--  > mediaDeMediasO [[2,4],[]]
--  1.5
--  > mediaDeMediasO [[2,4],[2,3],[3,4,5,6]]
--  3.3333333333333335
-- -----------------------------------------------------------------------------

mediaDeMediasO :: Floating a => [[a]] -> a 
mediaDeMediasO xss = sum (map media (filter (not.null) xss)) / genericLength xss

-- -----------------------------------------------------------------------------
-- Exercise 2.3 (1 punto) Checks with quickCheck that for any list of
-- lists no empty and that do not include any sublista empty, if the average of averages
-- is equal to the average of concatenation of his lists. If there is a counterexample, 
-- copy and paste it like a commentary.
-- -----------------------------------------------------------------------------

prop_medias :: (Ord a,Floating a) => [[a]] -> Property
prop_medias xss = not (null xss) && notElem [] xss ==> mediaDeMediasO xss == media (concat xss)

-- > quickCheck prop_medias 
--  Failed! Falsified (after 3 tests and 3 shrinks):    
-- [[0.0,0.0],[1.0]]

-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Exercise 3 (2,5 puntos). The schedule of class can represent  like a
-- list of tuplas where:
--    the first component is the day of the week, 
--    the second component a list of pairs, where:
--      - the first component is an integer that represents the hour
--      - the second component is a list with names abridged of 
--        subjects (is possible that step us  the schedule, therefore they 
--        can have several subjects to the same hour).

horario :: [([Char], [(Int, [[Char]])])]
horario =  [ ("Lun",[(8,[]),(9,[]),(10,[]),(11,[]),(12,[]),(13,["TAI"]),(14,["TAI"])]),
             ("Mar",[(8,[]),(9,["IA"]),(10,["IA"]),(11,["CIMSI"]),(12,["CIMSI"]),(13,["TAI"]),(14,["TAI"])]),
             ("Mie",[(8,[]),(9,[]),(10,[]),(11,["GSI"]),(12,["GSI"]),(13,["PD"]),(14,["PD"])]),
             ("Jue",[(8,[]),(9,[]),(10,[]),(11,[]),(12,[]),(13,["IA"]),(14,["IA"])]),
             ("Vie",[(8,[]),(9,["CIMSI","GSI"]),(10,["CIMSI","GSI"]),(11,["CIMSI","GSI"]),(12,["CIMSI","GSI"]),(13,["PD"]),(14,["PD"])])]

-- It defines the function (horarioAsignatura hss a), such that receive a schedule hss
-- like the anterior and the name abridged of a subject, and give the
-- the schedule of classes of said subject with the following format: a list
-- of triples where the first component is the day, and the second and third
-- component are the hour of start and hour of end (en rangos de una hora).
-- For example,
--  > horarioAsignatura horario "IA"
--  [("Mar",9,10),("Jue",13,14)]
--  > horarioAsignatura horario "PD"
--  [("Mie",13,14),("Vie",13,14)]
--  > horarioAsignatura horario "GSI"
--  [("Mie",11,12),("Vie",9,10),("Vie",10,11),("Vie",11,12)]
-- -----------------------------------------------------------------------------

horarioAsignatura :: [(String, [(Int, [String])])] -> String -> [(String, Int, Int)]
horarioAsignatura hss a =  [ (d1,h1,h2)  | ((d1,h1),(d2,h2))  <- zip horas (tail horas), d1==d2 ]
      where horas = [ (d,h) | (d,hs) <- hss, (h,as) <- hs, elem a as ]

-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Exercise 4 (2,5 puntos) The following problem is based in the 425
-- of the project Euler. Two positive numbers To and B says  that they are
-- connected (denotado por "A ↔ B"), if it fulfils  one of the following
-- conditions:
--   1) To and B have the same quantity of digits and differ in exactly
--      a digit. For example, 123 ↔ 173
--   2) When adding a digit to the left of To (o B) achieve B (o A).
--      For example, 23 ↔ 223 and 123 ↔ 23
-- will say that two cousins q and p are related if it exists a chain 
-- of cousins connected among both and are comprised among q and p. For example
--, if q=2 and p=127, then 2 ↔ 3 ↔ 13 ↔ 113 ↔ 103 ↔ 107 ↔ 127.
-- It defines the predicate (cadenaPrimosConectados xs) such that indicate if the
-- list xs is a correct chain of cousins connected. For example,
--   > cadenaPrimosConectados [2,3,13,113,103,107,127]
--   True
--   > cadenaPrimosConectados [2,3,13,22,1,127]
--   False
--   > cadenaPrimosConectados [2,3,13,113,183,107,127]
--   False
-- -----------------------------------------------------------------------------

cadenaPrimosConectados :: [Int] -> Bool
cadenaPrimosConectados ns = 
  and[ primo n && n >= head ns && n <= last ns | n <- ns ] 
  &&
  and [ conectados n m |  (n,m) <- zip ns (tail ns) ]

primo :: Integral a => a -> Bool
primo n = length (divisores n) == 2

divisores :: Integral a => a -> [a]
divisores n = [i | i <- [1..n], rem n i == 0]

conectados :: Int -> Int -> Bool
conectados x y = (length xs == length ys && dif == 1) ||
                 (extiendeX || extiendeY)
    where xs = cifras x
          ys = cifras y
          dif = sum [ 1 | (n,m) <- zip xs ys, n/=m ]
          extiendeX = (head ys:xs) == ys
          extiendeY = (head xs:ys) == xs          

cifras :: Int -> [Int]
cifras n | n < 9 = [n]
         | otherwise = cifras (div n 10) ++ [rem n 10]

-- -----------------------------------------------------------------------------

