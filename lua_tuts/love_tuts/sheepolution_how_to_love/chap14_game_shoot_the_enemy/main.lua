-- here I'll use everything that was discussed in this book so far. the main point of this
-- is to review how to take a large project (game) and divide it into smaller problems to solve.

-- The game will have an enemy bouncing off the walls. We have to shoot it. Each time we shoot it, the
-- enemy goes a litter faster. When we miss it, it's game over and we start again.
-- I'll add some scoring as well for a ladoblanco personal touch

-- local globals
local player, enemy,screen_width,screen_height,score_text,tw,th
-- 3 main call backs

function love.load()
  Object = require 'libs/classic'
  require 'player'
  require 'enemy'
  require 'bullet'

  player = Player()
  enemy = Enemy()
  ListOfBullets = {}
  Font = love.graphics.newFont(30)
  Score = 0
  screen_width = love.graphics.getWidth()
  screen_height = love.graphics.getHeight()
end

function love.update(dt)
  player:update(dt)
  enemy:update(dt)
  score_text = 'Scored '..Score..' Hit(s)!'
  tw = Font:getWidth(score_text)
  th = Font:getHeight(score_text)
  -- iterate through the table to update all the bullets
  for i, v in ipairs(ListOfBullets) do
    v:update(dt)
    -- Each bullet checks if there is collision with the enemy
    v:checkCollision(enemy)
    -- if the bullet has the property dead and it's true then..
    if v.dead then
      -- remove it from the list
      table.remove(ListOfBullets,i)
    end
  end
end

function love.draw()
  player:draw()
  enemy:draw()
  love.graphics.setFont(Font)
  love.graphics.print(score_text,(screen_width/2)-tw/2,screen_height/2-th/2)
  

  -- iterate through the table to draw all the bullets
  for _, v in ipairs(ListOfBullets) do
    v:draw()
  end
end

function love.keypressed(key)
  player:keyPressed(key)
end

-- Summary:

-- A game is essentially a list of problems that need to be solved one at a time.
