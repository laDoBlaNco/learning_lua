--[[
    Using Closures in Lua

▫️ An anony function within another function
▫️ Generally used to return or pass data as a parameter
]]

local function currentCount()
    local i = 0
    return function()
        i=i+1
        return i
    end
end

local first = currentCount()

print(first())
print(first())
print(first())
print(first())
print(first())

