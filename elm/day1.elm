-- easy
import List
list_product l = List.product l

list_xs l = List.map .x l
person = { name = "Craig", age = -16, address = { street = "1 Easton Oval", city = "Columbus", state = "Ohio" } }

-- medium
multiply x y = x * y
multiply_by_8 = multiply 8
multiply_by_8 6
people = [ { name = "Craig", age = -16, address = { street = "1 Easton Oval", city = "Columbus", state = "Ohio" } }, { name = "Clyde", age = 32, address = { street = "1 Easton Oval", city = "Columbus", state = "Ohio" } } ]
people_older_than_16 = List.filter (\p -> p.age > 16)

-- hard 
people_2 = [ { name = "Craig", age = Nothing, address = { street = "1 Easton Oval", city = "Columbus", state = "Ohio" } }, { name = "Clyde", age = Just 32, address = { street = "1 Easton Oval", city = "Columbus", state = "Ohio" } } ]
people_plder_than_16_2 = List.filter (\p -> case p.age of | Nothing -> false | Just age -> age > 16)
