--[[
3.4 - CONCATENATION

lua does concatenation with '..' When working with numbers there must be 
spaces so it doesn't think its a decimal
]]

print('Hello '..'World')

print(0 .. 1)

-- strings in lua are immutable so concatentation creates a new string 
local a = 'Hello'
print(a .. ' World') --> Hello World
print(a) --> still 'Hello'
print()



