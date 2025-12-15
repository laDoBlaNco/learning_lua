--[[
4.3 CONTROL STRUCTURES

We've got the expected set of control structures, with 'if', 'while', 'repeat',
and 'for' for iteration. All control structures have an explicit terminator: end

The condition expression of a control structure may result in any value. lua
treats as true all values different from false and nil.


]]

-- if-then-elseif-else-end structures
function if_example(a)
	if a < 0 then
		a = 0
	end
end

if_example(5)

function if_example2(a, b)
	if a < b then
		return a
	else
		return b
	end
end

if_example2(5, 5)

function if_example3(a, b, op)
	local r
	if op == "+" then
		r = a + b
	elseif op == "-" then
		r = a - b
	elseif op == "*" then
		r = a * b
	elseif op == "/" then
		r = a / b
	else
		error("invalid operation")
	end

	return r
end

if_example3(5, 5, "*")

-- NOTE - LUA HAS NO SWITCH STATEMENT, SO THE USE OF ELSEIF IS VERY COMMON

-- while - normal structure. Loop ending when condition is false
local i = 1
local a = { 1, 2, 3, 4, 5 }
while a[i] do
	print(a[i])
	i = i + 1
end

-- repeat-until - repeats its body until its condition is true. The test is doen after
-- the body, so the body is always executed at least once. Similar to other lang's
-- do-while, but its more a do-until
-- different from a lot of langs, lua scope of a local var includes the condition
-- this means that a local var is still visible in the repeat-until condition, outside
-- of the repeat block.

-- numeric for (meaning there's a counter, like C's for-loop)
-- The for statement has two variants: numeric for and generic for.
-- for var=exp1,exp2,exp3 do <something> end
-- first 2 exps are start and stop and 3rd exp is the step (optional)

print()
for m = 10, 1, -1 do
	print(m)
end

-- to loop without any limit we have math.huge (like Infinity in other langs)

-- NOTE: the for loop has some subtlties:
-- first all 3 expressions are evaluated once before the loop starts (including function
-- calls)
-- second the control variable is a local variable automatically declared by the
-- for statement and visible only in the for loop. if you need that value after
-- a break or something, you'll need to save it another var before the loop ends
-- third, you should never change the value of the control variable: the effect
-- of such changes are unpredictible and that means bugs.

-- generic for
-- will traverse all values returned by an iterator function:
-- print all the values in an array
local arr = { 55, 44, 67, 23, "another", "string", 66, 77 }
print()
for i, v in ipairs(arr) do
	print(i, v)
end

-- lua provides the ipairs iterator as well to traverse an array. For each step
-- in that loop, i gets an index, while v gets the value

-- print all keys of a table
local t = { first = "blue", second = "grey", third = "red" }
print()
for u in pairs(t) do
	print(u)
end

-- and I can print either just the keys or both. If I want just the values, I need to
-- use _ for the key
print()
for u, v in pairs(t) do
	print(u, v)
end

print()
for _, v in pairs(t) do
	print(v)
end

--[[
Though it seems simple, the generic for is super powerful. With proper iterators, I can
traverse almost anything in a readable fashion. The standard libraries provide several
iterators, which allow us to iterate over the lines of a file (io.lines), the pairs
of a table (pairs), the entries of an array (ipairs), the words of a string (string.gmatch),
and so on. Of course, I can also write my own iterators. Although the use of the 
generic for is easy, the task of writing an iterator can get complex. 
]]

-- another example
local days = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }
local rev_days = {
	["Sunday"] = 1,
	["Monday"] = 2,
	["Tuesday"] = 3,
	["Wednesday"] = 4,
	["Thursday"] = 5,
	["Friday"] = 6,
	["Saturday"] = 7,
}

print()
print(rev_days['Tuesday'])
-- or we can build that rev_days from the original
local rev_days2 = {}
for k,v in pairs(days) do
  rev_days2[v]=k
end
print()
print(rev_days2['Monday'])
print()

