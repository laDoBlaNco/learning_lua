--[[
    Variable Types
▫️ nil       ▫️ table
▫️ number    ▫️ function
▫️ string    ▫️ userdata
▫️ boolean   ▫️ thread

nil - has no value and holds no data. Its the default value of all variables and I
can use it to set a var to be garbage collected

number - ANY numeric value. Lua stores all numbers as double - precision floating-point
(i.e. 'real' numbers) - similar to js

string - a more complex data type. A sequence of chars. Knowing what I know about C and its
underlying double pointer it makes me think that its related. I can use a single or double
quote OR double brackets to delimit a string. must be for multiline strings

boolean - store true or false values. But we aren't limited to just 'true' and 'false'
from the sounds of it anything that's not 'false' or 'nil' is considered 'true'

table - is a the principle data structure in lua. Its an associative array very similar to
php apparently. So we use it as an indexed array as well as an assoc array (dict) depending
on how I declare it. It is heterogeneous so the elements don't have to be of the same type
and again can be indexed by numbers or strings

We'll see examples of the last 3 data types later, but...

function - repeatable programming segments stored in a variable as in all programming 
languages. Since lua can store functions as variables its also a higher-order first class 
language

userdata - used to represent new data types. probably similar to structs in other languages

thread - stores a coroutine instance (i.e. multitask threading) probably like green threads
in Go (goroutines)
]]

local my_variable = nil
print(type(my_variable))
print()

local my_integer = 10
print(my_integer)
print(type(my_integer))
print()

local my_float = 3.14159265
print(my_float)
print(type(my_float))
print()

local my_string = 'Hello'
print(my_string)
print(type(my_string))
print()

-- we can also print multiline as I thought, no quotes necessary entonces
local my_string2 = [[a multiline
string that will be 
a few lines long]]
print(my_string2)
print(type(my_string2))
print()

local my_bool = true
local my_bool2 = false
local my_bool3 = nil -- this prints as nil type since its not technically a bool, but it is 
-- falsy
print(my_bool)
print(type(my_bool))
print(my_bool2)
print(type(my_bool2))
print(my_bool3)
print(type(my_bool3))
print()

local my_array = {'a string',12,42,'14'} -- we call it an array, but its a TABLE 
print(my_array) -- this will give us table information which looks like its the type
-- and maybe its the memory address???
print(my_array[1]) -- in lua arrays are 1-indexed
print(my_array[4])




