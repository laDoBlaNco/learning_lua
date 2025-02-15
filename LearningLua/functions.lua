--[[
        Parts of a Function

function name(parameters)
    code block
    return
end

Parameters & return are optional

]]

-- functions can be stored in global, local vars as well as table fields
-- we can do it this way:
local function add_one(num1)
   local result = num1 + 1 -- you have to use 'local' in all scopes otherwise it'll be global
   print(result)
end

-- or assign it to a function directly
local add_two = function()
    local result = 5+3
    local result2 = 42
    return result,result2 -- we can return multiple results like in Go and Odin
end

-- the primary difference is that in this second way 'add_two' can call itself in the
-- function, meaning we can do recursive function algorithms. 

add_one(10)
local temp1,temp2 = add_two()
print(temp1)
print(temp2)



