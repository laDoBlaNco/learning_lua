--[[
Utilizing Lua's Debug Library:

Lua has a built-in debug library which offers odditional tools for examining the internal
state of my program. Functions like debug.traceback can help obtain a stack trace when an 
error occurs, making it easier to pinpoint the source of the issue.

]]

function safeCall(func,...)
  local  status,result = pcall(func,...)
  if not status then
    print('Error encountered')
    print(debug.traceback())
    return nil
  end
  return result
end

local function faultyFunction(x)
  return x + nil -- Intentional error: cannot add number and nil 
end

safeCall(faultyFunction,5)

-- The faultyFunction triggers an error, debug.traceback prints the call stack, giving me a clear
-- picture of how the execution reached the problematic point. 