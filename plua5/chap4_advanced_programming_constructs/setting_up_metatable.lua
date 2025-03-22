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

local result = complex1 + complex2

print('New result:',result.real,result.imag)