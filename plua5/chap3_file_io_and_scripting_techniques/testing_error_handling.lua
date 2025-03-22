--[[
When working on error handling strategies its important to test our script in
different situations to make sure its working right. One thing we can do is  rename a file
to act like its missing, or change the file permissions to show access problems. These tests
will help you see if our backup plans are good and if our script can handle things when they
go wrong. -- which is what I did in the previous script already
]]
local function logError(message)
  local logFile,err = io.open('error.log','a')
  if logFile then
    logFile:write(os.date('%Y-%m-%d %H:%M:%S') .. ' - ' .. message .. '\n')
    logFile:close()
  else
    print('Error: Unable to open log file:',err)
  end
end

local file,err = io.open('nonexistant.csv','r')

if not file then
  local errorMsg = 'nonexistent.csv does not exist:' .. err
  print(errorMsg)
  logError(errorMsg)

  -- fallback: use default data
  defaultData = 'name,age,score\nDefault,0,0'
  fileContent = defaultData
else
  fileContent = file:read('*all')
  file:close()
end

print('Final Data Processed:')
print(fileContent)

