-- using lick for livecoding for the first time. Let's see

-- I keep all my 'global' vars as local vars but on the global file scope 🤔🤔🤯
local anim8 = require('lib/anim8')
local lick = require('lib/lick')
lick.reset = true
local player = {}
local background
local sti = require('lib/sti')
local gameMap = sti('maps/testMap.lua')

--  so we start with our  3 main functions always
function love.load()
  -- all variables are created and/or loaded here

  love.graphics.setDefaultFilter('nearest', 'nearest')


  player.x = 400
  player.y = 200
  player.speed = 1
  player.sprite = love.graphics.newImage('sprites/parrot.png')
  player.spriteSheet = love.graphics.newImage('sprites/player-sheet.png')
  player.grid = anim8.newGrid(12, 18, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())

  player.animations = {}
  player.animations.down = anim8.newAnimation(player.grid('1-4', 1), 0.2)
  player.animations.left = anim8.newAnimation(player.grid('1-4', 2), 0.2)
  player.animations.right = anim8.newAnimation(player.grid('1-4', 3), 0.2)
  player.animations.up = anim8.newAnimation(player.grid('1-4', 4), 0.2)

  player.anim = player.animations.left

  background = love.graphics.newImage('sprites/background.png')
end

function love.update(dt)
  -- every frame is run here
  -- Player.x = Player.x + 1  -- the illusion of moving
  -- now let's make love check for something on everything single frame

  local isMoving = false

  if love.keyboard.isDown('right') then
    player.x = player.x + player.speed
    player.anim = player.animations.right
    isMoving = true
  end
  if love.keyboard.isDown('left') then
    player.x = player.x - player.speed
    player.anim = player.animations.left
    isMoving = true
  end
  if love.keyboard.isDown('down') then
    player.y = player.y + player.speed
    player.anim = player.animations.down
    isMoving = true
  end
  if love.keyboard.isDown('up') then
    player.y = player.y - player.speed
    player.anim = player.animations.up
    isMoving = true
  end

  if not isMoving then player.anim:gotoFrame(2) end

  player.anim:update(dt)
end

function love.draw()
  -- everything is drawn here
  -- love.graphics.draw(background, 0, 0)
  gameMap:draw()
  player.anim:draw(player.spriteSheet, player.x, player.y, nil, 6)
end
