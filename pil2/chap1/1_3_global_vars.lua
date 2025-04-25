--[[
1.3 GLOBAL VARIABLES

Global vars don't need any type of declaration (like local). I just simply assign a value to a 
global var to create it. it isn't an error to access a non-initialized var; I just get the
special 'nil' value as the result

]]
print()
print(b)
b = 10
print(b)

--[[
Usually I don't need to delete global variables, if I'm programming correclty, but if I do
I can just assign 'nil' to it
]]
b = nil
print(b)

--[[
After assignment of nil, lua behaves as if the variable had never been used. In other words
a global var is 'existant' if (and only if) it ahs a non-nil value.
]]