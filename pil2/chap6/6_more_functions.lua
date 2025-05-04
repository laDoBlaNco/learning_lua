--[[
Functions in lua are first-clas values with proper lexical scoping.

What does that really mean for me? It means that, in lua a function is a vlaue with the same
rights as conventional values like numbers and strings. Functions can be stored in variables
(both global and local) and in tables, can be passed as args, and can be returned by other
functions.

What does it mean for me for functions to have lexical scoping? It means that functions can
access variables of their enclosing functions. (It also means that lua properly contains the lambda
calulus). As I'll se in this chapter, this apparently innocuous (harmless) property brings great power to
the language, becasue it allows us to APPLY in lua many powerful programming techniques from the
functional-language world. Even if I have no interest at all in functional programming, it is worth
learning a little about how to explore these techniques, because they can make my programs smaller
and simpler.

Now a somewhat confusion notion in lua is that functions, like all other values, are anonymous
they do not have names. When I talk about a function name, such as print, I'm actually talking
about a variable that holds that function. Like any other variable holding any other value, I
can manipulate such variables in many dofferent ways. The following example, although silly,
shows that:
]]

--[[
a = { p = print } -- a.p now refers to the print function
a.p('Hello Lua World!')
print = math.sin  -- print now refers to the sine function 🤯🤯🤯
a.p(print(1))
sin = a.p  -- now 'sin' refers to the a.p -> print function
sin(10,20)
--]]

-- Later I'll see a more useful application of this facility. 
-- If functions are values, are there expressions that create functions? Yes, In fact the
-- 'usual' way to write a fucntion in lua, such as
function foo(x) return 2*x end  -- is actually just syntactic sugar for
foo2 = function(x) return 2*x end -- THIS IS REALLY WHAT'S HAPPENING

--[[
So, a function definition is in fact a STATEMENT (an assignment, more specifially) that creates a 
value of type 'function' and assignd it to a variable. I can see the expression 
function(x) body end as a function constructor, just as {} is a table constructor. I call the result
of such function constructors an anonymous function. Although we often assign functiosn to global
variables, giving them something like name, there are several occasions in which functions remain
anonymous. 

The table library provides a function table.sort, which receives a table and sorts its 
elements. Such a function must allow unlimited variations in the sort order: ascending or
descending, numeric or alphabetical, tables sorted by a key, and so on. Instead of trying to provide
all kinds of options, sort provides a single optinal parameter, which is the ORDER FUNCTION: a function
that receives two elements and returns whether the first must come before the second in the sorted
list. For example
]]

network = {
  {name='grauna',IP = '210.26.30.34'},
  {name='arraial',IP = '210.26.30.23'},
  {name='lua',IP = '210.26.23.12'},
  {name='derain',IP = '210.26.23.20'},
}

-- if I want to sort the table by the field NAME, in reverse alphabetical order, I just do this:
table.sort(network,function(a,b) return (a.name > b.name) end)
for _,v in pairs(network) do print(v.name) end
print()
table.sort(network,function(a,b) return (a.name < b.name) end)
for _,v in pairs(network) do print(v.name) end

--[[
Se how handy the anonymous function is in this statement. 

A function that gets another function as an argument, such as sort, what we call a higher-order 
function. Higher-order functions are a powerful programming mechanism, and the use of anony functions
to create their function arguments is a great source of flexibility. But I need to remember that higher
order functions have no special rights; they are a direct consequence of the ability of lua to
handle functions as first class citizens.

To further illustrate the use of higher-order functions, I'll write a naive implementation of a 
common higher-order funtion, the derivative. 
]]

function derivative(f,delta)
  delta = delta or 1e-4
  return function(x)
    return (f(x+delta) - f(x))/delta
  end
end

-- now given a function f, the call derivative(f) returns (an approximation of) its derivative,
-- which is another function
print()
c = derivative(math.sin)
print(math.cos(10),c(10))

-- since functions are first-class citizens in lua, I can store them not only in global 
-- variables, but also in local variables and in table fields. As I'll see later, the use 
-- of functions in table fields is a key ingredient for some advanced uses of lua, such as
-- modules and object-oriented programming.





