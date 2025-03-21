-- In addition to passing functions as args we can also learn that functions can return
-- other functions. This is great for creating closures or factory functions

-- define a function that returns another function
function makeGreeter(greeting)
  return function(name)
    return greeting .. ', ' .. name .. '!'
  end
end

-- create a specific greeter function and use it
sayHello = makeGreeter('Hello')
print()
print(sayHello('Lua Explorer'))

-- create another greeter with a different greeting 
sayHi = makeGreeter('Hi')
print(sayHi('Explorer'))
