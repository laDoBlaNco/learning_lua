---@diagnostic disable: need-check-nil, undefined-field
--[[
8.4 ERROR HANDLING AND EXCEPTIONS

for many applications, I don't need to do any error handling in lua; the
application program does this handling. (but since I'm planning on working
with full lua systems, I'll need it 🤓🤓🤓). All lua activities start
from a call by the application, usually asking lua to run a chunk. If 
there is any error, this call returns an error code, so that the app
can take appropriate actions. In the case of the stand-alone interpreter,
its main loop just prints the error message and continues showing the prompt
and running the commands. 

If I do need to handle errors in lua, I must use the 'pcall' function
(protected call) to encapsulate our code. 

Now suppose tha we want to run a piece of lua code and to catch any error
raised while running said code. Our first step is going to  be to encapsulate
that piece of code in a function. So let's call that function 'foo':

  function foo()
    <some code>
    if unexpected_condition then error() end
    <some more code>
    print(a[i]) -- POTENTIAL ERROR HERE: 'a' may not be a table
    <and some more code>
  end

The we can call this foo function with pcall

  if pcall(foo) then
    -- no errors while 'foo'
    <regular code>
  else
    -- 'foo' raised an error: take the apprpriate actions
    <error-handling code>
  end

of course, we can call pcall with an anony func as well

  if pcall(function() 
    <protected call>
  end) then
    <regular code>
  else
    <error-handling code>
  end

The pcall function calls its first argument in 'protected mode', so that it catches
any errors while the function is running. If there are no errors, pcall returns TRUE,
plus any values returned by the call. Otherwise, it returns FALSE, plus the error
message. 

Despite its name, the error message doesn't have to be a string. Any lua value that 
we pass to error will be returned by 'pcall':
--]]
local status,err = pcall(function() error({code=121}) end)
print(err.code);print() -- so what I thought about 'check nil' being an assert isn't right

--[[
These mechanisms provide all we need to do exception handling in lua. We 'throw' an
exception with 'error' and 'catch' it with 'pcall'. The error message identifies
the kind of error we have.
--]]


