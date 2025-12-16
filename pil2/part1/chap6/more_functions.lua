--[[ 
Chapter 6 - MORE ABOUT FUNCTIONS

NOTE - take more notes than usual on this one

Function in lua are first-class values with PROPER LEXICAL SCOPING. 

That means that in lua, a function is a value with the same rights as any conventional
value like numbers and strings. Functions can be stored as variables (both global and
local) and in tables, can be passed as arguments, and can be returned by other functions.

This in combination with tables, to me, is the secret super power of lua. 

So what about the 'lexical scoping' piece. This means that functions can access 
variables of their enclosing (parent) functions. It also means that lua properly
contains the lambda calculus. As will be seen in this chapter, this apparently 
innocuous property brings great power to the language, since it allows us to 
apply lua in many powerful programming techniques from the functional-language
model. Even if I have no interest in functional programming, its worth learning
a little about how to explore these techniques, since they make our programs
smaller and simpler. 

KEY NOTE - FUNCTIONS, LIKE ALL OTHER VALUES, ARE ANONYMOUS. They don't have names. When
we talk about a function name, such as print, we are actually talking about a VARIABLE 
that holds the anony function. like any other variable holding any other value, I can
manipulate such variables in many ways. 

For example:
]]
local a = { p = print } -- a.p not refers to print
a.p("Hello Lua") --> 'Hello Lua'
print = math.sin -- print now refers to sine
a.p(print(1)) --> 0.8414709848079
sin = a.p -- sin now refers to a.p which refers to print
sin(10, 20) --> 10 20
sin()

-- so are expressions that create functions since they are values?
-- yes
-- Technically this
function foo(x)
	return 2 * x
end

-- is just syntactic sugar for this:
foo2 = function(x)
	return 2 * x
end

-- function(x) body is a function constructor just as {} is a table constructor.
-- creating an anony function. Although we assign functions to global variables,
-- giving them something like a name, there are several occassions when functions
-- remain anonymous.

-- one example is table.sort. Such a function must allow for unlimited variations in
-- the sort order: ascending or descending, numeric or alphabetical, tables sorted
-- by key, and so on. Instead of trying to anticipate and create different function
-- variations for all of these options, 'sort' provides a single optional parameter,
-- which is the 'order function': a function that receives two elements and returns
-- whether the first must come before the second in the sorted list.
local network = {
	{ name = "grauna", ip = "210.26.30.34" },
	{ name = "arraial", ip = "210.26.30.23" },
	{ name = "lua", ip = "210.26.23.12" },
	{ name = "derain", ip = "210.26.23.20" },
}

-- so how do we sort this table by the name field
sin(unpack(network))
table.sort(network, function(a, b)
	return (a.name > b.name)
end)
sin(unpack(network))

--[[
A function that gets another function as an argument is called a 'higher-order' function.
Higher-order functions are a powerful programming mechanism, and the use of anony
functions to create their function arguments is a great source of flexibility. But
I need to remember that higher-order functions have NO SPECIAL RIGHTS EITHER; they are
direct consequences of the ability of lua to handle functions as first-class values

Because functions are first-class values in lua, I can store them not only in global
variables, but also in local ones and in table fields. As I'll see later, the use of
functions in table fields is a key ingredient for some advanced uses of lua, such
as modules and object oriented programming.
]]

