-- Pilaconlistas.hs
-- Implementation of the batteries by means of lists.
-- José To. Alonso Jiménez <jalonso@us.es>
-- Seville, 11 of September of 2010
-- ---------------------------------------------------------------------

module PilaConListas
    (Pila,
     vacia,    -- Battery to
     apila,    -- to -> Battery to -> Battery to
     cima,     -- Battery to -> to
     desapila, -- Battery to -> Battery to
     esVacia   -- Battery to -> Bool
    ) where

-- Representation of the batteries by means of lists.
newtype Pila a = P [a]
    deriving Eq

-- Procedure of writing of batteries.
instance (Show a) => Show (Pila a) where
    showsPrec p (P [])     cad = showChar '-' cad
    showsPrec p (P (x:xs)) cad
        = shows x (showChar '|' (shows (P xs) cad))

-- Example of battery:
--    > p1
--    1|2|3|-
p1 = apila 1 (apila 2 (apila 3 vacia))

-- vacia is the empty battery. For example,
--    > vacia
--    -
vacia   :: Pila a
vacia = P []

-- (apila x p) is the battery obtained adding x on of the battery p. For example
--, 
--    apila 4 p1  =>  4|1|2|3|-
apila :: a -> Pila a -> Pila a
apila x (P xs) = P (x:xs)

-- (cima p) is the peak of the battery p. For example,
--    peak p1  ==  1
cima :: Pila a -> a
cima (P [])    = error "top of empty stack"
cima (P (x:_)) = x

-- (desapila p) is the battery obtained suppressing the peak of the battery
-- p. For example, 
--    desapila p1  =>  2|3|-
desapila :: Pila a -> Pila a
desapila (P [])     = error "pop from empty stack"
desapila (P (_:xs)) = P  xs

-- (esVacia p) verifies  if p is the empty battery. For example,
--    esVacia p1     ==  False
--    esVacia vacia  ==  True
esVacia :: Pila a -> Bool
esVacia (P xs) = null xs
