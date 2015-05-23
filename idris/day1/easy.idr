greaterThan3 : List Int -> List Int
greaterThan3 = filter (>3)

everyOther : List a -> List a
everyOther [] = []
everyOther (x :: xs) = 
  x :: everyOther' xs where
    everyOther' [] = []
    everyOther' (y :: ys) = everyOther ys

data Suit = Clubs | Diamonds | Hearts | Spades
data Rank = Ace 
          | Two 
          | Three 
          | Four 
          | Five 
          | Six 
          | Seven 
          | Eight 
          | Nine 
          | Ten
          | Jack
          | Queen
          | Kind
data Card = MkCard Suit Rank 

Deck : Type
Deck = List Card
