local circle, mouse_x, mouse_y, angle, cos, sin, get_distance, arrow

love.load = function()
  -- create an table called circle
  arrow = {}

  -- give it the properties x,y,radius and speed
  arrow.x = 200
  arrow.y = 200
  arrow.speed = 300
  arrow.angle = 0
  arrow.image = love.graphics.newImage('assets/arrow_right.png')
  arrow.origin_x = arrow.image:getWidth()/2
  arrow.origin_y = arrow.image:getHeight()/2
end

love.update = function(dt)
  -- love.mouse.getPosition returns the x and y position of the cursor
  mouse_x, mouse_y = love.mouse.getPosition()
  arrow.angle = math.atan2(mouse_y - arrow.y, mouse_x - arrow.x)
  cos = math.cos(arrow.angle)
  sin = math.sin(arrow.angle)

  arrow.x = arrow.x + arrow.speed * cos * dt
  arrow.y = arrow.y + arrow.speed * sin * dt
end

love.draw = function()
  love.graphics.draw(arrow.image, arrow.x, arrow.y, arrow.angle,1,1,arrow.origin_x,arrow.origin_y)
  love.graphics.circle('fill', mouse_x, mouse_y, 5)
end

--[[
I remember working with some of these trig functions in JS. But for now I can just focus on the fact
that math.atan has replaced the deprecated math.atan2 and also that getting the angle from an
object to a target = math.atan(target_y - object_y, target_x - object_x). In this case the circle being
our object and the target being our cursor or mouse.

NOTE: math.atan returns the degree in radiians
]]

get_distance = function(x1, y1, x2, y2)
  local horizontal_distance = x1 - x2 -- horizontal side length
  local vertical_distance = y1 - y2   -- vertical side length

  -- both of these work
  local a = horizontal_distance * horizontal_distance -- getting the squares of both sides
  local b = vertical_distance ^ 2

  -- we now sum the squares and then get the squareroot of that
  local c = a + b
  local distance = math.sqrt(c)
  return distance
end

--[[
SUMMARY:

I can make an object move at an angle by getting the cosine and sine of the angle. Next I move with the
x with a speed multiplied by the cosine, and y with the speed multiplied by sine. I can calculate the
distance between two points using the Pythagorean theorem. When using an image, I need to have it point
to the right by default and put its origin at the center so its path isn't off.
]]
