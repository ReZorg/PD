-- Declarative Programming
-- Degree in Computer Engineering - Information Technologies
-- Midterm 1                                   November 15, 2018
-- -------------------------------------------------------------------
-- Surnames:
-- Name:
-- -------------------------------------------------------------------
-- IMPORTANT NOTICES
-- · Before continuing, change the name of this file to:
--                   Parcial1_<uvus>.hs
--   where <uvus> must be your virtual username.
-- · Write the solution to each exercise in the space reserved for
--   it.
-- · Make sure you correctly use the name and type indicated
--   for each requested function. You may add as many helper
--   functions (including the type properly) as you need,
--   describing their purpose.
-- -------------------------------------------------------------------

import Test.QuickCheck
import CodeWorld

-- ---------------------------------------------------------------------
-- Exercise 1. [0.75 points]
-- In geometry, Brahmagupta's formula states that:
-- the area of a quadrilateral whose sides measure a, b, c and d is the square
-- root of (s-a)(s-b)(s-c)(s-d), where s is the semiperimeter
--    s = (a+b+c+d)/2
-- 
-- Define appropriately, avoiding redundant calculations, the function
--    area :: Double -> Double -> Double -> Double -> Double
-- such that (area a b c d) is the area of the quadrilateral with sides a,b,c,d.
-- For example:
--    area 6 9 7 2 ==> 30.
-- ---------------------------------------------------------------------

area :: Double -> Double -> Double -> Double -> Double
area a b c d = sqrt r
  where r = (s-a)*(s-b)*(s-c)*(s-d)
        s = (a+b+c+d)/2
        
-- -------------------------------------------------------------------
-- Exercise 2. [0.75 points]
-- Define a function comparaDistintos, explicitly giving its type,
-- such that it receives two arguments and returns a result, so that:
-- a. The type of the arguments is polymorphic (not concrete):
--  - The first must support equality and be integral.
--  - The second must be orderable and fractional.
--  - The result must be of the same type as the second argument.
-- b. The function must do the following:
--  - If the first parameter is greater than the second, return their
--    difference.
--  - If the second is greater, return double the second.
--  - If they are essentially the same, return their value.
--
-- For example:
--   comparaDistintos 3 4.5 ==> 9.0
--   comparaDistintos 4 3.5 ==> 0.5
--   comparaDistintos 4 4.0 ==> 4.0
-- -------------------------------------------------------------------

comparaDistintos :: (Integral a, Eq a, Ord b, Fractional b) => a -> b -> b
comparaDistintos x y
  | m > y = m-y
  | m < y = 2*y
  | otherwise = m
    where m = fromIntegral x

-- ---------------------------------------------------------------------
-- Exercise 3. [1 point]
-- Define the function casi_extremos such that (casi_extremos n xs) is
-- the list formed by the first n elements of xs (except the first one)
-- and the last n elements of xs (except the last one).
-- Note: if the list has no elements, it must raise a controlled error.
--
-- For example:
--    casi_extremos 2 [] ==> "It is not possible to obtain the near extremes"
--    casi_extremos 3 [1..10] ==> [2,3,4,7,8,9]
--    casi_extremos 2 [2,6,7,1,2,4,5,8,9,2,3]  ==>  [6,7,9,2]
--    casi_extremos 3 [2,6,7,1,2,4]  ==>  [6,7,1,7,1,2]
-- ---------------------------------------------------------------------

casi_extremos n xs
  | length xs >= 1 = tail (take (n+1) xs) ++ init (finales (n+1) xs)
  | otherwise = error "It is not possible to obtain the near extremes"

finales n xs = reverse (take n (reverse xs))

-- ---------------------------------------------------------------------
-- Exercise 4. [0.5 points]
-- Define a property prop_casiext_reverse (and test it with QuickCheck)
-- stating that reversing the list of near extremes n xs
-- is equivalent to
-- computing the near extremes n of the reversed list xs
-- Indicate how we should call QuickCheck to test
-- the property
-- ---------------------------------------------------------------------

