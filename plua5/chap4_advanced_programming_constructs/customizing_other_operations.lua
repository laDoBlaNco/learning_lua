-- We first creat a table that will serve as our metatable and then assigniit to another
-- table using setmetatable. metatables can extend or modify default behaviors without 
-- changing original table structure.

-- define a table representing a complex number
local complex1 = {real = 3, imag = 4}
local complex2 = {real = 1, imag = 2}

-- create a metatable for operator overloading
local complexMeta = {}

-- define the __add metamethod to overload the '+' operator 
complexMeta.__add = function(a,b)
  -- a and b are tables representing complex numbers
  return{
    real = a.real + b.real,
    imag = a.imag + b.imag
  }
end

-- then we attach the metatable to both complex numbers
setmetatable(complex1,complexMeta)
setmetatable(complex2,complexMeta)

-- test the addition operator
local resultAdd = complex1 + complex2
print('Result of addition:')
print('Real part:',resultAdd.real)
print('Imag part:',resultAdd.imag)
print()

-- by using setmetatable we assign our metatable to our complex number tables so that lua
-- uses our custom function behavior. 

-- define the __sub metamethod to overload the '-' operator

complexMeta.__sub = function(a,b)
  return{
    real = a.real - b.real,
    imag = a.imag - b.imag,
  }
end

-- test the subtraction operator
local resultSub = complex1 - complex2
print('Result of substraction:')
print('Real part:',resultSub.real)
print('Imag part:',resultSub.imag)
print()

-- by adding a new metamethod (.__sub) to our metatable, we enable lua to handle subtraction between
-- tables with our custom logic. We can define similar metamethods for other operators like multiplication
-- (__mul), division (__div), or even more complex operations such as indexing (__index) and new 
-- indexing (__newindex)


