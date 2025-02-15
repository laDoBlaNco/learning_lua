-- apparently globals should start with capital laters. If its all lowercase it should have
-- 'local'
local my_string = 'hello'
print(#my_string) -- '#' is the length operator

local my_other_string = ' world'
print(my_string .. my_other_string) -- '..' is the concat operator similar to '.' in php

-- lua also has 'to_string' builtin to the print function so we don't have to convert explicitly
local my_number = 42
local my_string_number = tostring(my_number)
print(my_string_number)
print()

-- as I learned before
local my_first_string = 'Hi mom'
local my_second_string = "Hi dad"
local my_third_string = [[and here
a multi-line
string]]
print(my_first_string)
print(my_second_string)
print(my_third_string)

-- we also have the ability to assign multiple vars on one line
local mya, myb,myc = 'hi', 'hello'
print()
print(mya,myb,myc) -- if an assignment is left out like above, then the extra var is assigned
-- nil
print()

--[[
    As in other languages we also have lua's escapae sequences
        ▫️ \a - bell
        ▫️ \b - backspace
        ▫️ \f - form feed
        ▫️ \n - newline
        ▫️ \r - carriage return
        ▫️ \t - horizontal tab
        ▫️ \v - vertial tab 🤯🤯
        ▫️ \\ - backslash
        ▫️ \" - double quote  
        ▫️ \' - single quote 
]]

local my_newline = 'This is a string\n\v\twith a \"newline\"'
print(my_newline)


