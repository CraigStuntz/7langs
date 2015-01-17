-- Easy
function concatenate(a1, a2)
	result = {}
	for i,v in ipairs(a1) do
		result[i]=v
	end
	for i,v in ipairs(a2) do
		result[i + #a1]=v
	end
	return result
end

local x = { 1, 2, 3}
local y = { 4, 5, 6}
dofile('util.lua')
print("concatenate: "..table_to_string(concatenate(x, y)))

dofile('strict.lua')
local st = {}
st.gold = "Gold"
st.gold = nil
print("Strict delete: " .. tostring(st.gold))

-- Medium
local array_mt = {
	__add = concatenate
}
local _priv={}
local global_mt = {
	__newindex = function(t, k, v) 
		setmetatable(v, array_mt)
		_priv[k]=v
	end,
	__index = function(t, k)
		return _priv[k]
	end
}

-- This works, but poisons the global metatable. 
-- Apparently it's what we're supposed to be doing, though! 
-- https://forums.pragprog.com/forums/351/topics/13237
-- Friends don't let friends go monkeypatching.

-- setmetatable(_G, global_mt)
-- a = { 1, 2, 3}
-- b = { 4, 5, 6}
-- print("Global metatable concatenate "..table_to_string(a + b))

-- Commented out above so that rest of exercises, you know, work.

Queue = {min = 1, max = 0}
function Queue:new()
	o = {}
	setmetatable(o, self)
	self.__index = self
	return o
end
function Queue:add(value)
	self.max = self.max + 1
	self[self.max]=value
end
function Queue:remove()
	if self.min > self.max then
		return nil
	else
		result = self[self.min]
		self[self.min] = nil
		self.min = self.min + 1
		return result
	end
end

print("Queue")
local q = Queue:new()
q:add(1)
q:add(2)
print(q:remove())
print(q:remove())
print(q:remove())

--Hard

function retry(count, body)
	for i=1,count do
		local cor = coroutine.create(body)
		_, value = coroutine.resume(cor)
		if (type(value) ~= "string") then 
			return
		end
	end
	print("Failed after "..tostring(count).." tries.")
end
math.randomseed(os.time())
retry(
	5,
	function()
		if math.random() > 0.2 then
			coroutine.yield('Something bad happened')
		end
		print('Succeeded')
	end
)