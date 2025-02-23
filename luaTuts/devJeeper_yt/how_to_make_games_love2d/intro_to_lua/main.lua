--[[
There are 8 types in lua and we'll focus on the first four:

    ▫️ nil - absence of data, nothing at all. Does not mean 0 or false
    ▫️ boolean - used to store whether something is true or false.
    ▫️ number - used to store numbers, both ints and floats
    ▫️ string - used to store a sequence of chars
    ▫️ function
    ▫️ userdata
    ▫️ thread
    ▫️ table - tables are THE data struture in lua. Lua just needs tables. Its like a variable that contains other variables and/or even tables, etc
        ▫️ Declaring a table is similar to a variable. name_of_table = {}

To declare a variable
    ▫️ you just start typing something followed by an '=' and the data that the variable should store
    ▫️ variable names can't start with a number bu may contain them
    ▫️ Variable names can't contain any symbols, with the exception of '_'
    ▫️ All variables are case sensitive

]]

--[[
local anything = 'cool variable :)'
local AnOtHeRvArIaBlE = true
local canContain1111Numbers = 10
-- 1DoesNotWork = nil

-- we can do math with variables
local salary = 1000
local food = 300
local rent = 400
local investment = 600
local result = salary - (rent + food + investment)
print(result)
--]]

-- Comments are used to leaves ourselves notes
-- this is a single line comment and lua will ignore on this line after the two --
--[[
    this is a multiline comment
    and lua will ignore anything
    that it surrounds.
]]
--[[
OurAwesomeTable = {}
OurAwesomeTable.coolVariable = 10 -- adding a variable to our table
OurAwesomeTable.coolTable = {}

-- we can also do it all at declaration
OurAwesomeTable2 = { coolVariable = 10, coolTable = {} }

-- relational operators supported by lua are: ==, ~=, >, <, >=, <=

-- if statements
local money = 150
if money > 10 and money < 200 then
    print(money)
end
-- lua also uses else and elseif as well

-- functions organize our code and make it resuable.
local function checkWealth()
    if money > 100 and money < 200 then
        print(money)
    elseif money <= 100 then
        print("I'm poor")
    else
        print("Yay, I'm rich!")
    end
end

money = 50
checkWealth()
money = 150
checkWealth()
money = 10000
checkWealth()
--]]

-- now that we know functions we can start with the main stays of lua
function love.load() -- this is wherre we load all of our assets and anything we need for our game

end

function love.update(dt) -- this is where the actual game logic goes. It'll trigger 1 time per computer clock tick
-- this changes depending on the power of the computer. To even this out we use 'dt' (delta time) to ensure its the
-- same across architectures. Delta time is the time it took to produce the frame. So the pixels they move depends
-- on delta time which ensures that they move the same no matter the computer.

end

function love.draw() -- this function does all of the drawing and redrawing of our screen

end

