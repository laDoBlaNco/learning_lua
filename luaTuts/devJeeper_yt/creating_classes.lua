--[[
    Technically Lua doesn't have OOP but due to its simplicity we can simulate it fairly easy
    Without it, we would need to create a table for every single asset in our game or program

    But with the patterns learned in the 'self' video we can start to create our lua OOP version

]]

Animal = {}
-- so now instead of creating this extra connection below
-- MetaAnimal = {} 
-- in our metaanimal table we set  an '__index' and that connects our MetaAnimal to our Animal 'class'
-- MetaAnimal.__index = Animal -- this index tells lua where to look for a function or variable if it can't find it in its own table.
-- we an now use our MetaAnimal table to connect any other table to our Animal table.

-- we just make Animal our metatable pointing to itself
Animal.__index = Animal -- NOTE this is the key then. Here we are creating an index back to animal and then our instance is 
-- setmetatabled directly to animal which points back to itself for any functions not in the instance.
-- to create instances we need to create a function on Animal to handle that
-- I use the dot syntax so that its clear that this is not a function for instances but for the 'class' table itself
-- in other langs this would be equivalent to a static method
--[[ removing the constructor for our animal 'class'
function Animal.new(name)
    -- then we use our setmetatable from the previous lesson to make the connection
    -- as we did before
    local instance = setmetatable({},Animal) -- remember this connects the table in the first arg to the metatable in the second
    instance.name = name
    return instance
end
--]]

function Animal:displayName() -- here we use the : to show that this is a method to be called on the instance using self
    print(self.name)
end

-- local animal1 = Animal.new('Dave')
-- local animal2 = Animal.new('Charlie')
-- local animal3 = Animal.new('Max')

-- animal1:displayName()
-- animal2:displayName()
-- animal3:displayName()

-- But there is a smoother and cleaner way to do this. The step of creating MetaAnimal and 
-- pointing pointing our instance to it with setmetatable shows us what's happening
-- but its not needed. We can just assigning __index off of animal and point to itself
-- we get the same result, but its much cleaner now that I know what's going on
-- underneath

-- we can also build onto this with inheritance rather than copying all the functions to each table
-- so we need to make our base 'class' abstract or remove the ability to create instances from it.
-- so we remove the constructor function for animal

-- Then we can create a new abstract class to inherit from Animal
Fish = {}
Fish.__index = Fish
-- to get Fish to inherit from Animal we simply connect them
-- setting its metatable to Animal
setmetatable(Fish,Animal)
function Fish:displayName(name)
    print('Blub '..self.name..' blub') -- now this overshadows (overrides) the method in Animal of the same name.
end

-- now if we create a table to inherit from Fish and in turn Animal
RedHerring = {}
RedHerring.__index = RedHerring
setmetatable(RedHerring,Fish)

-- we create a constructor for the class (not abstract) that we want an instance of
function RedHerring.new(name)
    local instance = setmetatable({},RedHerring)
    instance.name = name
    return instance
end

local rh1 = RedHerring.new('Odalis')
rh1:displayName() -- this checked its on table (RedHerring) for the function then it checked its metatable (Fish) and 
-- not finding it there it then check its metatable's metatable (Animal) and found the method.
-- rh1 --> Fish --> Animal

-- understanding this chain allows us to OVERSHADOW functions (when a variable or function which is more local gets preference)
-- which is the epitomy of overriding methods in OOP

