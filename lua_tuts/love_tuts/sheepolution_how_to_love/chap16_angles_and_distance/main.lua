local circle, mouse_x, mouse_y, angle,cos,sin

love.load = function()
  -- create an table called circle
  circle = {}

  -- give it the properties x,y,radius and speed
  circle.x = 100
  circle.y = 100
  circle.radius = 25
  circle.speed = 200
end

love.update = function(dt)
  -- love.mouse.getPosition returns the x and y position of the cursor
  mouse_x, mouse_y = love.mouse.getPosition()
  angle = math.atan(mouse_y - circle.y, mouse_x - circle.x)

  cos = math.cos(angle)
  sin = math.sin(angle)

  -- make the circle move towards the mouse 
  circle.x=circle.x+circle.speed*cos*dt
  circle.y=circle.y+circle.speed*sin*dt
end

love.draw = function()
  -- draw the circle
  love.graphics.circle('line', circle.x, circle.y, circle.radius)
  -- print the angle
  love.graphics.print("angle: " .. angle, 10, 10)

  -- here are some lines to visualize the velocities
  love.graphics.line(circle.x,circle.y,mouse_x,circle.y)
  love.graphics.line(circle.x,circle.y,circle.x,mouse_y)

  -- and the angle
  love.graphics.line(circle.x,circle.y,mouse_x,mouse_y)


end

--[[
I remember working with some of these trig functions in JS. But for now I can just focus on the fact
that math.atan has replaced the deprecated math.atan2 and also that getting the angle from an
object to a target = math.atan(target_y - object_y, target_x - object_x). In this case the circle being
our object and the target being our cursor or mouse.

NOTE: math.atan returns the degree in radiians
]]