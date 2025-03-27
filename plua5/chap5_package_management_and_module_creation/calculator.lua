--[[
Designing a Custom Module -- 
Now to learn designing my own custom module, I'll try to learn through one of the previous sample
programs. A simple calculator that performs basic operations. I'll encapsulate 

]]

-- calculator.lua
local calculator = {}
function calculator.add(a,b)
  return a + b
end
function calculator.subtract(a,b)
  return a-b
end
function calculator.multiply(a,b)
  return a*b
end
function calculator.divide(a,b)
  if b== 0 then return nil,'Division by zero error' end
  return a/b
end

return calculator

-- returning the calculator at the end allows other file to load the module using require
