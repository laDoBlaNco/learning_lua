--[[
    Modules

▫️ A module is a library that can be loaded using the require method
▫️ Modules are a single table that can be returned to the calling program
▫️ the .lua extension is assumed when loading a module, that's why I was getting confused with
  using dofile and -l with the lua interpreter
▫️ A package is a collection of modules. A lot of the same terminology from Go

]]

local myMod = require('myModule')  -- this is one way to import a lua module.
print(myMod.hi('ladoblanco'))
print(myMod.add(1,5))
print()print()

-- another approach is just to require it and not set it as a variable
require('myModule') -- then we have to use the original table name
print(Sample.hi('Odalis'))
print(Sample.add(65,3))

