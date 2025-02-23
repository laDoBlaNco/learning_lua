--[[
    Functions are First Class Objects

in lua, functions are first class citizens (objects) and actually all functions in lua are anony functions under the hood.

What does that mean?

    ▫️ First this notation is just syntactic sugar:
        function helloWorld()
            print("hello world")
        end

        In reality what's happening under hood is always this:
        helloWorld = function()
            print('Hello world')
        end

    ▫️ since functions are first class objects we can use them just like any other primitive value (stings, numbers, bools, etc)
        ▫️ Any variable in lua has a left-side (of the =) and a right-side. Either side can be
            ▫️ passed in as a function arg
            ▫️ assigned to another variable
            ▫️ returned from a function
            ▫️ used as the key in a table

            All of these things apply to functions in the exact same way.
]]

--[[ ADD ANOTHER '-' HERE TO ACTIVATE ADDITIONAL EXAMPLES BELOW
-- assigning right or left value to a variable:
local helloWorld = function() -- right value
    print('hello world')
end

local hell0 = helloWorld -- left value

-- passing functions as arguments (left or right side)
local function talk(sentence) -- function taking a function as an arg and calling it
    sentence()
end

talk(helloWorld) -- calling it with the function argument -- left side
talk(function()  -- calling it with the actual funtion def -- right side
    print('hello world')
end)

-- returning a function from another function with 'return'
local function returningFunc()
    local helloWorld = function()
        print('hello there again')
    end
    return helloWorld
end

local function returningFunc2()
    return function()
        print('and yet again')
    end
end

local test = returningFunc()
local test2 = returningFunc2()
test()
test2()

-- Assigning a function as the key inside of a table which is basically how we imitate methods (lua oop) in lua
Player = {}
Player.hello = function()
    print('and here from a table')
end

Player.hello2 = helloWorld

Player.hello()
Player.hello2()

--[[
Something else we can do understanding all of this is create 'callback (call-after) functions' which are simply:
Any executable code that is passed as an argument to other code (anony function); that other code is expected
to 'call back' the argument at a future  given time.


]]

--]]

--[[
-- Example of a call function a timer
-- first we'll start with a Timer class
local Timer = {}
Timer.__index = Timer
local active = {}

function Timer.add(duration,callback) -- remember using '.' means this is a static method
    local instance = setmetatable({},Timer)
    instance.duration = duration
    instance.callback = callback

    table.insert(active,instance) -- instance is added to another table of active timers
end

function Timer:update(dt) -- using ':' means its an instance method
    if self.duration > 0 then
        self.duration = self.duration - dt

        if self.duration <= 0 then
            self.callback() -- after its decremented if it gets to the end it'll call its 'callback function' before removing itself
            self:remove()
        end
    end
end

function Timer:remove()
    for i,timer in ipairs(active) do
        if self == timer then
            table.remove(active,i)
        end
    end
end

function Timer.updateAll(dt)
    for i,timer in ipairs(active) do
        timer:update(dt) -- we go through all the timers in 'active' and update which decrements them all by 'dt' until they are done and get removed
    end
end

return Timer

--]]

--[[
-- there are built-in functions that use this anony callback feature as well. such as table.sort
local people = {
    { name = 'fred',  score = 5 },
    { name = 'bob',   score = 2 },
    { name = 'kebab', score = 7 },
    { name = 'william', score = 3 },
}

print('Before: ')

for i, person in ipairs(people) do
    print(person.name,'==>', person.score)
end

print()
print()

table.sort(people,function(a,b)
    return a.score > b.score
end)
print('After: ')

for i, person in ipairs(people) do
    print(person.name,'==>', person.score)
end
--]]


---[[ Self Invoking Functions. I remember this while studying JS. It was the coolest thing I had seen that time 🤯🤯🤯 IIF in JS (Immediately Invoked Functions)
local function sayHello(time)
    if time == 'morning' then
        return function()
            print('good morning')
        end
    elseif time == 'day' then
        return function()
            print('Good day!')
        end
    elseif time == 'night' then
        return function()
            print('Good night!')
        end
    end
end

-- local hello = sayHello('day')() -- getting the function and calling it. When doing doing this we don't even need to assign it to a var
sayHello('day')() -- getting the function and calling it. When doing doing this we don't even need to assign it to a var

--]]