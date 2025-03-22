-- When writing data to a file, it's also important if its open and closed properly so that we
-- don't lose data.

local file, err = io.open('output.txt','w')
if not file then
  print('Error: Unable to open "output.txt" for writing:',err)
  -- Fallback: you may decide to write to a temporary file instead
  return
end

local status,errMsg = pcall(function()
  file:write('Hello, Lua! This is a safe write operation.\n')
end)

if not status then
  print('Error writing to file:',errMsg)
  -- optionally handle partial writes or attempt to save to an alternative file
end

local closeStatus, closeErr = pcall(function()
  file:close()
end)

if not closeStatus then 
  print('Error closing the file:',closeErr)
  -- Fallback: handle cleanup as needed
end

