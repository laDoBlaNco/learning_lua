--[[
    Multiple Inheritance
a single class with 2 or more parents (or metatables indexed)

]]

-- a couple of abstract classes cuz they have no way to create an instance, though they do have
-- 'methods'
Human = {}
Human.__index = Human
function Human:run()
    self.x = self.x + 10
end

Mage = {}
Mage.__index = Mage
function Mage:teleport()
    self.x = self.x + 100
end
function Mage:run()
    self.x = 0
end

-- in order for our player to inherit from both of these parents we need a function that will create
-- a metatable with both of these tables inside to point our Player to
function SearchParents(key, parents)
    for i = 1, #parents do
        local found = parents[i][key]
        if found then
            return found
        end
    end
end

function RegisterParents(parents)
    return {
        -- in our table we'll create indexes, but that point to an anony function rather than another table
        -- Anony functions are just like normal functions, except they do nto have a name. Though technically
        -- speaking ALL lua functions are anonymous since none of them have names:
        -- 'function hello() end' is just syntatic sure for 'hello = function() end' 🤯🤯🤯 so simple its confusing

        -- this function will take a self and a key. thought we won't need to use self, but when a table is unable to
        -- to find a key it will pass ITSELF and the key. So to get the key we'll need to catch the SELF
        __index = function(self, key)
            return SearchParents(key, parents)
        end
    }
end

Player = {}
Player.__index = Player
-- Player.parents = RegisterParents({Human,Mage}) -- the parents that I wish player to inherit which will trigger the search parents for key, etc
Player.parents = RegisterParents({Mage,Human}) -- switching the order
-- then set the metatable has we have been all along
setmetatable(Player,Player.parents)

function Player.new()
    local instance = setmetatable({}, Player)
    instance.x = 0
    return instance
end

function Player:printPosition()
    print(self.x)
end

local bruh = Player.new()
bruh:printPosition()
bruh:run()
bruh:printPosition()
bruh:teleport()
bruh:printPosition()

-- so if both parents have the same key then the order of the tables matters based on the
-- we are searching them. If I chamge the order than we get something else
-- so by switching the order above and adding another 'run' method, we get a different result
-- because we hit mage:run before human:run this time

-- So this proves to us the risk of using too much inheritance. Such as the diamond problem.

