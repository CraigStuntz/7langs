data EvenOdd = Even Nat | Odd Nat

succ : EvenOdd -> EvenOdd
succ (Even n) = Odd (S n)
succ (Odd n)  = Even (S n)

data BinaryTree a = Leaf a | Node (BinaryTree a) (BinaryTree a)
