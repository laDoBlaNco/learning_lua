Ball = {}

function Ball:load()
    self.x      = love.graphics.getWidth() / 2
    self.y      = love.graphics.getHeight() / 2
    self.img    = love.graphics.newImage('assets/ball.png')
    self.width  = self.img:getWidth()
    self.height = self.img:getHeight()
    self.speed  = 200
    self.xVel   = -self.speed
    self.yVel   = 0
end

function Ball:update(dt)
    self:move(dt)
    self:collide()
end

function Ball:move(dt)
    self.x = self.x + self.xVel * dt
    self.y = self.y + self.yVel * dt
end

function Ball:draw()
    love.graphics.draw(self.img, self.x, self.y)
end

--[[
Now we need collision detection. There are many ways to do this but since
we are working with rectangles we can use what's call aabb collision detection (basically hit boxes)
we need to see if the opposite sides of two rectangles overlap. so top of one and bottom of another
or left of one with the right of another. We then need to know how to get those positions

    ▫️ left is simply x
    ▫️ Right is x + width
    ▫️ Top is y
    ▫️ Bottom is y + height

So we need to check if
    ▫️ (obj1.x + obj1.width) > obj2.x -- obj1 right collides with obj2 left
    ▫️ obj1.x < (obj2.x + obj2.width) -- obj1 left collides with obj2 right
    ▫️ (obj1.y + obj1.width) > obj2.y -- obj1 bottom colledes with obj2 top
    ▫️ obj1.y < (obj2.y + obj2.height) -- obj1 top collides with obj2 bottom
]]

function Ball:collide()
    self:collidePlayer()
    self:collideAI()
    self:collideWall()
    self:score()
end

function Ball:collidePlayer()
    if CheckCollision(self, Player) then
        self.xVel = self.speed
        local middleBall = self.y + self.height / 2
        local middlePlayer = Player.y + Player.height / 2
        local collisionPosition = middleBall -
            middlePlayer                  -- I guess this will tell us if its negative then its above the middle and if its postive then its below the middle
        self.yVel = collisionPosition * 5 -- this effects how hard of a swing the ball takes
    end
end

function Ball:collideAI()
    if CheckCollision(self, AI) then
        self.xVel = -self.speed
        local middleBall = self.y + self.height / 2
        local middleAI = AI.y + AI.height / 2
        local collisionPosition = middleBall -
            middleAI                      -- I guess this will tell us if its negative then its above the middle and if its postive then its below the middle
        self.yVel = collisionPosition * 5 -- this effects how hard of a swing the ball takes
    end
end

function Ball:score()
    if self.x < 0 then
        self:resetPosition(1)
        Score.ai = Score.ai + 1
    end
    
    if self.x + self.width > love.graphics.getWidth() then
        self:resetPosition(-1)
        Score.player = Score.player + 1
    end
end

function Ball:resetPosition(mod)
    self.x = love.graphics.getWidth() / 2 - self.width / 2
    self.y = love.graphics.getHeight() / 2 - self.height / 2
    self.yVel = 0
    self.xVel = self.speed * mod
end

function Ball:collideWall()
    if self.y < 0 then
        self.y = 0
        -- making a positive number negative makes it negative, but making a negative number negative makes it positive
        -- so if its already negative and you make it negative you are actually just flipping it positive
        -- if we tried just making it positive we've actually just be adding rather than actually flipping it
        self.yVel = -self.yVel
    elseif self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
        self.yVel = -self.yVel
    end
end

--[[
    NOTE:
    Local variables are only available within the current scope:
    ▫️ if declared within an 'if' statement - only reachable inside the 'if' statement
    ▫️ if declared at the top of function - only available inside that function

        Main benefit is to not clutter up the global name space
        ]]
