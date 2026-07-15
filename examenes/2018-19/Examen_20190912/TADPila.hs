-- PilaConTipoDeDatoAlgebraico.hs
-- Implementation of stacks using algebraic data types.
-- José A. Alonso Jiménez <jalonso@us.es>
-- Seville, September 11, 2010
-- ---------------------------------------------------------------------

module TADPila 
    (Pila,
     vacia,    -- Pila a
     apila,    -- a -> Pila a -> Pila a
     cima,     -- Pila a -> a
     desapila, -- Pila a -> Pila a
     esVacia   -- Pila a -> Bool
    ) where

-- Algebraic data type for stacks:
data Pila a = Vacia
            | P a (Pila a)
              deriving Eq

-- Procedure for displaying stacks.
instance (Show a) => Show (Pila a) where
    showsPrec p Vacia cad   = showChar '-' cad
    showsPrec p (P x s) cad = shows x (showChar '|' (shows s cad))

-- Example stack:
--    ghci> p1
--    1|2|3|-
p1 :: Pila Int
p1 = apila 1 (apila 2 (apila 3 vacia))

-- vacia is the empty stack. For example,
--    ghci> vacia
--    -
vacia :: Pila a
vacia = Vacia

-- (apila x p) is the stack obtained by adding x on top of stack p. For
-- example,
--    apila 4 p1  =>  4|1|2|3|-
apila :: a -> Pila a -> Pila a
apila x p = P x p

-- (cima p) is the top of stack p. For example,
--    cima p1  ==  1
cima :: Pila a -> a
cima Vacia   = error "the empty stack has no top"
cima (P x _) =  x

-- (desapila p) is the stack obtained by removing the top of stack
-- p. For example,
--    desapila p1  =>  2|3|-
desapila :: Pila a -> Pila a
desapila Vacia   = error "cannot pop the empty stack"
desapila (P _ p) = p

-- (esVacia p) checks whether p is the empty stack. For example,
--    esVacia p1         ==  False
--    esVacia vacia  ==  True
esVacia :: Pila a -> Bool
esVacia Vacia = True
esVacia _     = False
