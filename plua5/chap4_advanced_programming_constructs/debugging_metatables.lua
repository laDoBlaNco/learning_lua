-- We first creat a table that will serve as our metatable and then assigniit to another
-- table using setmetatable. metatables can extend or modify default behaviors without
-- changing original table structure.

-- define a table representing a complex number
local complex1 = { real = 3, imag = 4 }
local complex2 = { real = 1, imag = 2 }

-- create a metatable for operator overloading
local complexMeta = {}

-- define the __add metamethod to overload the '+' operator
complexMeta.__add = function(a, b)
  -- a and b are tables representing complex numbers
  return {
    real = a.real + b.real,
    imag = a.imag + b.imag
  }
end

-- then we attach the metatable to both complex numbers
setmetatable(complex1, complexMeta)
setmetatable(complex2, complexMeta)

-- test the addition operator
local resultAdd = complex1 + complex2
print('Result of addition:')
print('Real part:', resultAdd.real)
print('Imag part:', resultAdd.imag)
print()

-- by using setmetatable we assign our metatable to our complex number tables so that lua
-- uses our custom function behavior.

-- define the __sub metamethod to overload the '-' operator

complexMeta.__sub = function(a, b)
  return {
    real = a.real - b.real,
    imag = a.imag - b.imag,
  }
end

-- test the subtraction operator
local resultSub = complex1 - complex2
print('Result of substraction:')
print('Real part:', resultSub.real)
print('Imag part:', resultSub.imag)
print()

-- by adding a new metamethod (.__sub) to our metatable, we enable lua to handle subtraction between
-- tables with our custom logic. We can define similar metamethods for other operators like multiplication
-- (__mul), division (__div), or even more complex operations such as indexing (__index) and new
-- indexing (__newindex)


-- so as seen above we an also customize table indexing behaviors. The __index metamethod is
-- called when you try to access a key that doesn't exist in a table. This is useful for implementing
-- default values or inheritance-like features as we see in other languages that have OOP

-- create a prototype table with default properties
local defaults = { color = 'red', size = 'medium' }

-- define a table for an object without explicit properities
local item = {}

-- set a metatable for 'item' with an __index metamethod
setmetatable(item, { __index = defaults })

-- accessing a non-existent key in 'item' will return the default from defaults
print('Item color:', item.color)
print('Item size:', item.size)

-- So in the above example if a ckey is missing from item, lua will look it up in the defaults
-- table. We can also define the __newindex metamethod to control the behavior when assigning values
-- to keys that do not exist, providing further customization over how your table behaves

-- When doing this its good to follow some best practices:
-- Ensure that our metamethods are clearly defined and that the returned values maintain a consistent
-- structure.
-- Avoid modifying metatables dynamically during critical processes as this may lead to unpredictable
-- behavior.
-- Use clear naming conventions and document our custom behavior so that other devs (or our future self)
-- can understand the intended functionality.


-- Debugging Metatable Behavior
-- metatables can also introduce compelxity to our programs which make debugging a bit of a challenge
-- for that reason its good to think ahead and verify that your tables are all connected correctly. We
-- can print the metatable of a table by using getmetatable. 

print()
local mt = getmetatable(complex1)
if mt then
  print("metatable is set for complex1")
else
  print("No metatable found for complex1")
end