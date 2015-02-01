! Easy
3 3 * 4 4 * +
USE: math.functions
3 absq 4 absq + sqrt
1 2 swap dup rot
USE: ascii
"Craig"
"Hello, " swap append >upper

! Medium
[ 1 4 17 9 11 ] 0 [ + ] reduce
USE: math.ranges
100 [1,b] 0 [ + ] reduce
10 [1,b] [ sq ] map

! Hard
93 [ 10 /i ] [ 10 mod ] bi
USE: math.parser
"123" [ 1string string>number ] each