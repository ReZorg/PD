-- PD-Practice 6.4
-- Trie Trees
-- Department of Computer Science and A.I.
-- University of Seville
-- =====================================================================

-- ---------------------------------------------------------------------
-- A Trie tree is a tree that encodes a dictionary, that is,
-- key-value associations. The peculiarity of these trees is that
-- the internal nodes encode keys efficiently, since prefixes
-- common to the keys appear only once. In particular, it can be used
-- to store strings as keys efficiently, if each internal node stores
-- one letter and its children are the possible letters that can follow
-- it. In this way the representation of an entire vocabulary is
-- compacted. Below is an example, where the Keys are people's names
-- and the Values are integers representing a phone number.
--
--                              ""
--                             /  \
--                           "J"  "I"
--                            |    | \ 
--                           "U"  "V" "N"
--                           / \    \   \
--                         "A" "L"  "A" "E"
--                         /     \   |    \
--                       "N"    "I" "N"   "S"
--                      / |      |    \     \
--                   "A" 68972  "A"  69712  66631
--                    |         / \
--                 63822    67321 62375
--                              
-- the example tree stores the phone numbers of the following contacts:
--  "JUAN" -> 68972, "JULIA" -> 67321, "JULIA" -> 62375, "IVAN" -> 69712,
--  "JUANA" -> 63822, "INES" -> 66631
-- Note that there are two repeated names ("JULIA"). In this way, the
-- keys are distributed across the internal nodes, so that each node
-- has only one character associated as a string (the key is the
-- concatenation of the sequence of internal nodes from the root to the
-- leaf.
-- ---------------------------------------------------------------------


-- ---------------------------------------------------------------------
-- Exercise 1.1. Define the data type for a polymorphic Trie tree,
-- where internal nodes store an element of a Key type and can
-- have more than one child, and leaves store only a Value. The tree
-- must be printable. Name it ArbolTrie, and use as constructors HT
-- for leaves and NT for internal nodes.




-- Exercise 1.2. Define a Trie tree synonym that uses strings
-- as Keys and integers as Values. Name it ArbolTrieContactos.



-- ---------------------------------------------------------------------


-- ---------------------------------------------------------------------
-- Exercise 2. Define the following functions:
--    (a) (arbolTrieVacio), which returns a tree with only the root node,
--         which has the empty string ("") as key and no children.
--    (b) (clave n), which returns the key associated with node n. If n is
--         a leaf, return the empty string "".
--    (c) (esHoja n), which indicates with a boolean whether node n is a leaf.
-- For example,
-- λ> arbolTrieVacio
-- NT "" []
-- λ> clave (NT "c" [])
-- "c"
-- λ> clave (HT 433)
-- ""
-- λ> esHoja (HT 433)
-- True
-- λ> esHoja (NT "c" [])
-- False

arbolTrieVacio = undefined

clave = undefined

esHoja = undefined 

-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
-- Exercise 3.1 Define the function (buscaClave s as), such that it receives a
-- list of trees as and a single-character string s, and returns the
-- tree whose key matches s. If no such tree exists, then it will be
-- a new internal node with key s and no children. For example,
-- λ> buscaClave "s" [NT "o" [],NT "s" [HT 100]]
-- NT "s" [HT 100]
-- λ> buscaClave "x" [NT "o" [],NT "s" [HT 100]]
-- NT "x" []

buscaClave = undefined

-- ---------------------------------------------------------------------


-- ---------------------------------------------------------------------
-- Exercise 3.2 Define the function (siguienteNodo hs s), which receives a
-- list of trees as and a single-character string s, and returns a
-- pair such that:
--  1. The first element of the pair is the result of calling the
--     buscaClave function with s and as.
--  2. The second element of the pair is all nodes of as whose keys
--     do not match s.
-- For example,
-- λ> siguienteNodo "s" [NT "o" [],NT "s" [HT 100]]
-- (NT "s" [HT 100],[NT "o" []])
-- λ> siguienteNodo "x" [NT "o" [],NT "s" [HT 100]]
-- (NT "x" [],[NT "o" [],NT "s" [HT 100]])

siguienteNodo = undefined 

-- ---------------------------------------------------------------------


-- ---------------------------------------------------------------------
-- Exercise 4. Define the function (inserta a p), which receives a
-- Trie tree a and a pair p = (key, value), where key is a string
-- of characters and value is an integer. The function must return
-- tree a extended to include the new pair (key,value). The procedure
-- is as follows:
--   - If the key is the empty string, add the value as a leaf of the
--     current internal node
--   - Otherwise, call siguienteNodo with the first letter of the key,
--     and the list of child nodes of the current node and the first
--     letter of the key. The result is used to call inserta again
--     and is added as a child of the current node.
-- For example,
-- λ> inserta  arbolTrieVacio ("ok",43)
-- NT "" [NT "o" [NT "k" [HT 43]]]
-- λ> inserta (NT "" [NT "o" [NT "k" [HT 43]]]) ("os",542)
-- NT "" [NT "o" [NT "s" [HT 542],NT "k" [HT 43]]]

inserta = undefined 

-- ---------------------------------------------------------------------


-- ---------------------------------------------------------------------
-- Exercise 5. Define the function (insertaElemsEnArbol a cs), which receives a
-- Trie tree a and a list cs of (key, value) pairs, and returns a
-- tree with all elements inserted. For example, 
--    insertaElemsEnArbol arbolTrieVacio
--        [("IVAN",69712),("JULIA",62375),("JULIA",67321),("JUAN",68972)]
-- NT ""
-- [NT "J" [NT "U" [NT "A" [NT "N" [HT 68972]],NT "L" [NT "I" [NT "A" [HT 67321,HT 62375]]]]],
--  NT "I" [NT "V" [NT "A" [NT "N" [HT 69712]]]]]

insertaElemsEnArbol = undefined 

-- ---------------------------------------------------------------------


-- ---------------------------------------------------------------------
-- Exercise 6. Define (consultaValor a cs), such that it receives a Trie
-- tree a and a Key cs, and returns the values associated with it. If the
-- key is not in the tree or has no associated values, return the empty
-- list. For example,
-- let a = NT "" [NT "J" [NT "U" [NT "A" [NT "N" [HT 68972]],NT "L" [NT "I" [NT "A" [HT 67321,HT 62375]]]]],NT "I" [NT "V" [NT "A" [NT "N" [HT 69712]]]]]
-- λ> consultaValor a "JUAN"
-- [68972]
-- λ> consultaValor a "JULIA"
-- [67321,62375]
-- λ> consultaValor a "JULIO"
-- []

consultaValor = undefined 

-- ---------------------------------------------------------------------

