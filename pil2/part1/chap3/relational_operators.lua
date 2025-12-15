--[[
3.2  Relational Operators

Again lua provides all the expected (< > <= >= ==)
and one not so normal (~=) not equal

All result in true or false
]]

local a = {}
a.x = 1
a.y = 0
local b = {}
b.x = 1
b.y = 0
local c = a

print(a == c)
print(a ~= b)
print()

print("acai" < "acorde")
print("acoi" < "aca") -- false. its not the size that counts
