import Data.Vect

Matrix : Type -> Nat -> Nat -> Type
Matrix a r c = Vect c (Vect r a)

horizontalMirror : Matrix a r c -> Matrix a r c
horizontalMirror [] = []
horizontalMirror (cv :: cvs) = reverse cv :: (horizontalMirror cvs)

test : Matrix Int 2 2
test = (1 :: 2 :: []) :: (3 :: 4 :: []) :: []
