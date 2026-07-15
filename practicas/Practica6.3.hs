-- PD-Practice 6.3
-- Arithmetic Expressions with algebraic data types
-- Department of Computer Science and A.I.
-- University of Seville
-- =====================================================================



-- ---------------------------------------------------------------------
-- Exercise 1. Basic arithmetic expressions can be
-- represented using the following data type  
--    data Expr1 = C1 Int 
--               | S1 Expr1 Expr1 
--               | P1 Expr1 Expr1  
--               deriving Show
-- For example, the expression 2*(3+7) is represented by
--    P1 (C1 2) (S1 (C1 3) (C1 7))
-- 
-- Define the function evalua, such that (evalua e) is the value of the 
-- arithmetic expression e. For example, 
--    evalua (P1 (C1 2) (S1 (C1 3) (C1 7)))  ==  20
-- ---------------------------------------------------------------------

data Expr1 = C1 Int 
           | S1 Expr1 Expr1 
           | P1 Expr1 Expr1  
           deriving Show

-- ---------------------------------------------------------------------
-- Exercise 2. Define the function aplica, such that (aplica f e) is the 
-- expression obtained by applying the function f to each number in
-- expression e. For example, 
--    ghci> aplica (+2) (S1 (P1 (C1 3) (C1 5)) (P1 (C1 6) (C1 7)))
--    S1 (P1 (C1 5) (C1 7)) (P1 (C1 8) (C1 9))
--    ghci> aplica (*2) (S1 (P1 (C1 3) (C1 5)) (P1 (C1 6) (C1 7)))
--    S1 (P1 (C1 6) (C1 10)) (P1 (C1 12) (C1 14))
-- ---------------------------------------------------------------------


-- ---------------------------------------------------------------------
-- Exercise 3. Arithmetic expressions built with one
-- variable (denoted X), integer numbers, and the operations of
-- addition and multiplication can be represented using the data type
-- Expr2 defined by     
--    data Expr2 = X
--               | C2 Int
--               | S2 Expr2 Expr2
--               | P2 Expr2 Expr2
-- For example, the expression "X*(13+X)" is represented by
-- "P2 X (S2 (C2 13) X)".
-- 
-- Define the function evaluaE, such that (evaluaE e n) is the value of
-- expression e when its variable is substituted by n. For example,
--    evaluaE (P2 X (S2 (C2 13) X)) 2  ==  30
-- ---------------------------------------------------------------------
 
data Expr2 = X
           | C2 Int
           | S2 Expr2 Expr2
           | P2 Expr2 Expr2

-- ---------------------------------------------------------------------
-- Exercise 4. Define the function numVars, such that (numVars e) is the 
-- number of variables in expression e. For example, 
--    numVars (C2 3)                 ==  0
--    numVars X                      ==  1
--    numVars (P2 X (S2 (C2 13) X))  ==  2
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- Exercise 5. Arithmetic expressions with generic variables 
-- can be represented using the following data type  
--    data Expr3 = C3 Int 
--               | V3 Char 
--               | S3 Expr3 Expr3 
--               | P3 Expr3 Expr3  
--               deriving Show
-- For example, the expression 2*(a+5) is represented by
--    P3 (C3 2) (S3 (V3 'a') (C3 5))
-- 
-- Define the function evaluaG, such that (evaluaG e c) is the value of
-- expression e in context c (i.e., the value of the expression where
-- the variables of e are substituted by the values given in context c).
-- For example,
--    ghci> evaluaG (P3 (C3 2) (S3 (V3 'a') (V3 'b'))) [('a',2),('b',5)]
--    14
-- ---------------------------------------------------------------------

data Expr3 = C3 Int 
           | V3 Char 
           | S3 Expr3 Expr3 
           | P3 Expr3 Expr3  
           deriving Show
                   
-- ---------------------------------------------------------------------
-- Exercise 6. Define the function sumas, such that (sumas e) is the 
-- number of additions in expression e. For example, 
--    sumas (P3 (V3 'z') (S3 (C3 3) (V3 'x')))  ==  1
--    sumas (S3 (V3 'z') (S3 (C3 3) (V3 'x')))  ==  2
--    sumas (P3 (V3 'z') (P3 (C3 3) (V3 'x')))  ==  0
-- ---------------------------------------------------------------------
                   
-- ---------------------------------------------------------------------
-- Exercise 7. Define the function sustitucion, such that 
-- (sustitucion e s) is the expression obtained by substituting the
-- variables of expression e according to substitution s. For example, 
--    ghci> sustitucion (P3 (V3 'z') (S3 (C3 3) (V3 'x'))) [('x',7),('z',9)]
--    P3 (C3 9) (S3 (C3 3) (C3 7))
--    ghci> sustitucion (P3 (V3 'z') (S3 (C3 3) (V3 'y'))) [('x',7),('z',9)]
--    P3 (C3 9) (S3 (C3 3) (V3 'y'))
-- ---------------------------------------------------------------------


-- ---------------------------------------------------------------------
-- Exercise 8. Define the function reducible, such that (reducible e)
-- holds if e is a reducible expression; that is, it contains some
-- operation in which both operands are numbers. For example,
--    reducible (S3 (C3 3) (C3 4))               == True
--    reducible (S3 (C3 3) (V3 'x'))             == False
--    reducible (S3 (C3 3) (P3 (C3 4) (C3 5)))   == True
--    reducible (S3 (V3 'x') (P3 (C3 4) (C3 5))) == True
--    reducible (S3 (C3 3) (P3 (V3 'x') (C3 5))) == False
--    reducible (C3 3)                           == False
--    reducible (V3 'x')                         == False
-- ---------------------------------------------------------------------
