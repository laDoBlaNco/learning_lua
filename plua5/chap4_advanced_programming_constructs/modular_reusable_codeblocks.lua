--[[
Creating Modular, Reusable, Code Blocks

So if I combine closures and higher-order functions, then I can build highly modular code
that's resuable and easy to maintain. For example, say I need to create customized greeeting
functions based on different greeting messages. Using closures, I can generate such functions 
dynamically
]]

-- Define a function that returns a custom greeter function
function createGreeter(greeting)
  return function(name)
    return greeting .. ', ' .. name .. '!'
  end
end

-- create two different greeter functions
local sayHello = createGreeter('Hello')
local sayHi = createGreeter('Hi')
print()
print(sayHello('Explorer'))
print(sayHi('Explorer')) print()

-- here the createGreeter function encapsulates the greeting message in the returned closure
-- enabling me to generate multiple cusomized functions that share common logic but maintain
-- separate logic

