-- in addition to fallbacks we should also think about logging erros when dealing with data
-- for debugging purposes. Keeping track of errors to understand wha may be causing problems
-- on file operations

local function logError(message)
  local logFile,err = io.open('error.log','a')
  if logFile then
    logFile:write(os.date('%Y-%m-%d %H:%M:%S') .. ' - ' .. message .. '\n')
    logFile:close()
  else
    print('Error: Unable to open log file:',err)
  end
end

local file,err = io.open('dater.csv','r')
if not file then
  local errorMsg = 'Failed to open datar.csv: ' .. err
  print(errorMsg)
  logError(errorMsg)
  return
end

-- this code defines a logError function that writes error messages to 'error.log' with a
-- timestamp. When a file operation doesn't work, you should record the error before trying 
-- other solutions. This helps with immediate debugging and long-term maintenance  by keeping 
-- a record of issues. 



