--[[
        Pairs & IPairs

▫️ Generic for loops
    ▫️ used to work with tables
    ▫️ ipairs for ordered tables
    ▫️ pairs for unordered (or multi-dimensional) tables

▫️ Terms: key & value
    ▫️ tables have a key (or index) and each key has a value
    ▫️ seems similar  to the PHP structure of arrays and assoc arrays being the same

]]

local myTable = {'Hi','Hello','World',42,'inconceivalbe!'}

for index,value in ipairs(myTable) do
    print(index,'=>',value)
end
print()print()

local myTable2 = {'Name','Age','Seat','Grade','Date'} -- this turns into the first dimension and using table.Name sets a second dimension
myTable2.Name = 'ladoblanco'
myTable2.Age = 48
myTable2.Seat = 'B12'
myTable2.Grade = 11
myTable2.Date = 'Dec 25, 1976'
print(#myTable2) -- the # only gives us the length of the first dimension stored.
for k,v in pairs(myTable2) do -- runs through the first dimension and then the second 
    print(k .. ': ' .. v)
end

