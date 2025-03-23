--[[
Debugging Metatables and Overloaded Operators

When debugging constructs like metatables and operator overloading, issues can arise
from incorrect metamethod definitions or improper attachment of metatables. To trace
these types of issues, use getmetatable to verify that our objects have the expected
metatable attached.
]]

local DEBUG = true
function debugLog(message)
  if DEBUG then
    print('[DEBUG]',message)
  end
end

local complex = {real=2,imag=3}
local complexMeta = {
  __add = function(a,b)
    return {real=a.real+b.real,imag=a.imag+b.imag}
  end
}

setmetatable(complex,complexMeta)
local mt = getmetatable(complex)

if mt and mt.__add then
  debugLog('Metatable attached correctly with __add operator.')
else
  debugLog('Error: Metatable not set correctly')
end

