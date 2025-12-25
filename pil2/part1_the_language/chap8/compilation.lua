---@diagnostic disable: need-check-nil
--[[
Chapter 8 - Compilation, Execution, and Errors

Although we refer to lua as an interpreted language, Lua ALWAYS PRECOMPILES
source code to an intermediate form before running it (like Java and python).
The presence of a compilation phase may sound out of place in an interpreted
language like lua, however, the distinguishing feature of interpreted languages
isn't that they are not compiled, but that the compiler is part of the language
runtime and that, therefore, it is  possible (and easy) to execute code generated
on the fly. We may say that the presence of a function (like 'dofile' in lua) is
what allows Lua to be called an interpreted language, though it acts like a 
compiled one. 🤔

8.1 - COMPILATION

"Previously, on hacking in PiL2", we introduced 'dofile' as a kind of primitive 
operation to run chunks of lua code (I believe when we talked about the interpreter)
but 'dofile' is actually an auxiliary function. 'loadfile' does the hard work. Like
'dofile', 'loadfile' loads a Lua chunk from a file, but it DOESN'T RUN the chunk.
Instead, it only comiles the chunk and returns the compiled chunk as a function. 
Moreover, unlike 'dofile', 'loadfile' DOES NOT RAISE ERRORS, but instead RETURNS 
ERRORS CODES, so that we can handle the error. We could define 'dofile' as 
follows (though the actual 'dofile' is probably written in C):
]]
function dofile(filename)
  local f = assert(loadfile(filename)) -- loadfile is what returns the function
  return f()  -- not just returning f, but running it.
end

--[[
Note the use of 'assert' to raise an error if 'loadfile' fails.

For simple tasks, 'dofile' is handy, since it does the complete job in one call
(as it calls 'loadfile' itself). However, 'loadfile' is more flexible. In case of
error, 'loadfile' returns nil PLUS an error message, which allows us to handle the
error in customized ways. Moreover, if we need to run a file several times, we can
call 'loadfile' once and call its result several times. This is much cheaper than
several calls to 'dofile', since the file is compiled only once. 

The 'loadstring' function is similar to 'loadfile', except that it reads its chunk
from a string, not from a file. For example, after the following code 'f' will be
a function that, when invoked, executes our code. 
]]

local f = loadstring('i=i+1')
i = 0
f();print(i)
f();print(i)
f();print(i);print()

--[[
The loadstring function is powerful so we should use it with care. It is also an
EXPENSIVE FUNCTION (when compared to some alternatives) and may result in 
incomprehensible code. Before you use it, make sure that there is no simpler way
to solve the problem. (Much like the use of 'goto' or some of the other programming
concepts that should  really only be last resorts)

If you want to do a quick-and-dirty dostring (i.e., to load AND run a chunk same
as 'dofile' loads AND runs a file), you may call the result from loadstring
directly: just throwing () on the end
]]
loadstring('print("my quick-and-dirty dostring");print()')()

--[[
However, if there is any syntax error, loadstring will return nil and the final error
message will be something like "attempt to call a nil value". For clearer error msgs
use assert:
--]]
assert(loadstring('print("my quick-and-dirty dostring...with assert");print()'))()

--[[
Usually it doesn't make much sense to use loadstring on a literal string since its 
basically the same thing as just writting a function, AND the just writing a function
would be MUCH faster (e.g. not as expensive), since its compiled only once, when its
enclosing chunk is compiled. Using loadstring involves a NEW COMPILATION each time 
we call loadstring.

Since loadstring doesn't compile with lexical scoping, the two ways are NOT equivalent.
To see the difference we can change our example a little bit:
--]]
i = 32
local i = 0
f = loadstring('i = i + 1; print(i);print()')
g = function() i = i + 1; print(i);print() end
f()
g()

