--[[
8.5 ERROR MESSAGES AND TRACEBACKS



]]

--[[
local status, err = pcall(function() a = 'a'+1 end)
print(err) -- typically the message in an error is a string, although any value from lua can be used
-- if I don't user  error with a message then lua will add a string to give me an idea of what happend
--]]

--[[
local status, err = pcall(function() error('my error') end)
print(err) -- If  I use error with a message then it will be used in the error, but in addition
-- note that lua adds info to show me where the error happened (stack trace)
-- for example above will give the file name and the line number
--]]


--[[
function foo(str)
  if type(str) ~= 'string' then
    error('string expected',2)
  end
  print(str)
end
-- 'error' has a second arg so that I can identify who caused the error. for example, above its true
-- the error was thrown from my function, but it was the user input that was erred, not the function. 
-- using 2 (level 2) tells us it was the calling environment, not our function that erred
-- that being said, I don't see the difference when I run this function without that arg, so I'll
-- need to dig a little bit more to understand that one 🤔

foo('hello there')
foo(123)
--]]

---[[
-- Normally when I have an error I want to get more info than just where it happened. 
-- at the very least a traceback showing the complete stack of calls leading up to the error. 
-- But using pcall I lose part of that stack since its encapsulated. It destroys part of the 
-- stack. So if I want the full stack trace then I need to build it before pcall returns. 
-- I can do this with xpcall which receives a second arg, an error handler function. If there is
-- an error than lua will call the 'error handler' before the stack unwinds, so that it can use
-- the debug library to gather any extra information I may want about the error, prior to it
-- returning. Two common handlers are debug.debug, whcih gives me a lua prompt so I can inspect
-- myself what is going on and debug.tracback, which builds an extended error message with a
-- traceback. The latter is the function that the standalone interpreter uses to build its error
-- messages. I can also call debug.traceback at any moment to get a traceback of current
-- execution
--]]

print(debug.traceback)

