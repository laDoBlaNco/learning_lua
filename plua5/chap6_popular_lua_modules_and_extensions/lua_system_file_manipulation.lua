-- In this series of scripts I'll look at advance file system and utility modules for basic
-- io operations. in previous lessons I saw reading and writing files, but here I'll dive into
-- modules that offer mor robust file manip capabilities, details system monitoring, and
-- resource management. One of the key modules is lsf (luaFileSystem), used to access file
-- attributes, traverse dirs, and interact with the file system in a more sophisticated way

-- luaFileSystem for Advanced File Manipulation
-- lfs is widely used to access files and system-related operations. I can retrieve attributes
-- (such as size, modification time, permissions, and file type), change working dir, and iterate
-- over the dir contents.

local lfs = require  'lfs'

-- retrieve attributes of a specific file
local attr,err = lfs.attributes('example.txt')
if attr then
  print('File size:',attr.size) -- so it must return (attr) a table
  print('Modification time:',attr.modification)
  print('File mode:',attr.mode)
  print()
  for k,v in pairs(attr) do print('Key: ' .. k ..' | Value: ' .. v) end -- just to see the diff attrs 
else
  print('Error getting attributes:',err)
end

-- so here I use lfs attrs wit various props of the file. I can use these props to make  decisions
-- in the program, such as verifying file size or checking modification dates.