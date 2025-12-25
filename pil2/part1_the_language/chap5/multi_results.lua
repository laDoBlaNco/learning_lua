---@diagnostic disable: redundant-value
--[[
5.1 - MULTIPLE RESULTS

An unconvential yet very convenient feature of lua is that functions return
multiple results. I like this about Go and Odin as well. for example string.find
returns two indices start and finish (inclusive)
]]
local s, e = string.find("hello lua users", "lua")
print(s, e)

-- simply list them after 'return'
function maximum(a)
	local mi = 1 -- index of max value
	local m = a[mi] -- max value
	for i, val in ipairs(a) do
		if val > m then
			mi = i
			m = val
		end
	end
	return m, mi
end

print(maximum({ 8, 10, 23, 12, 5 }))
print()

--[[
NOTE - Lua ALWAYS adjusts the number of results from a function to the circumstances
or context of the call. When I call a function as a statement, lua discards ALL results
from the function. When I call a function in an expression, lua keeps only the first
result. I only get all the results when the call is the last (or the only) expression
in a LIST of expressions. These lists appear in 4 main constructions in lua:

  1. multiple assignments
  2. arguments to function calls
  3. table constructors
  4. return statements

So basically if I'm understanding correctly, I can only get all the results in these 
4 contexts and that being only when its the last expression in a LIST of expressions.
Otherwise its 1 result when in an  expressions and none for statements

Examples:
]]
function foo0() end -- no results
function foo1()
	return "a"
end -- 1 result
function foo2()
	return "a", "b"
end

-- in multiple assignment, the funtion call is the last (or only) expression
local x, y, z
x = foo2()
print(x, y, z)
x, y = foo2()
print(x, y, z)
x, y, z = 10, foo2()
print(x, y, z)

-- no results gets nil

x, y = foo0()
print(x, y)

-- a function call that's not the last element in a list, only gives one result
print()
x, y = foo2(), 20 -- only get 'a' since not last in the ',' separated list
print(x, y)
x, y = foo0(), 20, 30 -- x=nil, y=20 and 30 is discarded
print(x, y)
print()

-- Last or only call to another call. Using 'print' as the calling function
print(foo0())
print(foo1())
print(foo2())
print(foo2(), 1) -- not last in the argument list so only 1 result given
print(foo2() .. "x") -- call to foo2 is in an expression, lua adjusts the number of
-- results to one; so only 'a' is seen.
print()

-- constuctors get all results with no adjustments
local t
t = { foo0() }
print(unpack(t))
t = { foo1() }
print(unpack(t))
t = { foo2() }
print(unpack(t))

-- but again only when the call is the LAST in a the list, otherwise its only 1
t = { foo0(), foo2(), 4 }
print(unpack(t))
print()

-- finally a 'return' statement returns all values returned by a function in
-- return f()
function foo(i)
	if i == 0 then
		return foo0()
	elseif i == 1 then
		return foo1()
	elseif i == 2 then
		return foo2()
	end
end
print(foo(1))
print(foo(2))
print(foo(0))
print(foo(3))
print()

-- putting a call in ()s will force only one result
print((foo0()))
print((foo1()))
print((foo2()))
print()

-- on another note using 'unpack' for generic calls 
local func = string.find
local a = { "hello", "ll" }
print(func(unpack(a)))
print()

-- if unpack was written in lua it would like like this:
function my_unpack(tab, i)
	i = i or 1
	if tab[i] then
		return tab[i], unpack(tab, i + 1)
	end
end

print(my_unpack({1,2,3,4,5}))

