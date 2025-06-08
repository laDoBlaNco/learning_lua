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
code. Before you use it, make sure that there is no simpler way to solve the problem at hand.

If you want to do a quick-and-dirty 'dostring' (i.e., to load and run a chunk), you can call
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


]]