--[[
See how the g function manipulates the local i, as expected, but f manipulates a 
global i, since loadstring ALWAYS COMPILES IN STRINGS IN THE GLOBAL ENVIRONMENT.

The most typical use of loadstring is to run external code, that is, pieces of
code taht come from outside of my program. For example, I may want to plot a 
function defined by the user; the user enters the function code and then I would
use loadstring to evaluate that code. Note that loadstring expects a chunk, that
is, statements. If I want to evaluate an expression, I must prefix it  with
"return", so that I get a statement that returns teh value of the given
expression 🤔🤔. For example:
--]]
print "enter your expression:"
local l = io.read()
local func = assert(loadstring("return "..l))
print("the value  of your expression is "..func());print()

-- (this means that just using "return" in the global context should work as ewell)
-- print(return "does this work");print()
--[[
(Doesn't work as I thought it would, but in a sense it does. I can use 'return' out 
in the open, and its returning, though its not printing. But it I try to use 
'print(return ...)' then it errors out. Something to do with how loadstrings works
in the context of the global environment more than likely. I could probably adjust
it a bit to work though 🤔)
--]]
-- print(''..return "does this work");print() -- Nah, that doesn't work either, oh well

-- (back to the original example) Since the function returned by loadstring is a 
-- regular function, I can call it several times
print("enter function to be plotted (with variable 'x'):")
local l = io.read()
local f = assert(loadstring("return "..l))
for i = 1,20 do
  x=i -- global 'x' (to be visible from the chunk)
  print(string.rep('*',f()))
end;print()

--[[
The string.rep function replicates (or repeats) a string a given number of times, 
and our returned f() is that number as an expression

If we go deeper, we find out that the real primitive in lua is NEITHER loadfile nor
loadstring, BUT load. Instead of reading a chunk from a file, like loadfile, or from
a string, like loadstring, load receives a READER FUNCTION that IT calls to get its
chunk. That reader function returns the chunk in parts; load calls it until it 
returns nil. (A true iterator, anyone 🤓🤓🤓), which signals the chunk's end. We
seldom use load directly; its main use is when the chunk is not in a file (e.g., its
created dynamically or read from another source) and too big to fit comfortably in
memory (otherwise we just use loadstring)

Lua treats ANY independent chunk as the body of an anony func with a variable number
of arguments. (I feel like this is key to understanding how Lua works under the hood)
For example, 'loadstring("a=1")' returns the equivalent of the following:

  function(...) a=1 end

(which is probably why my earlier inquiry works the way it does using 'return '.. expression)

Like any other function, chunks can declare local variables (which is what we do in
all these scripts since a script is just a chunk):
--]]
f = loadstring("local a = 10;print(a+20);print()")
f();print()

-- using this we can rewrite our plot example to avoid using the global variable
print("Enter another function to be plotted (with variable 'x'):")
local l = io.read()
local f = assert(loadstring("local x = ...;return "..l))
for i=1,5 do
  print(string.rep('#',f(i)))
end

--[[
Here we append the declaration "local x=..." in the beginning of the chunk to declare
x as a local variable. We then call f with an argument i that becomes the value of
the vararg expression (...)

The load functions NEVER RAISE ERRORS. In case of any kind of error, they return nil
plus an error message
--]]

print(loadstring('i i'))

--[[
Moreover these functions never have any kind of side effect. They only compile the
chunk to an internal representation and return the result, as an anony func. A 
common mistake or misconception is to assume that loading a chunk defines functions.
In Lua, function definitions are assignments; as such, they are made at runtime, not
at compile time. For example:

  If we have a file foo.loa with this:

    function foo(x)
      print(x)
    end

  We then run a command
  
    f = loadfile('foo.lua')

  foo is compiled, but its isn't defined yet. To define it you must RUN the chunk

    print(foo) --> nil
    f() -- defines 'foo'
    foo('ok') --> ok

In a production-quality program that needs to run external code, you should handle
any errors reported when loading a chunk. Moreover, if the code cannot be trusted,
YOU MAY WANT TO RUN THE NEW CHUNK IN A PROTECTED ENVIRONMENT, to avoid unpleasant
side effects.
--]]







