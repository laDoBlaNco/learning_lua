--[[
Learning Lua: Part10 loops

3 main loops in lua available to us:
    1. for loop will repeat a specific number of items
        for counter = n1,nm2,nm3 do
            code
        end
        ▫️ where n1 is the starting number
        ▫️ n2 is ending number
        ▫️ n3 is the step (which can also be negative)

    2. while loops will continue until a condition is met
        while condition do
            code
        end 
        ▫️ if the condition is false, the loop will not execute

    3. repeat loop will continue until a condition is met
        repeat
            code
        until condition 
        ▫️ similar to a do_while loop in other languages, but more of a do..while.. not 🤔
        ▫️ a repeat loop will always execute at least once
]]

-- for loop example:
print('FOR loop example:')
for i = 10, 0, -2 do -- using step. we can also use vars instead of actual numbers
    print("loop: ", i)
end
print()

-- while loop example:
print('WHILE loop example:')
local temp = true
local i = 1

while temp do
    print("loop: ",i)
    i = i + 1
    if i == 10 then
        temp = false
    end
end
print()

-- repeat..until loop example:
print('REPEAT loop example:')
temp = true
i = 1
repeat
    print('repeat loop:',i)
    i = i + 1
    if i == 10 then
        temp = false
    end
until temp == true  -- in this case the condition is already met, but it still runs at least once



