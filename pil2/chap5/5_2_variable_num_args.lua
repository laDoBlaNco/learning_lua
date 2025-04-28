--[[
5.2 VARIABLE NUMBER OF ARGUMENTS

So some functions in lua receive a varible number of args. For instance, I have already call print with
one, two, and more args. Although print is also defined in C, I can defin functions that accept
a variable number of args in lua as well.

Here's an example
]]

function add(...)
  local s = 0
  for i,v in ipairs{...} do s = s + v end
  return s
end

print(add(3,4,10,25,12)) print()

--[[
The ... in the parameter list indicates that the function accepts a variable number of args.
When this function is called, all its arguments are collected internally; Ill call these collected
arguments the varargs (variable arguments) of the function. A function can access its varargs using
again the ..., now as an expression. In my example, teh expression {...} results in an array 
will all collected arguments. The function then traverses the array to add its elements

The expression ... behaves like a multiple return function returning all varargs of the 
current function. For instance the following

  local a,b = ...

would create two local variables with the first to optional args (or nil if there are no such args)
Actually, I can emulate the usual parameter-passing mechanism of lua like

  function foo(a,b,c) 
  
which would be the same as

  function foo(...)
    local a,b,c = ...

Even the following would work
]]
function foo1(...)
  print('calling foo with:',...)
  return ...
end

print(foo1('a','b',1,2,3,'c'))
print()

--[[
This is a useful trick for tracing calls to a specific function

Here's another example. Lua provides separate functions for formatting text (string.format) and
for writing text (io.write). It is straightforward to combine both functions into a single one.
]]

function fWrite(fmt,...)
  return io.write(string.format(fmt,...))
end

--[[
Note the presence of a fixed parameter fmt before the dots. vararg functions mah have any
number of fixed parameters BEFORE the vararg part. Lua assigns the first args to these parameters
and only the extra args (if any) go to the varargs. So the following calls would have these 
specified arg layout

  fWrite()            <-->        fmt: nil, with no varargs
  fWrite('a')         <-->        fmt: 'a', with no varargs
  fWrite('%d%d',4,5)  <-->        fmt: '%d%d', varargs: 4 and 5

To iterate over its variable arguments, a function may use the expression {...} to collect
them all in a table, as I did in the 'add' definition. In the rare occasions when the vararg 
list may contain valid 'nils', I can sue the 'select' function. A call to 'select' has always one 
fixed argument, the selector, plus a variable number of extra args. If the selector is a number n,
select returns its n-th extra argument; otherwise, the selector  should be the string '#', so 
that select returns the total number of extra arguements. 

  for i=1,select('#',...) do
    local arg = select(i,...)   -- get the i-th parameter
    <loop body>
  end

Specifically, the call select('#',...) returns the exact number of extra parameeters, including
nils. 

Lua 5.0 had a different mechanism for variable args. The syntax for declaring a vararg function
was the same, with the .... However lua 5.0 didn't have the ... expression. Instead a vararg
function had a hiddent local variable, called  arg. This is what a lot of other languages do
actually. This 'arg' variable would get a table with the varargs along with an n field with the 
total of extra arguments

The problem with this was that it created a new table for every function call. With the new 
mechanism we have more control of when that happens.

]]
