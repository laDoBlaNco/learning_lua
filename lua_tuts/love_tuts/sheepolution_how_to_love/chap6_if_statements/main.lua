--[[
Chapter 6 - If Statements

With if statements we can allow pieces of code to only be executed when a condition
is met.

]]

function love.load()
  X = 100
  Y = 50
  -- Move = true
end

function love.update(dt)
  -- if Move then -- now it only moves to a certain point and stops
  --   X = X + 100 * dt
  -- end
  -- knowing what we know about if statements we can now put more control in the movement
  -- if love.keyboard.isDown('right') then
  --   X = X + 100 * dt
  -- else -- we can also add some other things if we aren't pushing the arrow key
  --   X = X - 100 * dt
  -- end

  -- or we can use elseif to check all the arrow keys
  if love.keyboard.isDown('right') then
    X = X + 100 * dt
  elseif love.keyboard.isDown('left') then
    X = X - 100 * dt
  elseif love.keyboard.isDown('up') then
    Y = Y - 100 * dt
  elseif love.keyboard.isDown('down') then
    Y = Y + 100 * dt
  end
end

function love.draw()
  love.graphics.rectangle('line', X, Y, 200, 150)
end

--[[
Summary

With if-statements we can allow pieces of code to only be executed when a condition is met. We can
check if a number is higher, lower or equal to another number/value. A variable can be true or false
This type of variable is what we call a boolean. We can use else to tell our game what to execute
when the statement was false or elseif to another check.
]]
