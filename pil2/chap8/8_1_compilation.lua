--[[
8.1 - COMPILATION

Previously, we introduced 'dofile' as a kind of primitive operation to run chunks of
lua code, but dofile is actually an auxiliary function: 'loadfile' does the hard work.
Like 'dofile', 'loadfile' loads a lua chunk from a file, but it doesn't run the  chunk.
Instead, it only compiles the chunk and returns the compiled chunk as a function. Moreover,
unlike 'dofile', 'loadfile' does not raise errors, but instead returns error codes, so that
they can be handled. Liek this:

  function dofile(filename)
    local f = assert(loadfile(filename))
    return f()
  end

Note the use of 'assert' to raise an error if loadfile fails.

for simple tasks, 'dofile' is handy, cuz it doesn't the comoplete job in one call, however,
'loadfile' is more flexible. In case of error, 'loadfile' returns nil plus the error message,
which allows us to handle the error in customized ways. Moreover, if we need to run a file
several times, we can still 'loadfile' once and call its result several times. This is much
cheaper than several calls to 'dofile', cuz the file is compiled only once.

Apparently we also have a 'loadstring' function which is similar to 'loadfile', except that it
reads its chunk from a string, not from a file. For example below
]]

f = loadstring('i = i + 1')

-- f will be a function that, when invoked, executes i = 1+1;
i = 0
f()
print(i)
f()
print(i)
f()
print(i)


--[[
The 'loadstring' function is powreful; we should use it wisely and with care. it is also an
exepensive function (when compared to some of the alternatives) and may result in incomprehensible
code. Before I use it, make sure that there is no simpler way to solve the problem at hand.

If I want to do a quick-and-dirty 'dostring' (i.e., to load and run a chunk), I can call
the result from 'loadstring' directly

  laodstring(s)()

However, if ther is any syntax error, loadstring will return nil and the final error message
will be something like 'attempt to call a nil value' For a clearer error message, use assert:

  assert(loadstring())()

It typically doesn't make sense to use loadstring on a literal string, for example, the code
below is roughly the same but the second is much faster, since its compiled only once when its enclosing
chunk is compiled. In the first code, each call to 'loadstring' involves a new compilation.

  f = loadstring('i = i + 1')

  f = function() i = i + 1 end

Because loadstring doesn't compile the lexical scoping, the two codes in the previous example
are not exactly equivalent. To see the difference Look at the following example:
]]

print()
i = 32
local i = 0

f = loadstring('i = i + 1; print(i)')
g = function()
  i = i + 1; print(i)
end
f()
g()

--[[
The g function manipulates the local i, as expected, but the f manipulates the global i, since
'loadstring' always compiles its strings in the global environment.

The most typical use of loadstring is to run external code, that is, pieces of code that come
from outside Ir program. For instance, I may want to plot a function defined by the user;
the user enters the function and then I use loadstring to evalute it. Note that loadstring
expects a chunk, that is, statements. If I want to evaluate an expression, I must prefix it
with return, so that I get a statement that returns the value of the given expression. Below
an example:
]]

--[[
print "enter your expression:"
local l = io.read()
local func = assert(loadstring('return ' .. l))
print('the value of your expression is ' .. func())
--]]

-- since the function returned by loadstring is a regular function, I can call it several 
-- times. 
--[[
print "enter function to be plotted (with variable 'x'):"
local l2 = io.read()
local f2 = assert(loadstring('return ' .. l2))
for i=1,20 do
  x = i -- global 'x' (to be visible from the chunk)
  print(string.rep('*',f()))
end
--]]

--[[
(the string.rep function replicates a string a given number of times.) If I go deeper, I find 
out that the real primitive in lua is neither loadfile nor loadstring, but 'load'. Instead of
reading a chunk from a file, like loadfile, or from a string, like loadstring, 'load' recieves
a reader function that it calls to get its chunk. The reader function returns the chunk in 
parts; 'load' calls it until it returns nil, which signals the chunk's end. I'll seldom use 'load';
its main use is when the chunk is not in a file (e.g., its created dynamically or read from another
source) and too big to fit comfortably in memory (otherwise I should use loadstring) 

Lua treats any indpendent chunk as the body of an anony function with a variable number of args.
For instance, loadstring('a=1') returns the equivalent of:
  function (...) a = 1 end

Like any other function, chunks can declare local variables
]]

print()
f = loadstring('local a = 10; print(a + 20)')
f()
print()

-- using these features, I can rewrite the plot example to avoid the use of a global var x
-- just by adding "local x = ...; return" .. l2 

-- The load functions never raise errors. In case of any kind of error, they just return nil
-- plus an error message.
print(loadstring('i i'))
print()


--[[
Moreover, these functions never had any kind of side effect. They only compile the chunk to an
internal representation and return the result, as an anony function. A common mistake is to assume 
that loading a chunk defines functions. In Lua, function definitions are assignments; as such
they are made at runtime, not at compile time. so for example 

    function foo(x)
      print(x)
    end

I can then run the command

    f = loadfile('foo.lua')

After that command, foo is compiled, but it isn't defined yet. To define it, I must run the
chunk

    print(foo) --> nil
    f()        --> this actually defines 'foo'
    foo('ok')  --> ok

In a production-quality program that needs to run external code, I should handle any errors
reported when loading a chunk. Moreover, if the code cannot be trusted, I may want to run
the new chunk in a protected environment, to avoid unpleasant side effects when running the
code. 
]]

