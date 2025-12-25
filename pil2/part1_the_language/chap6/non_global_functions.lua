--[[
6.2 - NON-GLOBAL FUNCTIONS

The obvious consequence of first-class functions is that I can store functions in
table fields and in local variables. Most of lua libraries use this mechanism
(e.g., io.read, math.sin) To create such functions in lua, I just have to put
together the regular syntax for functions and tables
]]
local Lib = {}
Lib.foo = function(x, y)
	return x + y
end
Lib.goo = function(x, y)
	return x - y
end

-- we can also use the constructor itself
local Lib2 = {
	foo = function(x, y)
		return x + y
	end,
	goo = function(x, y)
		return x - y
	end,
}

-- and lua offers yet another syntax
local Lib3 = {}
function Lib3.foo(x, y)
	return x + y
end
function Lib3.goo(x, y)
	return x - y
end

-- NOTE a subtle point to keep in mind when using local functions with recursion
local fact = function(n)
	if n == 0 then
		return 1
	else
		return n * fact(n - 1) -- this is buggy
	end
end

-- the issue is that when lua compiles the call 'fact(n-1)' the local fact is not
-- yet defined. So this expression calls a global fact, not the local one. To solve
-- for this, we need to first define the local variable and then define the function
local fact2
fact2 = function(n)
	if n == 0 then
		return 1
	else
		return n * fact(n - 1)
	end
end

-- now the fact  in the function refers to the local variable, its value doesn't
-- matter at this point; by the time the function executes, facct already has
-- the right value. This is what lua does when it expands local functions.
-- creates the variable first and then the function definition, so we can do this
-- without worrying
local function fact3(n)
	if n == 0 then
		return 1
	else
		return n * fact(n - 1)
	end
end
-- though indirect recursion (meaning two separate functions) must be declared explicitly
-- as I did above
local f,g -- 'forward' declarations
function g()
	-- <some code> f() <some more code
end

function f()
	-- <some code> g() <some code>
end
-- writing local again on the function will create a fresh local variable, keaving
-- the original shadowed.



