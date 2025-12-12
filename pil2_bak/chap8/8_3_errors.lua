--[[
8.3 ERRORS

Since lua is an extension language and embedded in an application, ti can't simply crash
or exit when an error happens. It ends and returns to the application its embedded in.

Errors happen whenever lua finds something unexpected (adding numbers that aren't numbers, etc)
I can also raise errors with the 'error' command. This is like throwing errors in other languages
I'll use this to try to handle errors in lua
]]

--[[
print "enter a number: "
n = io.read('*number')
if not n then error('invalid input') end -- so here I get this message in the error
--]]


-- the 'if not then error...' is common that we have a built-in function for it.
--[[
io.write 'enter a number:'
n = assert(io.read('*number'), 'invalid input') -- so assert does the if not then error...
--]]
-- NOTE: the '*n' in io.read() is for formatting so it converts the input to a number and returns that
-- number 🤯

-- key to remember that lua functions always evaluate teh arguments, so if we are doing anything
-- additional in the assert, like concatenation or something, that will evaluate and may result
-- in something strange
---[[
n = io.read()
assert(tonumber(n), 'invalid input: ' .. n .. ' is not a number')
--]]

-- The general guideline with errors is, an exception that is easily avoided should raise an error; 
-- otherwise it should return an error code
