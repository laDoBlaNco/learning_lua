--[[
so in the previous chapter we used tables as numbered lists, but we can also store values
in different ways. With strings for example
]]
local lick = require('../lick')
lick.reset = true
-- again here are my global (to this file) vars declared to nil
function love.load()
  ListOfRectangles = {}
end

function love.update(dt)
  for i, v in ipairs(ListOfRectangles) do
    v.x = v.x + v.speed * dt
  end
end

-- now that we have 'properties' we can draw our rectangle
function love.draw()
  for i, v in ipairs(ListOfRectangles) do
    love.graphics.rectangle('line', v.x, v.y, v.width, v.height)
  end
end

--[[
so now we have a moving rectangle but to to show the power of tables I can create multiple moving
rectangles. For this I'm going to use a table as a list



]]

local function createRect()
  local rect = {}
  rect.x = 100
  rect.y = 100
  rect.width = 70
  rect.height = 90
  rect.speed = 100

  -- put the new rectangle in the list
  table.insert(ListOfRectangles, rect)
end

function love.keypressed(key)
  -- remember 2 equal signs for comparing
  if key == 'space' then
    createRect()
  end
end

--[[
One more time?

That was a lot of code in a rather short burst. So just in summary:
  ▫️ in love.load i created a table called ListOfRectangles
  ▫️ When I press 'space' LOVE calls love.keypressed and inside that function I check if the pressed
    key is 'space'. If so then I call the function createRect
  ▫️ In createRect I crete a new table. I give this table proeperties like x and y, and I store this
    new table inside of the list ListOfRectangles
  ▫️ In love.update and love.draw I iterator through this list of rectangles to update and draw each one


Functions:
An object (table) can also have functions as keys or properties:
  tableName.funtionName = funtion()

  end

Or the more common way:
  function tableName.functionName()
  end

So in summary I can store values in tables not only with numbers but also with strings. I call these
types of tables 'objects'. Having objects saves us time from creating a lot of variables. Oh, seems like
OOP to me.

]]
