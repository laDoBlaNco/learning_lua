--[[
Conditional Debug Logging

Sometimes inserting print statement throughout our code can clutter our output, especially
when debugging complex constructs. To manage this, I can implement a conditional debug logging
function that only prints messages when debugging is enabled.
]]

local DEBUG = true
function debugLog(message)
  if DEBUG then
    print('[DEBUG]',message)
  end
end

function computeValue(a,b)
  debugLog('computeValue started with a = ' .. tostring(a) .. ' and b = ' .. tostring(b))
  local result = a * b + 10
  debugLog('computeValue result: ' .. tostring(result))
  return result
end

print()
print(computeValue(5,3))

-- by controlling the DEBUG flag, I can easily turn debugging message on or off, keeping the
-- output clean during normal operation while providing detailed insights when troubleshooting