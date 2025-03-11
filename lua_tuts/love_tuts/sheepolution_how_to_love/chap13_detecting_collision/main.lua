local r1, r2

function love.load()
  r1 = {
    x = 10,
    y = 100,
    width = 100,
    height = 100,
  }
  r2 = {
    x = 250,
    y = 120,
    width = 150,
    height = 120,
  }
end

local check_collision = function(a,b)
  -- I do this so I don't have to worry about the a.x+a.width, etc later
  local a_left = a.x
  local a_right = a.x+a.width
  local a_top = a.y
  local a_bottom = a.y+a.height

  local b_left = b.x
  local b_right = b.x+b.width
  local b_top = b.y
  local b_bottom = b.y+b.height

  -- -- now we can put our sides to work
  -- if a_right > b_left
  -- and a_left < b_right
  -- and a_bottom > b_top
  -- and a_top < b_bottom then
  --   return true
  -- else
  --   -- if any of the above is false then return false
  --   return false
  -- end

  -- since the return value is a bool, we can simplify the above just returning the bool
  -- from the condition itself
  return a_right > b_left and a_left < b_right and a_bottom > b_top and a_top < b_bottom
end

function love.update(dt)
  -- make one of the rectangles move
  r1.x = r1.x + 100 * dt
end

function love.draw()
  local mode
  if check_collision(r1,r2) then
    mode = 'fill'
  else
    mode='line'
  end

  love.graphics.rectangle(mode,r1.x,r1.y,r1.width,r1.height)
  love.graphics.rectangle(mode,r2.x,r2.y,r2.width,r2.height)
end

-- now we create a new function call checkCollision(), with 2 rectangles as parameters

--[[ 
Summary: 

for aabb collisition detection I basically need to check the all sides of my rectangle to ensure
none of them are overlapping.

if I have a rectangle a and b, then all of the following must be true:
  ▫️ the right side of a must be larger than the left side of b
  ▫️ the left side of a must be less than the right side of b
  ▫️ the bottom side of a must be greater than the top side of b
  ▫️ the top side of a must be less than the bottom side of b
if any of these are false than there is no collision. The combination of >, < ensures that I'm
checking not only did the sides overlap but that the opposite side is still on top of the rectangle
and it didn't just completely cross over 
]]


