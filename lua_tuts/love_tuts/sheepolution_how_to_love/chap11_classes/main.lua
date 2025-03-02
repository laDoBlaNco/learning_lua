-- classes are like blueprints. We can build multiple houses with one blueprint and similarly,
-- we can build multiple objects (instances) with one class (really just a table in lua) 🤓🤯
-- we are going to use a library 'classic' for some syntatic sweetness

-- any local globals
local r1
local r2

function love.load()
  Object = require 'classic'
  local Rectangle = require 'rectangle'
  local Circle = require 'circle'
  r1 = Rectangle(100,100,200,50)
  r2 = Circle(350,80,40)
end

function love.update(dt)
  Object = require 'classic'
  local Rectangle = require 'rectangle'
  local Circle = require 'circle'
  if r1 ~= nil then r1:update(dt) end
  if r2 ~= nil then r2:update(dt) end
end


function love.draw()
  if r1 ~= nil then r1:draw() end
  if r2 ~= nil then r2:draw() end
end

-- This local and return stuff might seem like a lot of extra work, but my code will be much cleaner 
-- Imagine if I had to create a game with a global score variable, but in my game it also as a minigame
-- with its own score system. By accident i could override the global score var and I end up confused
-- why my score isn't working propertly. Globals can still be used, but use them sparingly.

--[[
Classes are like blueprints. We can create multiple objects our of 1 class. I don't like how it was done
in this tutuorial as the real lua way was hidden behind other syntax from libraries created to make it 
feel like other languages. The simplicity of lua is understanding how lua handls things not trying to
change it into something its now. 🤬 me no like!

To simulate classes we use the library classic. We created a class with ClassName = Object:extend(). We
created an instance of a class with instanceName = ClassName(). This will call the function ClassName:new().
This is called the construtor. Every function of a class should start with the parameter self so that when
calling the function we can pass the instance as first argument. instanceName.functionName(instanceName)
We can use colons(:) to make lua do this for us. 

We can extend a class with ExtensionName = ClassName:extend(). This makes ExtensionName a copy of ClassName
that we an add properties to without editing ClassName. if we give ExtensionName a function that ClassName
already has, we can still call the original function with ExtensionName.super.functionName(self)

finally by using local vars, our code will be much cleaner and easier to maintain.

]]
