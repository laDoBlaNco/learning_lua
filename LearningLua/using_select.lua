--[[
        Select command in Lua is very specific
    ▫️ used to return values from a series of other values
        ▫️ can be any lua variable types
    ▫️ One use would be adding a series a numbers
    

]]

print(select('#',1,2,3,4,5))

local num1 = 1
local num2 = 2
local num3 = 3
local num4 = 4

local sum = 0
local function add(results)
    for i=1,select('#',num1,num2,num3,num4) do 
        sum = sum + select(i,num1,num2,num3,num4)
        print(sum)
    end
    return sum
end

print(add())

-- so this is kind of an accumulator or a reduce function for lua

