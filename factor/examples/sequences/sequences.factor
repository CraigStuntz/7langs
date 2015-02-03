USING: sequences kernel ;
IN: examples.sequences

: find-first ( elements predicate -- match )
    find swap drop
; inline
