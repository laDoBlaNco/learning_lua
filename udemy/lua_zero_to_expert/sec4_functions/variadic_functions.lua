--[[
Variadic Functions:

A function can be variadic, that is, it can take a variable number of args.

We do this with the spread operator
]]

add = function(...)
  local s = 0
  for _,v in ipairs {...} do -- no ()s for iparis since it takes a single table 
    s=s+v
  end
  return s
end

print(add(1,2,3,4,5,6,7,8,9,10))

--[[
In lua, the ipairs iterator function returns two values during each iteration: the index
and the corresponding value of a table. It is used to traverse arrays or tables with 
consecutive integer keys starting at 1. 
]]
print()

local myTable = {10,20,30}
for index,value in ipairs(myTable) do
  print(index,value)
end

for i,v in next, myTable do
  print(i,v)
end
-- so I can use both pairs and ipairs on an array table, but only pairs on an associative array table
-- or record.
