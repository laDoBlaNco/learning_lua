--[[
    IMPORTANT THING

    ▫️ Is it passed by value
    ▫️ or is it passed by reference

Primitive variables are passed by value (copy). As I learned in my C memory management class, typically anything
that is less than or equal to a word size (4 or 8 bytes = 32 or 64 bits) is passed by copy or value

    ▫️ strings - typically just pointers to chars and pointers are word-size
    ▫️ numbers
    ▫️ booleans

Passed by reference (or pointer)
    ▫️ tables

]]

--[[
print('Passed by Value (copy) Example:')
print('nothing changes...passed by copy')
local health = 5

local function doubleNumber(number)
    number = number * 2
    return number
end

doubleNumber(health)
print(health) --> nothing changes
print()
print('returning the copy and assigning it to the original')
health = doubleNumber(health)
print(health)

-- to change the value we'd have to return and assign to the original value

print()print()
print('Passed by Reference (pointer) Example:')
print('the data in the table is mutated...tables are passed by reference or pointer to the same memory address')
print()
-- In lua, tables are passed by reference. Similar to  arrays in languages like C and Go
local greatFood = {'Kebab','Falafel','Hamburger'}
local copy = greatFood

local function morePizza(target)
    target[1] = 'Pizza'
end

print('original table:')
for i,v in ipairs(copy) do
    print(v)
end
print()
morePizza(greatFood)

print("copy after morePizza'd:")
for i,v in ipairs(copy) do
    print(v)
end
print()
print("greatFood after morePizza'd:")
for i,v in ipairs(greatFood) do
    print(v)
end
print()print()
print('Now what if we change the original table to a  new table???🤔')
greatFood = {1,2,3}
print("Our copy now:")
for i,v in ipairs(copy) do
    print(v)
end
print()
print("Our greatFood now:")
for i,v in ipairs(greatFood) do
    print(v)
end

-- The reason for this behavior is because calling the {} in lua calls the table constructor which automatically
-- gets a new memory address. so the original reference is no longer looking at the same table. Its completely
-- different now and just the changes don't effect anything else. 

--]]

-- Now what about if we actually want a copy and not a reference of a table. Then it depends if we need a
--  ▫️ shallow copy or a 
--  ▫️ deep copy

-- Shallow copy - meaning it only have primitive variables and no other tables then we can just loop through it
local myFavoriteYoutubers = {'Dev Jeeper','Nobody Else'}
local coolPeople = {}

for k,v in pairs(myFavoriteYoutubers) do
    coolPeople[k] = v
end
for k,v in pairs(coolPeople) do
    print(k..'==>'..v)
end

-- but if we have a table with nested tables then we need a deep copy:
myFavoriteYoutubers = {'Dev Jeeper',{'kebab','falafel'}}

-- the simplelist way that works with most use cases, is to pass the table to table.unpack inside the new table
local copy = {table.unpack(myFavoriteYoutubers)}

-- the second item will be another table showing as a memory address
print()
for k,v in pairs(copy) do
    print(k,'==>',v)
end

-- we can easily put that into a helper function
local function tableCopy(arg)
    return {table.unpack(arg)} 
end

local copy2 = tableCopy(myFavoriteYoutubers)
print()
for k,v in pairs(copy2) do
    print(k,'==>',v)
end





