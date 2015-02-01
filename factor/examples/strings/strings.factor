USING: kernel sequences ;
IN: examples.strings
: palindrome? ( x -- y ) dup reverse = ;
