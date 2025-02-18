--[[
    Learning Lua: Passing Parameters & Arguments

▫️ A parameter is a variable in a funtion's definition:
    ▫️ local function sampleFunction(myParameter)
▫️ An argument is the actual data that is passed to the parameter

]]

local myMod = require('myModule')
print(myMod.hi('Lado'))

local temp = myMod.hi('Lado')
print(temp)
print(myMod.twofer(1, 2, 3)) -- again here we get 4 results

local a, b, c, d = myMod.twofer(1, 2, 3)
print(a)
print(b)
print(c)
print(d)
print()
print()

local function tablePass(p1)
    table.sort(p1)
    return p1
end

local function showTable(p2)
    for k, v in pairs(p2) do
        print(k, v)
    end
end

local myTable = { 1, 2, 5, 3, 7, 9, 1 }
showTable(myTable)
print()
local myNewTable = tablePass(myTable)
print("Table after sort:")
showTable(myTable)
print()
print('My new table:')
showTable(myNewTable)
print()print()
-- when tables are passded to functions they are pased by reference or by pointer
-- this is interesting and seen in th results. We sort myTable but myNewTable is also sorted.
-- so its a pointer (C) that is passed to the function. This is similar behavior
-- in both C and Go. Rather than copying these structures that are larger than
-- a word size (4 or 8 bytes) which is what can be pushed through the data bus,
-- a pointer is used.

-- One other item in lua that is really cool is the lua version of the spread
-- operator for no limit params
local function myAddition(...)
    local sum = 0
    for i,v in ipairs{...} do -- this must be {} instead of () for ... for some reason 🤔
        sum = sum + v
    end
    return sum
end
print(myAddition(1,2,3,1,4,5))
print(myAddition(1,2))