prop_casiext_reverse n xs = n>0 && xs /= [] ==>
  casi_extremos n (reverse xs) == reverse (casi_extremos n xs)

-- Call: quickCheck prop_casiext_reverse

-- -------------------------------------------------------------------
-- Exercise 5. [1 point]
-- Define a function cumpleUnoDeTres,
-- which receives as arguments a predicate and a list of elements,
-- and indicates whether one and only one element of each group of 3
-- elements in the list, taken from left to right, satisfies the predicate.
-- Note: groups with fewer than 3 elements should answer
--       positively for the exercise.
--
-- For example:
--   cumpleUnoDeTres even [1..100] ==> False
--   cumpleUnoDeTres (\x -> mod x 3 == 0) [1..100] ==> True
--   cumpleUnoDeTres (elem 'a') ["no","hay","prob","bro"] ==> True
--   cumpleUnoDeTres (elem 'a') ["no","prob","bro"] ==> False
--   cumpleUnoDeTres (elem 'a') ["no","hay","prab","bro"] ==> False
--   cumpleUnoDeTres (elem 'a') ["no","hay","prob","e","bro"] ==> True
--   cumpleUnoDeTres (elem 'a') ["a","prob","e","b","r","o"] ==> False
-- -------------------------------------------------------------------

cumpleUnoDeTres _ [] = True
cumpleUnoDeTres _ [x] = True
cumpleUnoDeTres _ [x,y] = True
cumpleUnoDeTres p (x:y:z:xs) =
  length (filter p [x,y,z]) == 1 && cumpleUnoDeTres p xs

-- -------------------------------------------------------------------
-- Exercise 6. [1.5 points]
-- Develop a main function, main, with an animation using
-- CodeWorld, so that the scene includes a static background (a black
-- square occupying most of the screen is enough),
-- and a moving part (circle or square) that moves
-- left and right or up and down.
-- -------------------------------------------------------------------

main = animationOf escena

escena :: Double -> Picture
escena t = cuadradoMovil t & fondo & ejes
-- It was decided to keep the coordinate axes

tam = 10

tamCuad :: Int
tamCuad = 1

fondo :: Picture
fondo = coloured black $ cuadrado (2*(tam-1))
-- It was decided to cover almost all the background, but not all of it

ejes :: Picture
ejes = coordinatePlane

cuadrado :: Double -> Picture
cuadrado n = coloured azure (solidRectangle n n)

cuadradoMovil :: Double -> Picture
cuadradoMovil t = translated (tam*sin(t-tam)) 0 (cuadrado 1)
-- It was decided to allow the moving square to leave the background

-- -------------------------------------------------------------------
-- Exercise 7. [1 point]
-- Given the following information about people, including their
-- name, field in which they stood out, and lifespan given by
-- (start, end):

personas :: [(String,String,(Int,Int))]
personas = [("Cervantes","Literatura",(1547,1616)),
            ("Velazquez","Pintura",(1599,1660)),
            ("Picasso","Pintura",(1881,1973)),
            ("Beethoven","Musica",(1770,1823)),
            ("Poincare","Ciencia",(1854,1912)),
            ("Quevedo","Literatura",(1580,1654)),
            ("Goya","Pintura",(1746,1828)),
            ("Einstein","Ciencia",(1879,1955)),
            ("Mozart","Musica",(1756,1791)),
            ("Botticelli","Pintura",(1445,1510)),
            ("Borromini","Arquitectura",(1599,1667)),
            ("Bach","Musica",(1685,1750))]

-- Define, using list comprehensions, the function
-- primero_destacado, such that primero_destacado x bd returns the
-- name of the first-born person who stood out in field x
-- in database bd, in chronological order.
--
-- For example:
--    primero_destacado "Musica" personas ==> "Bach"
--    primero_destacado "Ciencia" personas ==> "Poincare"
--
-- Help: do not hesitate to define as many helper
-- functions as you need; it is better
-- to break a problem into parts to make it easier to solve.
-- 
-- -------------------------------------------------------------------

