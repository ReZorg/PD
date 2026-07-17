-- -----------------------------------------------------------------------------
-- Declarative Programming 2021/22
-- Degree in Computer Engineering - Information Technologies
-- Midterm 1 (group 2)                                   November 10, 2021
-- -----------------------------------------------------------------------------
-- Surnames:
-- Name:
-- UVUS:
-- Laboratory/Workstation:
-- -----------------------------------------------------------------------------
-- SUBMISSION INSTRUCTIONS
-- 1. It changes THE NAME of this archive by:       <uvus>.hs
--    Where "<uvus>" is your UVUS.
-- 2. It comments THE LINES WITH ERRORS until it can upload  the file
--    without problems. It writes your name and surnames in the cabecera.
-- 3. It compresses this archive in an only file called EXACTLY:
--      DELIVERY-<uvus>.tar.gz      (o bien)       Delivery-<uvus>.tar.xz
--    Where "<uvus>" is your UVUS. You do not forget you of the script after
--    DELIVERY, and do not compress it in a file.zip.
-- 4. REINICIA The squad. In the menu of selection of the system (with white
--    fund), DO CLICK ON "Sending examination" at the side of system Ubuntu.
-- 5. Question to the professor if it has arrived your post correctly, if it is
--    like this, already can leave your place WITHOUT TURN THE SQUAD.
-- ----------------------------------------------------------------------
-- GUIDELINES
-- · Writes the solution of each exercise in the hollow reserved for
--   this.
-- · It will value  the correct use of tipados for each clear-cut function.
-- · You can add so many auxiliary functions as you need (including his 
--   signatura adequately).
-- · You can use other modules of Haskell that are already imported.
-- -----------------------------------------------------------------------------

import Test.QuickCheck
import Data.Char
import Data.List

-- -----------------------------------------------------------------------------
-- Exercise 1 (2 puntos)
-- Define the operator infijo (/^) such that receive two real numbers x and 
-- and, and give the exponent obtained employing like base the minor of x
-- and and, and like exponent the elder of x and and.
-- It has to have the same precedence that the operator, and the asociatividad
-- required so that the following examples are correct. For example:
-- > 3 /^ 2
-- 8.0
-- > 2 /^ 3
-- 8.0
-- > 2 /^ 3 /^ 4
-- 2.4178516392292583e24
-- > (2 /^ 3) /^ 4
-- 65536.0
-- -----------------------------------------------------------------------------



-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Exercise 2.1 (1 punto) Defines the function (gmaxR g xs) such that receive a 
-- function g and a list xs, and give all element x of xs that fulfil with the
-- following: if x1, x, x2 are consecutive elements, (g x1) is minor that (g x),
-- and (g x) is main that (g x2). It defines the function employing RECURSION.
-- For example,
-- > gmaxR (^2) [2,3]
-- []
-- > gmaxR (^2) [2,3,2]
-- [3]
-- > gmaxR (*(-1)) [1,2,3,1,2,35,4]
-- [1]
-- > gmaxR (/2) [1,2,3,1,2,35,4]
-- [3.0,35.0]
-- > gmaxR toUpper "hola"
-- "o"
-- -----------------------------------------------------------------------------

gmaxR = undefined

-- -----------------------------------------------------------------------------
-- Exercise 2.2 (1 punto) Defines the function (gmaxO g xs) like the anterior,
-- but using UPPER ORDER to visit the elements.
-- For example,
-- > gmaxO (^2) [2,3]
-- []
-- > gmaxO (^2) [2,3,2]
-- [3]
-- > gmaxO (*(-1)) [1,2,3,1,2,35,4]
-- [1]
-- > gmaxO (/2) [1,2,3,1,2,35,4]
-- [3.0,35.0]
-- > gmaxO toUpper "hola"
-- "o"
-- -----------------------------------------------------------------------------

gmaxO = undefined

-- -----------------------------------------------------------------------------
-- Exercise 2.3 (1 punto) Checks with quickCheck for all number x
-- positive, and any ready xs no empty, the result of gmax with (g = *x)
-- and xs, has as a lot a third of elements of xs. If there was a
-- counterexample, copy and paste it like a commentary.
-- -----------------------------------------------------------------------------

