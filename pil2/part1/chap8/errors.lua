--[[
8.3 - ERRORS

To err is human. therefore, we must I must handle errors the best I can. Since lua
is an extension language, frequently embedded in an application of some sort, it 
can't just crash or exit when an error happens. Instead, lua needs to end the 
current chunk and return to the application.

Any unexpected condition that lua encounters will raise an error. Errors occur
when I (that is my program) try to add values tha aren't numbers, to call values
that aren't functions, to index values that aren't tables, and so on. I can also
explicitly raise an error alling the 'error' function with the error message as
an arg. Usually, this function is the appropriate way to handle errors in my
code:
--]]
print "enter a number:"
local n = io.read('*number') -- 
--[[
NOTE: according to google, '*number' is a specific
string flag used with io.read to read numerical input. No magic happening here.

  - It reads a number: instructs the program to skip any leading spaces or newlines
    and read a sequnce of characters that form a valid number
  - It returns a number type: Unlike reading a whole line, which returns a string, 
    io.read('*number') automatically converts the input into the number data type
  - It stops at delimiters: Stops reading once it encounters a character that can't
    be part of a number, such as a space or a letter. So it only reads the number portion
  - Returns nil on Failure: If the next available characters on the input stream don't 
    form a valid number, the function returns nil (this we can do a nil check right after
    "if not n then error(...) end")
--]]

if not n then error('invalid input') end

--[[
Such combinations of 'if not condition then error end' is so common that lua has a
built-in function for just this job, called 'assert' 🤓🤯 (so when lua complains that
I need to do a 'nil check', what its really saying is add an 'assert') 🤯🤯🤯 (the
small things I didn't realize with so many years working with lua)(NOTE: so apparently
this isn't exactly right. Coming back to it I tried to use 'assert' when it asked for
a nil check and it didn't remove the error. But that's a linter issue in the end, so
no biggie.). 
--]]
print "enter another number:"
n = assert(io.read('*number'),'invalid input')

--[[
The assert function checks whether its first argument is NOT false and simply returns
this argument; if the argument is false (that is, FALSE or NIL), assert raises an 
error. Its second argument, the message, is optional. Beware, however, that assert
is a regular function. As such, lua always evaluates its arguments before calling
the function. Therefore something like the following may not give me what I want:
--]]
-- n = io.read()
-- assert(tonumber(n),'invalid input: ' .. n .. ' is not a number')

--[[
Lua will always do the concatenation, even when n is a number. It may be wiser to 
use an explicit test in such cases.

When a fucntion finds an unexpected situation (an exception), it can assume two 
basic behaviors: 

  - It  can return an error code (typically nil) or
  - It can raise an error, calling the 'error' function
  
There are no fixed rules for choosing between these two options, but we an provide
a general guideline:

  - an exception that is easily avoided should raies an error;
  - otherwise, it should return an error code

For example, let's consider the sin function. How should it behave when called on a
table? If it returns an error code we would need to do an 'if not res...' check
after the statement. 

However, we could also easily check this BEFORE calling the function with a 
'if not tonumber(x) then ...' check. 

Frequently we check neither the argument nor the result of a call to sin; if the
arg is not a number, it means probably something is wrong in the pragram. In such 
situations, to sopt the computation and issue an error message is the simplest and
most practical way to handle the exception.

Now on the other hand, what if we are using the io.open function, which opens a
file. How should it behave when called to read a file that doesn't exist? There is
no simple way to check for the exception before calling the function. In many 
systemsthe only way of knowing whether a file exists is trying to open it. Therefore,
if io.open can't open a file because of an external reason (such as 'file doesn't exist'
or 'permission denied'), it returns nil, plus a string with the error message. In this
way, I have a chance to handle the situation in an appropriate way rather than crashing
the whole system, for instance by asking the user for another file name:
--]]
local file, msg
repeat
  print "enter a file name:"
  local name = io.read()
  if not name then return end -- no input
  file,msg = io.open(name,'r')
  if not file then print(msg) end
until file

-- if I don't want to handle such situations, but still want to play safe, I can 
-- simply use 'assert' to guard the operation
  -- file = assert(io.open(name,'r'))
-- This is a typical lua idiom: if io.open fails, assert will raise an error

  -- file = assert(io.open('no-file','r'))
    --> stdin:1: no-file: No such file or directory
-- Note how the error message, wihch is the second result from io.open, goes as 
-- the second argument to assert 🤔🤓 (back to lua's basic handling of multiple
-- return values.)

