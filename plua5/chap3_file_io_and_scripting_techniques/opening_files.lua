--[[
Lua gives us a simple way to open files using the built-in io.open function. This function
requires a file name and a mode, such as read, write, or append. 
]]

file = io.open('example.txt','r') -- returns file-handle or nil
if file then
  print('File opened successfully for reading.')
else
  print('Failed to open file')
end


