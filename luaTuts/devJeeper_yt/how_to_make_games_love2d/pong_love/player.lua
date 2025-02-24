Player = {}

function Player:load()
    self.x = 50
    self.y = love.graphics.getHeight() / 2
    self.img = love.graphics.newImage('assets/1.png')
    self.width = self.img:getWidth()
    self.height = self.img:getHeight()
    self.speed = 500 -- moving 500 pixels per second
end

-- a good refactor is to keep functions doing on 1 thing and since our update function is moving
-- and checking boundaries its getting kinda big, we can split it up
function Player:update(dt)
    -- now we call our new function in our update function which always must be here since its being called
    -- in our main file
    self:move(dt)
    self:checkBoundaries()
end

function Player:move(dt)
    if love.keyboard.isDown('w') then
        self.y = self.y - self.speed * dt
    elseif love.keyboard.isDown('s') then
        self.y = self.y + self.speed * dt
    end
end

function Player:checkBoundaries()
    if self.y < 0 then self.y = 0 end
    
    -- to stop it from going off the bottom of the screen, we have to take into consideration the bottom of the paddle and thus
    -- the height of the paddle (player) that's why we add self.height. Then we compare that with 
    -- the love.graphics.getHeight() of the screen to see if we are passed it. 
    if self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
    end
end

function Player:draw()
    love.graphics.draw(self.img,self.x,self.y)
end
