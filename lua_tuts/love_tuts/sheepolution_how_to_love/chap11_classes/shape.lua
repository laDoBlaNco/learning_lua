-- shape.lua
--[[
Inheritance -

With inheritance, we can extend our class. In other words, we make a copy of our blueprint, and add
features to it, without editing original blueprint

Let's say you have a game with monsters. Every monster has their own attack, they move differently.
but they can also get damage, and are able to die. These overlapping features should be put in what
we call a superclass or base class. They provide the features that all monsters have. And then each
monster's class can extend this base class and add their own features to it.

let's create another moving shape, a circle. What will our moving rectangle and circle have in common?
Well they will both move. So let's make a base class for both of our shapes
]]

local Shape = Object:extend() -- the proper way to do this: keeping our vars local and returning what 
-- we want to be used outside of the file.

function Shape:new(x, y)
  self.x = x
  self.y = y
  self.speed = 100
end

function Shape:update(dt)
  self.x = self.x + self.speed * dt
end

return Shape
