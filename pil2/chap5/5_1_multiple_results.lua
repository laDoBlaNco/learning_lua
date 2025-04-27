--[[
5.1 MULTIPLE RESULTS

an unconventional but very useful feature of la is that functions may return multiple results.
This is something that we do in Go as well which is the first language I've used this feature.
Also in Odin where I learned how this differs from just returning a tuple as we do in languages
like Python. Several predefined functions in lua return multiple values. An example is the
string.find function, which locates a pattern in a string. This function returns 2 indices when
it finds the pattern: the index of the character where the pattern match starts and the one
where it ends. With lua's multiple assignment I can make use of this in just one thought:
]]

s, e = string.find('hello lua hackers', 'lua')
print(s, e)
print()

-- functions written in lua also an return multiple results, by listing them all after
-- the 'return' keyword. For instance, a funtion to find the maximum element in an
-- array can return both the value and its location, if desired:
function maximum(a)
  local mi = 1    -- index of the max value
  local m = a[mi] -- max value
  for i, val in ipairs(a) do
    if val > m then
      mi = i; m = val
    end
  end
  return m, mi
end

print(maximum { 8, 10, 23, 12, 15 })
print()

--[[
Lua always adjusts the number of results from a function to the circumstances of the call.
When we call a function as a statement, lua discards all results from the function. When
we us a call as an expression, lua keeps only the first result. We get all results only when
the call last (or the only) expression in a list of expressions 🤯🤯🤯. This is very interesting.

These lists appear in four constructions in lua: multiple assignments, arguments to function calls,
table constructors, and 'return' statetments. To illustrate all these cases see the following:
]]
function foo0() end                 -- no results

function foo1() return 'a' end      -- returning 1 result

function foo2() return 'a', 'b' end -- returning 2 results

-- in a multiple assignent, a function call as the last (or only) expression produces as many
-- results as needed to match the vars
x, y = foo2() -- x='a', y='b'
print(x, y)
x, y = nil, nil
x = foo2()        -- x='a', 'b' is discarded
print(x, y)
x, y, z = 10, foo2() -- returns its 2 results
print(x, y, z)
print()

-- if a function has no results or not as many results as we need, lua produces 'nils' for the
-- missing values
x, y = nil, nil
x, y = foo0()
print(x, y)
x, y = foo1()
print(x, y)
x, y, z = foo2()
print(x,y,z)
print()

-- a function call that isn't the last element in the list always produces exactly one
-- result
x,y = foo2(),20 -- since foo2 isn't the last in the list it only produces it first result 
print(x,y)
-- this is regardless if the remainlng list is sufficient for all the variables
x,y=nil,nil
x,y=foo0(),20,30 -- here we still get the nil result
print(x,y)
print()

-- when a function is the last (or the only) argument to another call, all results from the
-- first go as args. I've seen examples of this with the 'print' functions:
print(foo0())  -- no args to print
print(foo1())  -- 1 result printed
print(foo2())  -- both results printed
print(foo2(),1)  -- since  foo2 is the first in the arg list, only get 1 result and then the 1
print(foo2() .. 'x')    -- what's happening here 🤔🤔
print()

--[[
On that last one, when the call to foo2 appears inside of an expression (foo2() .. 'x'), lua adjusts
the number of results to one; so, in the last line, only the 'a' is used in the concatenation.

The print function may receive avariable number of args. If I write f(g()) and f has a fixed number
of args, lua adjusts the number of results of g to the number of parameters of f, as I saw previously.

A constructor collects all results from a call, without any adjustments so ...

  {foo0()} --> {} 
  {foo1()} --> {'a'}
  {fool2()} --> {'a','b'}

As always, this behavior happens only when the call is the last in the list; calls in any other
position produce exactly one result

  {foo0(),foo2(),4}  --> {nil,'a',4}
]]
t = {foo0(),foo2(),4}

for i,v in pairs(t) do
  print(i .. '|' .. v)
end
-- I'm not sure why the above doesn't work. I'll need to come back to it later. Ok, I figured 
-- out that the above didn't work with ipairs, but it does with pairs. That means that the constructor
-- doesn't create a simple {nil,a,4} array with natural indices, which is why ipairs doesn't work. But
-- it creates an associative array. I still need to dig into the specifications to understand why though
print(t[1],t[2],t[3])
print()

-- finally a statement like 'return f()' returns all values returned by f
function foo(i)
  if i == 0 then return foo0()
  elseif i == 1 then return foo1()
  elseif i == 2 then return foo2()
  end
end

print()
print(foo(1))
print(foo(2))
print(foo(0))
print(foo(3))
print()

-- I can also force a call to return exactly one reslt by enclosing it in an extra pair of ()s
print((foo0()))
print((foo1()))
print((foo2()))
print()

--[[
The example above is important because I need to beware that a 'return' statement doesn't need ()s 
around the value. Any pair of ()s placed there counts as an 'extra' set of ()s. meaning that if 
the return is a function with multiple results, no matter how many results I should get, I'll only
receive 1. This might be what I want, but it might not.

A special function with multiple retuns is 'unpack'. It receives an array and returns as results
all elements from the array, starting with index 1
]]

print(unpack{10,20,30}) -- but it looks like its deprecated
a,b = unpack{10,20,30}
print(a,b) -- 30 is discarded
print()

--[[
An important use for 'unpack' is in a generic call mechanism. A generic call mechanism
allows me to call any function, with any arguments, dynamically. In ansi C, there is no 
to code a generic call. I can declare a function that receives a variable number of args
(with stdarg.h) and I can call a variable function, using pointers to functions, However
I can't call a funtion with a variable number of arguments: each call I write in C has a 
fixed number of argumentes, and each argument has a fixed type. In lua, If I want to call a 
variable function f with variable args in an array a, I simply do f(unpack(a))

The call to unpack returns all values in a, which become the arguments to f
]]

f = string.find
a = {'hello','ll'}

-- then the call f(unpack(a)) returns 3 and 4 the same result as returned by string.find('hello','ll')
print(f(unpack(a)))
print()

-- The actual unpack function in written in C, but this is what it would like like in lua with
-- recursion
function myUnpack(t,i)
  i = i or 1  -- basically setting a default of index 1 for i. If there is no i, then its 1
  -- since we will always call it just with t not sure why we did this this way, but oh well
  if t[i] then -- base case for recursion is t[i] being nil
    return t[i],myUnpack(t,i+1)
  end
end

print(f(myUnpack(a)))  -- same result
print()

--[[
The first time I call it, with a single argument, i gets 1. After that the function returns
t[1] followed by all the results from myUnpack(t,2), with in turn returns t[2] followed by all the
results from myUnpack(t,3), and so on. 
]]



