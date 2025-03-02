-- rectangle.lua

-- could name our variable anything we want here, but it's nice to keep a consitent naming
local Shape = require 'shape'
local Circle = Shape:extend()

function Circle:new(x, y, radius)
  Circle.super.new(self, x, y)
  -- a circle doesn't have a width or a height. It has a radius
  self.radius = radius
end

function Circle:draw()
  love.graphics.circle('line', self.x, self.y, self.radius)
end

-- and again then we return it

return Circle
