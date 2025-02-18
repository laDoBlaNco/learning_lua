--[[
    Objects in Lua
▫️ First, No, Lua is not a true OOP as it doesn't have classes
▫️ in Lua, tables can be treated as objects
    ▫️ tables can have values (like properties)
    ▫️ tables can have functions (like methods)
▫️ To pass the object to a function, use a colon (:) instead of .
]]

local pet = {} -- start with an empty table
    pet.type = "" -- note the indent to following the class definition convention in other languages
    pet.message = 'hungry!'
    pet.hungry = function(jank) print(jank.type .. ' is ' .. pet.message) end -- note a one-liner function. Also 'self' 'self.type' are just syntatic sugar
    pet.points = 0

local dog = pet
dog.type = 'dog'
dog:hungry()
print(dog.points)

-- I think this is similar to some of the other languages that are faking OOP like Python or maybe Ruby
-- where self could be anything, its just convention to use the word self. I changed it
-- to 'jank' above and it works the same. Just need to make sure that whatever is used
-- in the function param is use when we call the parameters later. Kinda the same
-- as Go and its associated functions in structs. Also trying to represent something
-- it ain't 

-- can we have more than one 'instance' if dog is pointing to the pet {} table? Hey answered
-- my question which is when using this method, no we can't. We would need to crete a new
-- table for each 'instance'
-- That's where 'metamethods come into play.'
print(pet.type) -- see, our original table is not set to dog as well. JUST A POINTER