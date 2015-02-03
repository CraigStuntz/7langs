USING: math io math.parser namespaces kernel random combinators
prettyprint ;
IN: examples.numberguess
SYMBOL: correct

: guess-is-wrong ( guess -- is-wrong )
    correct get = not 
;

: guess-message ( guess -- message )
    {
        { [ dup correct get > ] [ drop "Lower" ] }
        { [ dup correct get < ] [ drop "Higher" ] }
        { [ dup correct get = ] [ drop "Winner" ] }
        [ drop "That ain't right!" ]
    } cond
;

: one-guess ( -- is-wrong )
    "Enter your guess: " print
    readln string>number 
    [ guess-is-wrong ] [ guess-message ] bi
    print
;

: game-loop ( -- )
    100 random dup number>string print correct set
    [ one-guess ] loop
;

MAIN: game-loop
