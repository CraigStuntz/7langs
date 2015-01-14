function print_table(t)
	for k,v in pairs(t) do
		print(k .. ": " .. v)
	end
end

function table_to_string( t )
	local result = {}
	for k,v in pairs(t) do
		result[result# + 1] = k .. ": " .. v
	end
	return table.concat( t, "\n")
end