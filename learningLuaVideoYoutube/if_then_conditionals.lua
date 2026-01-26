--[[
Learning Lua - part9: if-then

The if-then structure in lua works as expected really:
    ▫️ Used to handle decision or multiple decision situations in lua
        if comparison then
            code
        end
    
    ▫️ Comparison operators pretty normal except for a one of them:
        ▫️ and   or  not
        ▫️ > <
        ▫️ >=    <=  ~= (this is not equals)     ==


]]

local count = 0

if count == 1 then
    print("Equal if-then structure")
end

if count <= 1 then
    print("Less than or equal if-then structure")
end

if count >= 1 then
    print("Greater than or equal if-then structure")
end

if count ~= 1 then
    print("Not equal if-then structure")
end

-- Then we have examples of using our logical operators (and or not) which are 
-- pretty simply
count = 1
local answer = 'yes'
local lives = 0

if count == 1 and answer == 'yes' then
    print("if-then using and")
end

if count == 1 or answer == 'no' then
    print('if-then using or')
end

if not (count == 0) then -- you have to use () for the precedence better to be sure
    print('if-then using not')
end

if count == 1 and (answer == 'no' or lives == 0) then -- same here with the precedence USE ()S
    print('if-then complex comparison')
end

--[[
We extend the if-then with else, allowing us to do something else when the condition
is not met. Pretty much as expected just with different syntax

if comparison then
    code
else
    other code
end

]]
count = 0

if count == 1 then
    print('Equal if-then structure count = 1')
else
    print('if-then else, count ~= 1')
end

--[[
Nesting Ifs

we also have nested ifs in lua as normal 
if-then commands can in fact be nested 

if comparison then
    if comparison2 then
        code
    end

    optional code
end
]]

if count == 0 then
    if answer == 'yes' then
        print('Nested if-then answer equals yes')
    end
else
    if answer == 'no' then
        print('Nested if, count ~= 0, answer equals no')
    end
end

--[[
Final part of this structure is the elseif, again as expected really

Same as else followed by if, but avoids the use of multiple end uses
Lua doesn't have a select (switch) statement so we typically use this in lua 

if comparison then
    code
elseif condition then
    code
end

]]

count = 4

if count == 0 then
    print("if-then count equals 0")
elseif count == 1 then
    print("elseif, count = 1")
elseif count == 2 then
    print("elseif, count = 2")
else
    print("else, count not equal to 0, 1, or 2")
end


