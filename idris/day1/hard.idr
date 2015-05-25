rev : List a -> List a
rev lst = 
  rev' [] lst where
    rev' : List a -> List a-> List a
    rev' accum [] = accum
    rev' accum (x :: xs) = rev' (x :: accum) xs
