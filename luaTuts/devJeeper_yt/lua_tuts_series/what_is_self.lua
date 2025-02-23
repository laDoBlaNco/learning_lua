--[[
What is 'self'
▫️ It isn't a reserved word, so its not really a keyword
▫️ We could use any variable in place of Self in the following examples
▫️ ':' is just syntactic sugar for table_name:function_name() == table_name.function_name(table_name)

]]

Player = {
    x = 30,
    speed = 10,
}

function Player:printPosition()
    -- again the ':' is just syntactic sugar, we are just associating a function to a table as normal
    -- but by using the : we are telling something to Lua about how we want to use it
    print(self.x)
end

-- function Player:moveRight()
function Player.moveRight(self)  -- this signature is the same as above using the param self (which could be anything we want ti to be), again without the changing the : for .
    self.x = self.x + self.speed
end

Player:printPosition()
-- Player:moveRight()
Player.moveRight(Player)  -- this is the same as above using the colon, same result, all the colon does is add hidden argument passing the table 
Player:printPosition()

-- interestingly the player table isn't the only table allowed to use its functions and this is the secret
-- to some of the later things I'll be able to do to mimick OOP in lua
Enemy = {
    x = 50,
    speed = 5,
}

print()print()
Player.printPosition(Enemy) -- using the functions associated with Player but passing it our Enemy table instead of 'self' (o sea instead of Player)
Player.moveRight(Enemy) -- this of course won't work with : since : implies we are using self or whatever we use  as  self. 
Player.printPosition(Enemy)

-- great stuff 🤯🤯🤯🤯🤯 I love lua's simplicity allowing me to be so flexible and do so much with so little
