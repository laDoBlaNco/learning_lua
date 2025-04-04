--[[
Utility Functions for Enhanced File Management:

In additiont o lfs, I may use utility functions to extend the file management capabilities. 
I can write functions to search for files matching specific patterns, recursively traverse
directories, or even archive files.

Here a simple function to search for files by extension:
]]
local lfs = require 'lfs'

local function searchFiles(directory,extension)
  local results = {}
  for file in lfs.dir(directory) do
    if file ~= '.' and file ~= '..' then
      local fullPath = directory .. '/' .. file
      local mode = lfs.attributes(fullPath,'mode')
      if mode == 'file' and file:match('%.' .. extension .. '$') then
        table.insert(results,fullPath)
      elseif mode == 'directory' then
        local subResults = searchFiles(fullPath,extension) -- NOTE: interestingly if I use the anony
        -- func syntax then I can't do recursive function defs 🤔
        for _,subFile in ipairs(subResults) do
          table.insert(results,subFile)
        end
      end
    end
  end
  return results
end

local txtFiles = searchFiles(lfs.currentdir(),'txt')
print('Found text files:')
for _,filename in ipairs(txtFiles) do print(filename) end

-- This function searches through a directory and its subdirectories for files with a specific
-- extension. These utility functions are really helpful when managing large file systems or 
-- performing batch operations on a collection of files.