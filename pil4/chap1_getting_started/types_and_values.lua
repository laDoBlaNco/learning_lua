--[[

Lua is dynamically typed so there are no type definitions in the language. Remember that
lua is my high level scripting language over C.

In lua, each value caries its own type. There are 8 basic types in lua:
    ▫️ nil
    ▫️ boolean
    ▫️ number
    ▫️ string
    ▫️ userdata
    ▫️ function
    ▫️ thread
    ▫️ table

I can use type() on any value to get one of these 8 types

]]

local x = 66

print(type(nil))
print(type(true))
print(type(10.4*3))
print(type('Hello ladoblanco lua'))
print(type(io.stdin))
print(type(print))
print(type(type))
print(type({}))
print(type(type(x))) -- the result of type is always a string, no matter what 'x' is

-- The userdata type is also a special one. I think of it like a struct in C. It allows
-- arbitrary C data to be stored in lua variables. it has no predefined operations in
-- lua, except assignment and equality test. Userdata are used to represent new types
-- created by an application (like typedef in C 🤔), a program or a library written in C
-- the standard i/o library uses them to represent open files. When I get into the C API
-- I'll learn more deets about that. 

--[[
nil is a type with a single value, nil, whose main property is to be different from any
other value. Lua uses nil as a kind of 'non-value', to represent the absence of a useful
value. This is why a global var is 'nil' before its assignment. Its like an uninitialized
var in C. Its just junk memory. It also tells lua that we don't need it for anything if
we explicitly set a var to nil. 
]]



