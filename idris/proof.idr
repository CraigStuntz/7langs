module Proof
data Natural = Zero | Suc Natural

plus : Natural -> Natural -> Natural
plus Zero x1 = x1
plus (Suc x) x1 = Suc (plus x x1)

plusZero : (x : Natural) -> plus x Zero = x
plusSuc : (x : Natural) -> (y : Natural) -> Suc (plus x y) = plus x (Suc y)

plusCommutes : (x : Natural) -> (y : Natural) -> plus x y = plus y x
plusCommutes Zero y = ?plusCommutes_0_y
plusCommutes (Suc x) y = 
  let hypothesis = plusCommutes x y 
  in ?plusCommutes_Sx_y

plusCommutes_0_y = proof {
  intros
  rewrite (plusZero y)
  trivial
}

plusCommutes_Sx_y = proof {
  intros
  rewrite (plusSuc y x)
  rewrite hypothesis 
  trivial 
}
