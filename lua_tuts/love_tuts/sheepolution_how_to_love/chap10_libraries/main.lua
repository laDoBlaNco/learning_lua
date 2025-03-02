--[[
Chaper 10 - Libraries

A library is code that everyone can use to add certain functionality to their project.

Let's try out a lib. I'm going to use the 'tick' by rxi.

]]
-- my local global vars
local tick = require 'tick'
local drawRect = false
local x, y

-- print 'hello there with one arg' -- with one arg functions don't need ()s 🤓
function love.load()
  -- the first arg is a function and the second is the time it takes to call the function
  tick.delay(function() drawRect = true end, 3)
  x, y = 30, 50
end

function love.update(dt)
  tick.update(dt)
end

function love.draw()
  -- if drawRect is true then draw a rectangle
  if drawRect then
    love.graphics.rectangle('fill', 100, 100, 300, 200)
  end

  love.graphics.rectangle('line',x,y,100,100)
end

function love.keypressed(key)
  -- if space is pressed then...
  if key == 'space' then
    -- x and y become a random number between 100 and 500
    x = math.random(100,500)
    y = math.random(100,500)
  end
end

-- here we passed a function as an argument as its just a type of variable in the end.
-- Libraries are code that gives us funtionality. Anyone can make a library, Lua also has built-in
-- libraries (standard libs) which we can call
-- now that we get what libraries are all about we can start using some of love's 'class' libraries
