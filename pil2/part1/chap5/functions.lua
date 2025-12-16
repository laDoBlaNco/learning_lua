--[[
Chapter 5 - Functions

Functions are the main mechanism for abstraction of expressions and statements
in lua. They both carry out a specific task or compute and return values. In
the first case, I'll use function calls as statements; in the second, I'll use  
them as expressions
]]

print(8 * 9, 9 / 8)
local y = math.sin(3) + math.cos(10)
print(y)
print(os.date())
print()

-- special case to note with function args. If the call has no arguments, we still write
-- an empty list (). If the function has ONE SINGLE arg AND that arg is either a LITERAL
-- OR A TABLE CONSTRUCTOR, then ()s are optional
print("Hello Lua World")
print([[a multi-line
message]])
print(type({})) -- the example is the type function
print()

-- Also lua has a special syntax for object-oriented type calls, THE COLON OPERATOR. An
-- expression like o:foo(x) is just another way to write o.foo(o,x), that is, to call
-- o.foo adding o as the first extra argument. I'll touch this again in chapter 16

-- Lua can use functions in lua and in C 🤯 (or any other language used by the host app)
-- All functions in lua standard library are written in C. When calling a function though
-- there is no difference between functions defined in Lua and those defined in C

-- conventional syntax
function add(x) -- parameters work as local variables. extra args are thrown away, missing args are set to nil
	local sum = 0
	for _, v in ipairs(x) do
		sum = sum + v
	end
  return sum
end

print(add {1,2,3,4,5})
print()

function f(a,b,c)
  print(a,b,c)
end

f(3)
f(3,4)
f(3,4,5)
print()

-- works well for default values
local count = 0
function incCount(n)
  n=n or 1
  count = count + n
end

incCount()
print(count)
incCount(5)
print(count)
incCount()
print(count)
print()


