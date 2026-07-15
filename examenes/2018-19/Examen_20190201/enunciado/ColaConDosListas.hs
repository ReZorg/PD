-- ColaConDosListas.hs
-- Implementation of queues using two lists.
-- José A. Alonso Jiménez <jalonso@us.es>
-- Seville, September 11, 2010
-- ---------------------------------------------------------------------

-- In this implementation, a queue c is represented by a pair of
-- lists (xs,ys) so that the elements of c are, in that order, the
-- elements of the list xs++(reverse ys).

-- By splitting the list into two parts and reversing the second one,
-- we hope to make queue operations more efficient.

-- We will also impose an additional restriction on the
-- representation: queues will be represented by pairs (xs,ys)
-- such that if xs is empty, then ys will also be empty. This
-- restriction must be preserved by the programs that create queues.

module ColaConDosListas
    (Cola,
     vacia,   -- Cola a
     inserta, -- a -> Cola a -> Cola a
     primero, -- Cola a -> a
     resto,   -- Cola a -> Cola a
     esVacia, -- Cola a -> Bool
     valida   -- Cola a -> Bool
    ) where

-- Queues as pairs of lists.
newtype Cola a = C ([a],[a])
    -- deriving Show

-- Procedure for displaying queues as pairs of lists.
instance (Show a) => Show (Cola a) where
    showsPrec p (C (xs,ys)) cad
        = showString "C " (showList (xs ++ (reverse ys)) cad)

-- Example of a queue: c1 is the queue obtained by adding the numbers
-- from 1 to 10 to the empty queue. For example,
--    ghci> c1
--    C [10,9,8,7,6,5,4,3,2,1]
c1 :: Cola Int
c1 = foldr inserta vacia [1..10]

-- vacia is the empty queue. For example,
--    ghci> vacia
--    C []
vacia :: Cola a
vacia  = C ([],[])

-- (inserta x c) is the queue obtained by adding x to the end of
-- queue c. For example,
--    inserta 12 c1  ==  C [10,9,8,7,6,5,4,3,2,1,12]
inserta :: a -> Cola a -> Cola a
inserta y (C (xs,ys)) = C (normaliza (xs,y:ys))

-- (normaliza p) is the queue obtained by normalizing the pair of
-- lists p. For example,
--    normaliza ([],[2,5,3])   ==  ([3,5,2],[])
--    normaliza ([4],[2,5,3])  ==  ([4],[2,5,3])
normaliza :: ([a],[a]) -> ([a],[a])
normaliza ([], ys) = (reverse ys, [])
normaliza p        = p

-- (primero c) is the first element of queue c. For example,
--    primero c1  ==  10
primero  :: Cola a -> a
primero (C (x:xs,ys)) = x
primero _             = error "primero: empty queue"

-- (resto c) is the queue obtained by removing the first element of
-- queue c. For example,
--    resto c1  ==  C [9,8,7,6,5,4,3,2,1]
resto  :: Cola a -> Cola a
resto (C ([],[]))   = error "resto: empty queue"
resto (C (x:xs,ys)) = C (normaliza (xs,ys))

-- (esVacia c) checks whether c is the empty queue. For example,
--    esVacia c1     ==  False
--    esVacia vacia  ==  True
esVacia :: Cola a -> Bool
esVacia (C (xs,_)) = null xs

-- (valida c) checks whether queue c is valid; that is, if
-- its first element is empty, then the second one is too. For
-- example,
--    valida (C ([2],[5]))  ==  True
--    valida (C ([2],[]))   ==  True
--    valida (C ([],[5]))   ==  False
valida:: Cola a -> Bool
valida (C (xs,ys)) = not (null xs) || null ys

-- ---------------------------------------------------------------------
-- Equality of queues                                                 --
-- ---------------------------------------------------------------------

-- (elementos c) is the list of the elements of queue c in queue
-- order. For example,
--    elementos (C ([3,2],[5,4,7]))  ==  [3,2,7,4,5]
elementos:: Cola a -> [a]
elementos (C (xs,ys)) = xs ++ (reverse ys)

-- (igualColas c1 c2) checks whether queues c1 and c2 are equal. For
-- example,
--    igualColas (C ([3,2],[5,4,7])) (C ([3],[5,4,7,2]))   ==  True
--    igualColas (C ([3,2],[5,4,7])) (C ([],[5,4,7,2,3]))  ==  False
igualColas c1 c2 = 
    valida c1 && valida c2 && elementos c1 == elementos c2

instance (Eq a) => Eq (Cola a) where
    (==) = igualColas
