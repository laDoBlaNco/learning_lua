--[[
Directory Traversal and Listing Files:

Another important aspect of file system manip is the ability to traverse directories and
list their contents. using the lfs.dir function I can iterate over all items in a directory. 
This is useful for tasks such as searching for files that match a specific pattern or performing
batch operations on a group of files.
]]

local lfs = require 'lfs'
local function listFiles(directory)
  print('Listing files in directory:',directory)
  for file in lfs.dir(directory) do -- so apparenlty this functio returns a lua iterator
    if file ~= '.' and file ~= '..' then
      local fullPath = directory .. '/' .. file
      local mode = lfs.attributes(fullPath,'mode') -- we get attributes since directory/file is THE file
      print('Found ' .. mode .. ':',fullPath)
    end
  end
end

-- the I call function to list files in the current directory
listFiles(lfs.currentdir())

-- in this script I defined a function that lists each file and directory in the given path
-- excluding the current (.) and parent (..) directories. By combining lfs.dir with lfs.attributes
-- I can build complex file management utilities that process directories recursively or filter
-- files based on type
