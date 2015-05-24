data EvenOdd = Even Nat | Odd Nat

succ : EvenOdd -> EvenOdd
succ (Even n) = Odd (S n)
succ (Odd n)  = Even (S n)
