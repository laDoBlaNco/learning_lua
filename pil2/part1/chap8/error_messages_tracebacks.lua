--[[
8.5  ERROR MESSAGES AND TRACEBACKS

Now Although we can sue a value of any type as an error message, usually error
messages are in fact strings describing what went wrong. When there is an internal
error (such as an attempt to index a non-table value), Lua generates the error
message; otherwise, the error message is the value passed to the error function. 
Whenever the message is a string, Lua tries to add some information about the
location where the error happened. 
--]]
local status,err = pcall(function() a='a'+1 end)
print(err);print()

status,err = pcall(function() error('my error') end)
print(err);print()

--[[
The location information gives th efile name (stdnin, in the example) plus the 
line number.

The error function has an additional second param, which gives the level where it
should report the error; we can use this param to blame someone else for the error.
For example, suppose we write a function whose first task is to check whether it 
was called correctly:
--]]
function foo(str)
  if type(str) ~= 'string' then
    error('string expected')
  end
  --<some other code>
end
-- print(foo({x=1}));print()

--[[
As it is Lua points the finger at our function, after all it was 'foo' that called
'error' -- and not to the real culprit, the caller. To correct this problem, we
inform error that the error we ar reporting occured on level 2 in the calling
hierarchy (level 1 is our function)
--]]
function foo2(str)
  if type(str)~='string' then
    error('string expected',2)
  end
  -- <regular code>
end

--[[
Frquently, when an error happens, we want more debug information than just the
location where the error occurred. At least, we want to traceback, showing the
complete stack of calls leading to the error. When pcall returns its error
message, it destroys part of the stack (the part that went from it to the error
point). Consequently, if we want a traceback, we must build it BEFORE pcall returns.
To do this, lua provides the 'xpcall' function. Besides the function to be called,
it receives a second argument, an 'error handler function'. In case of error, lua
calls this error handler 'before the stack unwinds', so that it can use the debug
library to gather any extra information it wants about the error. Two common error
handlers are: 

  - debug.debug, which gives us a lua prompt so that we can inspect by ourselves
    what was going on when the error happened, and
  - debug.traceback, which builds an extended error message with a traceback.

The latter is the function that the stand-alone interpreter uses to build its
error messages. We can also call debug.traceback at any moment to get a 
traceback of the current execution
--]]
print(debug.traceback());print()






