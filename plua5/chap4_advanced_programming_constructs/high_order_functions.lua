--[[
Highter_Order Functions:

Lua treats functions as first-class citizens, which means that I can pass functions as arguments,
return them from other functions, or store them in variables. This ability allows me to build 
higher-order functions that operate on other functions. A common pattern is to create a function
that modifies the behavior of another function

]]

-- define a higher-order function for logging

function withLogging(func)
  return function(...)
    local args = {...} -- put the args in a table
    print('Calling function with arguments:', table.concat(args,', '))
    local result = func(...)
    print('Function returned:',result)
    return result
  end
end

-- define a simple function to add two numbers
function add(a,b)
  return a+b
end

-- wrap the 'add' function with logging
local loggedAdd = withLogging(add) -- when we say 'wrapping' its basically sticking our newly made
-- function inside of our previous func as an arg
print()
print(add(10,20)) print()
print(loggedAdd(10,20)) print()
print(add(10,20)) print()

-- This illustrates how higher-order functions can add behavior to already existing functions without
-- modifying them directly. they still work as they did before.