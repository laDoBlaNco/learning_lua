--[[
System Monitoring and Resource Management:

Besides file manip, utility modules also assist with system monitoring. lfs provides the ability
to check disk usage indireclty by reading file sizes and directory contents. I might also use
lua's os.execute to run shell commands for more comprehensive monitoring
]]

-- To list disk usage:
local handle = io.popen('df -h') -- Starts a program 'io.popen(prog [,mode])' in a separate process
-- the mode is 'r' - read or 'w' - write
-- so the question is what does 'df' do? so 'df' is a shell command to show information about the
-- file system. 'df -h' -h = --human-readable
if handle then -- this is a basic 'check nil'
  local result = handle:read('*a')
  handle:close()
  print('Disk Usage information:')
  print(result)
else
  print('There seems to be an issue getting the result')
end

-- using io.popen I can execute system commands and capture their output for processing
-- within my lua app. This method is useful for tasks like monitoring resource usage, generating
-- reports, or triggering alerts based on system metrics.
