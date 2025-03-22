-- Lua provides the 'pcall' (protected call) function to execute code that may cause runtime
-- errors without halting the entire program. We can wrap file operations in a protected
-- calls to catch errors. so pcall is like 'try' and 'throw' in other languages
local success,content = pcall(function()
  local f = io.open('data.csv','r')
  if not f  then error('File not found') end
  local data = f:read('*all')
  f:close()
  return data
end)

-- pcall returns 2 valus. a boolean and the data or a boolean and the error message. The error
-- message doesn't have to be a string, it can be any value passed to error function.

-- When you call the 'error' function in lua, control flow jumps up the call stack until it
-- finds an error handler. This is like low-level function throwing an exception that is cuaght
-- higher in the call stack.

if success then -- since its a boolean value returned
  print('File content successfully read.')
  print(content)
else
  print('An error occrurred during file operations:',content) -- since content is either the data or
  -- the error message

  -- Fallback strategy: Use a backup file or prompt the user to check the file
end

-- we encapsulated the file reading operations inside a function passed to pcall. If any error
-- occurs, the error message is captured and you can decide how to handle it without crashing
-- or script.

