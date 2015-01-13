function ends_in_3(num)
	return num%10==3
end

function is_prime( num )
	for i=2,num-1 do
		if num%i==0 then
			return false
		end
	end
	return true
end

function first_n_primes_that_end_in_3( n )
	local i = n
	local num = 3
	while i > 0 do
		if is_prime(num) and ends_in_3(num) then
			print(num)
			i = i - 1
		end
		num = num + 1
	end
end

function for_loop( a, b, f )
	local i = a
	while i <= b do 
		f(i)
		i = i + 1
	end
end

function test( n )
	print(n)
end

function reduce( max, init, f )
	previous = init
	for i=1,max do
		previous = f(previous, i)
	end
	return previous
end

function add( previous, next )
	return previous + next
end

print "ends_in_3"
=ends_in_3(13)
=ends_in_3(21)
print "is_prime"
=is_prime(11)
=is_prime(12)
=is_prime(13)
print "first_n_primes_that_end_in_3"
first_n_primes_that_end_in_3(4)
print "for_loop"
=for_loop(2, 5, test)
print "reduce"
=reduce(5, 0, add)