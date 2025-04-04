--[[
Advanced File Manipulation: Copying, Moving, and Deleting Files:

While lfs doesn't include built-in functions for copying or moving files, I an use lua's
os.execute to call system functions or write my own. for example
]]

local function copyFile(source,destination)
  local infile = io.open(source,'rb')
  if not infile then
    return nil,'Failed to open source file.' -- example of those functions that return err messages and nil
  end
  local outfile = io.open(destination,'wb')
  if not outfile then
    infile:close() -- then we make srue we close the infile
    return nil,'Failed to open destination file.'
  end
  local content = infile:read('*all')
  outfile:write(content)
  infile:close()
  outfile:close()
  return true
end

local success,errMsg = copyFile('example.txt','example_copy1.txt')
if success then
  print('File copied successfully.')
else
  print('Error copying file:',errMsg)
end

local success,errMsg = copyFile('example.txt','example_copy2.txt')
if success then
  print('2nd copy created successfully.')
else
  print('Error copying file:',errMsg)
end

-- pretty self explanatory and great look at how I can do the pattern of returning either 'true'
-- or nil with an error message. Unlike Go I don't have to return a 'nil' for that second return item
-- if I don't want to. It'll be nil automatically 

-- Now that I've changed things to create 2 copies I'll see the example of os.remove to delete that 
-- first copy
local removed,err = os.remove('example_copy1.txt')
if removed then
  print('File deleted successfully')
else
  print('Error deleting file:',err)
end