prop_gmax = undefined

{- The check is:

-}

-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Exercise 3 (2,5 puntos). The schedule of class can represent  like a
-- list of tuplas where:
--    the first component is the name abridged of the subject, 
--    the second component a list of triples, where:
--      - the first component is the name of the day abridged
--      - the second component is a pair that indicates hour and minute of beginning
--      - the third component is a pair that indicates hour and minute of ending

horario :: [ ( String, [(String, (Int,Int), (Int,Int))] ) ]
horario = [ ("PD",    [("Mie",(12,30),(14,30)),("Mie",(15,30),(17,30)),("Vie",(12,30),(14,30))]),
            ("IA",    [("Mar",(8,30),(10,30)), ("Jue",(12,30),(14,30))]),
            ("TAI",   [("Lun",(12,30),(14,30)),("Mar",(12,30),(14,30)),("Mar",(15,30),(17,30)), ("Mar",(17,30),(19,30))]),
            ("CIMSI", [("Mar",(10,30),(12,30)),("Vie",(8,30),(10,30)), ("Vie",(10,30),(12,30))]),
            ("GSI",   [("Mie",(10,30),(12,30)),("Vie",(8,30),(10,30)), ("Vie",(10,30),(12,30))])
          ]

-- Defines the function (invierteHorario hss), such that receive a schedule hss
-- like the anterior, and give the calendar of morning (de 8:00 a 13:00)
-- indicating for each day of the week and each hour, the subjects that have
-- programmed. If there are not subjects in a schedule, puts  the empty list.
-- In concrete, has to give a list of pairs, where the first is the day of the
-- week, and the second is a list of pairs (hora,as), being ace the list of the 
-- subjects that there is in this moment. For example,
-- > invierteHorario horario
--    [("Lun",[(8,[]),(9,[]),(10,[]),(11,[]),(12,[]),(13,["TAI"]),(14,["TAI"])]),
--     ("Mar",[(8,[]),(9,["IA"]),(10,["IA"]),(11,["CIMSI"]),(12,["CIMSI"]),(13,["TAI"]),(14,["TAI"])]),
--     ("Mie",[(8,[]),(9,[]),(10,[]),(11,["GSI"]),(12,["GSI"]),(13,["PD"]),(14,["PD"])]),
--     ("Jue",[(8,[]),(9,[]),(10,[]),(11,[]),(12,[]),(13,["IA"]),(14,["IA"])]),
--     ("Vie",[(8,[]),(9,["CIMSI","GSI"]),(10,["CIMSI","GSI"]),(11,["CIMSI","GSI"]),(12,["CIMSI","GSI"]),(13,["PD"]),(14,["PD"])])]
-- -----------------------------------------------------------------------------

invierteHorario :: [(String,[(String,(Int,Int),(Int,Int))])]-> [(String,[(Int,[String])])]
invierteHorario = undefined
  
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Exercise 4 (2,5 puntos) The following problem is based in the 414
-- of the project Euler. The routine of Kaprekar begins with a number n that
-- contains 4 or fewer figures, and calculates  another number as follows:
--    If n has less than 4 figures, extends  adding zeros
--     to the left until having 4 figures.
--    They obtain  two numbers, one ordering the figures of elder to minor
--     and another ordering of minor to elder. The new number is subtracts it
--     of the first with the second.
-- For example, if n=0837, then the following is 8730-0378=8352.
-- The process finishes always with the 0 or with the constant of Kaprekar. This
-- constant is the 6174, since 7641-1467=6174.
-- It defines the function (kaprekar n) such that give the number of steps in
-- the routine of Kaprekar beginning with n until arriving to the 0 or to the 6174.
-- For example,
-- > kaprekar 6174
-- 1
-- > kaprekar 837
-- 2
-- > kaprekar 64
-- 4
-- -----------------------------------------------------------------------------

kaprekar :: Int -> Int
kaprekar = undefined

-- -----------------------------------------------------------------------------
