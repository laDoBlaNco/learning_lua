-- Sample Program: Directory Archiver
-- This sample program will check a specified dir for files not modified within the last
-- day and move them into an archive folder.

local lfs = require 'lfs'
local os  = require 'os'
local function getModificationTime(filepath)
  local attr = lfs.attributes(filepath)
  return attr and attr.modification or nil -- the lua ternary
end

local function moveFile(source, dest)
  local infile = io.open(source, 'rb')
  if not infile then return nil, 'unable to open source file' end
  local outfile = io.open(dest, 'wb')
  if not outfile then
    infile:close()
    return nil, 'Unable to open destination file'
  end
  local content = infile:read('*all')
  outfile:write(content)
  infile:close()
  outfile:close()
  os.remove(source)
  return true
end

local function archiveOldFiles(dir, archiveDir, maxAge)
  local currentTime = os.time()
  for file in lfs.dir(dir) do
    if file ~= '.' and file ~= '..' then
      local fullPath = dir .. '/' .. file
      local mode = lfs.attributes(fullPath,'mode')
      if mode == 'file' then
        local modTime = getModificationTime(fullPath)
        if modTime and (currentTime - modTime > maxAge) then
          local dest = archiveDir .. '/' .. file
          local success,err = moveFile(fullPath,dest)
          if success then
            print('Archived file:',fullPath,'to',dest)
          else
            print('Failed to archive file:',fullPath,'-',err)
          end
        end
      end
    end
  end
end

-- define directories and maxAge
local sourceDir = lfs.currentdir()
local archiveDir = lfs.currentdir() .. '/archive'
local oneDayInSeconds = 24*60*60

-- create archive dire if it doesn't already exist
if not lfs.attributes(archiveDir,'mode') then
  os.execute('mkdir ' .. archiveDir)
end

-- Archive old files
archiveOldFiles(sourceDir,archiveDir,oneDayInSeconds)

-- In this example archiveOldFiles checks each file in a specified directory (here I changed it to
-- just use the currentdir) If the files modification time is older older than one day, it moves
-- (which is just copy and remove) the file into an archive directory. These techniques empower
-- me to manage files and system resources in order to boost the functionality and robustness
-- of the lua application