primero_destacado :: String -> [(String,String,(Int,Int))] -> String
primero_destacado x bd = head coincidentes
  where
    cs = [(n,ai) | (n,a,(ai,_)) <- bd, a==x]
    minimoAI :: Int
    minimoAI = minimum $ map snd cs
    coincidentes = [n | (n,c) <- cs, c==minimoAI]

-- ---------------------------------------------------------------------
-- Exercise 8. [2 points]
-- Consider the function procesaNoValidos
-- :: (Num a, Ord b) => (a -> b) -> (a -> b) -> (a -> Bool) -> [a] -> [b]
-- such that (procesaNoValidos f g p xs) is the list obtained by applying to
-- the elements of xs that do NOT satisfy predicate p the maximum of
-- the results of applying function f and function g.
-- For example:
--    procesaNoValidos (4+) (2*) (<3) [1..7]  =>  [7,8,10,12,14]
-- It is requested to define the function
-- 1. using map and filter,
-- 2. by recursion,
-- 3. by recursion with an accumulator,
-- 4. by folding (left or right).
-- ---------------------------------------------------------------------
 
-- The definition with a list comprehension (not required in the exercise) is
procesaNoValidos_1 :: (Num a, Ord b) => (a -> b) -> (a -> b) -> (a -> Bool) -> [a] -> [b]
procesaNoValidos_1 f g p xs = [max (f x) (g x) | x <- xs, not (p x)]
 
-- The definition with map and filter is
procesaNoValidos_2 :: (Num a, Ord b) => (a -> b) -> (a -> b) -> (a -> Bool) -> [a] -> [b]
procesaNoValidos_2 f g p xs = map (\x -> max (f x) (g x)) $ filter (not.p) xs
 
-- The recursive definition is
procesaNoValidos_3 :: (Num a, Ord b) => (a -> b) -> (a -> b) -> (a -> Bool) -> [a] -> [b]
procesaNoValidos_3 f g p [] = []
procesaNoValidos_3 f g p (x:xs)
  | not (p x) = max (f x) (g x) : procesaNoValidos_3 f g p xs
  | otherwise = procesaNoValidos_3 f g p xs
 
-- The folding definition is
procesaNoValidos_4 :: (Num a, Ord b) => (a -> b) -> (a -> b) -> (a -> Bool) -> [a] -> [b]
procesaNoValidos_4 f g p = foldr (\x y -> if not (p x) then (max (f x) (g x)):y else y) []

-- The accumulator-based definition is
procesaNoValidos_5 :: (Num a, Ord b) => (a -> b) -> (a -> b) -> (a -> Bool) -> [a] -> [b]
procesaNoValidos_5 f g p xs = aux [] xs
  where aux acc [] = acc
        aux acc (x:xs) = aux (if p x then acc else acc ++ [max (f x) (g x)]) xs

-- The left-fold definition is
procesaNoValidos_6 :: (Num a, Ord b) => (a -> b) -> (a -> b) -> (a -> Bool) -> [a] -> [b]
procesaNoValidos_6 f g p = foldl (\acc x -> if not (p x) then acc++[max (f x) (g x)] else acc) []

-- ---------------------------------------------------------------------
-- Exercise 9. [1.5 points]
-- Write an Input/Output program that does the following:
-- 1. Print a message on screen asking the user for a natural number
-- 2. Read the user's number from the keyboard
-- 3. Compute the square of the number
-- 4. Display on screen that the square of number x is y, or similar.
-- 5. Store that same output sentence in a text file.
-- ---------------------------------------------------------------------

main2 :: IO ()
main2 = do
  putStrLn "Please enter an integer:"
  s1 <- getLine
  let n1 = read s1
      c1 = n1^2
  let s1 = "The square of " ++ show n1 ++ " is " ++ show c1
  putStrLn s1
  writeFile "Resultado.txt" s1
