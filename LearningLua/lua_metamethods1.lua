--[[
    Metamethods and Metatables
▫️ Just like any other method except tied to a table
▫️ Can override other methods
▫️ Are registered to their parent table with setmetatable

▫️ Start with adding tables, replacing +
    ▫️ Metamethod signature is __add(a,b)
    ▫️ Will be called when a value is added to the parent table using the + operator (like Python???)

]]

-- first I create a metamethod which will take the place of an already established function
-- everytime its associated with the specific tables
local MyMetaMethod_add = function(x,y)
    return {value = x.value+y.value} -- return a table with the value = the addition of the values from the x,y tables
end


local myTable1 = {value = 100}
local myTable2 = {value = 200}
local metaTable = {__add = MyMetaMethod_add} -- create our metaTable
setmetatable(myTable1,metaTable) -- set myTable1 to be associated  with our metatable

local newTable = myTable1 + myTable2 -- now this works. But does it only work with myTable1?
print(newTable.value)
-- local anotherTable = myTable2 + myTable2
-- print(anotherTable.value) -- yeah, this doesn't work