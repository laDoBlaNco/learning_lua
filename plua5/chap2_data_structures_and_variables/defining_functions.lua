-- defining_functions.lua

-- a function is declared either by using function and then the name and its data list
-- or by what is happening under the hood, createing the varible and giving it the value of the
-- anony function and its arg list.
function greet(name)
  return 'Hello, ' .. name .. '!'
end

-- call the function and print its result
print(greet('Explorer'))

