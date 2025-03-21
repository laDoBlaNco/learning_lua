-- functions_as_first_class_values.lua

-- assign a funtion to a varible, which is actually what happens under the hood 
-- when we create functions
adder = function(a,b)
  return a + b
end

-- use the function stored in the variable
result = adder(15,25)
print()
print('Result of addition:',result)