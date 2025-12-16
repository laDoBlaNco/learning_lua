--[[
6.2 - CLOSURES

When a function is written enclosed in another function, it has full access to
local variables from the enclosing (parent) function. This is what I call 
its own portable universe and its called 'lexical scoping'. This visibility might
sound obvious, but it isn't. Lexical scoping + first-class functions, is a 
powerful concept but not all languages support it. 
]]

local names = { "Peter", "Paul", "Mary" }
local grades = { Mary = 10, Paul = 7, Peter = 8 }
print(unpack(names))
-- print(unpack(grades)) -- this doesn't work as unpack doesn't work with general tables
-- it was made to work with array tables
table.sort(names, function(n1, n2)
	return grades[n1] > grades[n2] -- compare the grades
end)
print(unpack(names))

-- now  to put that in function
function sort_by_grade(n, g)
	table.sort(n, function(n1, n2)
		return g[n1] > g[n2]
	end)
end

--[[
The interesting part here is that the anony function given to sort accesses the param
grades, which is local to the parent function sort_by_grade. Inside this anony function
, grades is neither a global nor a local var (also called upvalues in lua). But since
functions are first-class values
]]

function newCounter()
	local i = 0
	return function() -- anony function
		i = i + 1
		return i
	end
end

local c1 = newCounter()
print(c1())
print(c1())

-- basic counter example of using the counter even though 'i' is already out of scope
-- and it still works and is handled correctly using the concept of Closures. A closure
-- is a function plus ALL it needs to access non-local variables correctly.
local c2 = newCounter()
print(c2())
print(c1())
print(c2())

--[[
-- so c1 and c2 are 2 different closures over the same function, and each acts on
-- an independent 'universe' or instantiation of the local variable i

Technically speaking, what is a value in lua is the closure, not the function itself.
The function is just a prototype for closures. Nevertheless, we continue to sue the term
function to refer to a closure whenever there is no possibility of confusion.

Closures provide a valuable tool in many contexts. As I've already seen, they are
useful as arguments to higher-order functions such as 'sort'. closures are 
valuable for functions that build other functions as well, like our newCounter above. 
This allows lua programs to incorporate sophisticated programming techniques from
the fuctional world. Closures are also useful for 'callback' functions. A typical 
example here occurs when I create buttons in a conventional GUI toolkit. Each button
has a callback function to be called when the user presses the button; I want different
buttons to do slightly different things. For instance, a digital calculator needs ten
similar buttons, one for each digit. Such as below
]]
--[[
function digitButton(digit)
	return Button({
		label = tostring(digit),
		action = function()
			add_to_display(digit)
		end,
	})
end
]]

--[[
In this example above assuming that Button is a toolkit function that creates new
buttons; 'label' is the button label; and action is the callback closure to be
called when the button is pressed. The callback can be called a long time after
digitButton did its task and after the local variable digit went out of scope, but
it still has access to the variable.

Closures are very valuable in a quite different context as well. Since functions 
are stored in regular variables, we can easily redefine functions in lua, even
predefined functions. This facility is one of the reason why lua is so flexible.
Frequently, when I redefine a function I need the original function in the new
implementation. For example, suppose I want to redefine the function 'sin' to
operate in degrees instead of radians. This new function must convert its
argument and then call the original 'sin' function to do the real work. My
code could like like the following:
]]
local oldsin = math.sin
math.sin = function(x)
	return oldsin(x * math.pi / 180)
end

-- a cleaner way is to keep the old version in a private variable, the only way
-- to access it would then be with the new version.

--[[
This same process can be used to create secure environments, also called sandboxes. 
Secure environments are essential when running untrusted code, such as code 
received through the internet by a server. For example, to restrict the files
a program can access, I can redefine the io.open function using closures
]]
do
	local old_open = io.open
	local access_OK = function(filename,mode)
		-- <check accesses here>
	end
	io.open = function(filename,mode)
		if access_OK(filename,mode) then
			return old_open(filename,mode)
		else
			return nil,"access denied"
		end
	end
end

-- again this way there is no way for the program to call the unrestricted open function
-- without using the new versrion. It keeps the insecure version as a private variable
-- in a closure, inaccessible from the outside. With this technique, I can build lua
-- sandboxes in lua itself, with the usual benefits: simplicity and flexibility. 

-- Instead of a one-size fits all solution, lua offers a meta-mechanism, so I can tailor
-- my environment for my specific needs.