--[[
8.4 ERROR HANDLING AND EXCEPTIONS

So for most applications I won't need to worry about error handling since lua is an "extension" 
language its really built to simple return 'nil' with an error message and let the host application
handle the error. But if I do need to handle an error in a lua only application, then I need to use
a pcall (protected call) to encapsulate the code

  if pcall(foo) then
    -- no errors while running 'foo'
    <regular code>
  else
    -- 'foo' raised an error: take appropriate action
    <regular code>
  end

or with an anony func

  if picall(function()
    <protected code>
  end) then
    <regular code>
  else
    <error-handling code>
  end

As seen, pcall's first arg is called in 'protected mode', so it catches any errors while the function
is running and just returns false and the error message, but doesn't let the protected function call 
impact the running program. 

The error message doesn't have to be a string either. Any lua value that is passed to 'error' will
be returned by pcall:
]]

local status,err = pcall(function() error({code=121}) end) -- here the message is a table?
if err then print(err.code) end -- had to add a 'nil check'

-- With these I have all I need to do exception handling in lua. I can throw an exception with
-- error and catch it with a pcall. The error message identifies the kind of/or error