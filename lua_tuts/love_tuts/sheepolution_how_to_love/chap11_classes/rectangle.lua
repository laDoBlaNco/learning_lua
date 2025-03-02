-- rectangle.lua

-- could name our variable anything we want here, but it's nice to keep a consitent naming
local Shape = require 'shape'
local Rectangle = Shape:extend()

function Rectangle:new(x,y,width,height)
  Rectangle.super.new(self,x,y)
  self.width = width
  self.height = height
end

function Rectangle:draw()
  love.graphics.rectangle('line',self.x,self.y,self.width,self.height)
end

-- and again then we return it

return Rectangle