-- Creating and using images is super easy in LOVE. First we need an image 'sheep.png'.
-- I can use any image as long as its of the type .png.

-- first I need to load the image and store it in a var. For this I use love.graphics.newImage('path')

local myImage, width, height

function love.load()
  myImage = love.graphics.newImage('sheep.png')
  -- we an also change the color our image is drawn in using love.graphics.setColor(r,g,b,[a])
  -- and setBackgroundColor(r,b,g,[a])
  love.graphics.setBackgroundColor(1,1,1)
  -- since the newImage function actual returns an object (table), it has functions that we can use
  -- to edit our image or get data about it
  width = myImage:getWidth()
  height = myImage:getHeight()
end

-- now I draw the image with love.graphics.draw(image_name,x,y,rsx,sy,ox,oy,kx,ky)
function love.draw()
  love.graphics.setColor(255/255,200/255,40/255,127/255) -- in love the 0-255 is 0 to 1, a %, so we need to
  -- divide what we want by 255 (n/255). I can think of it like random is between 0 and 1, a percentage.
  -- so the above is really .setColor(1,0.78,0.15,0.15)

  -- all args in .draw are optional except for the image
  -- x and y are the horizontal and vertical position of where I want to draw the image
  -- r is the rotaion (or angle). All angles in LÖVE are radians. I'll learn more about that later
  -- love.graphics.draw(myImage, 100, 100)
  -- sx an sy are the scale-x and scale-y for scaling the image up or down, we can even use these to
  --  ▫️ mirrior the image love.graphics.draw(image_name,100,100,0,-1,1)
  love.graphics.draw(myImage, 100, 100, 0, 2, 2)
  love.graphics.draw(myImage, 100, 100)
  love.graphics.draw(myImage, 100, 100, 0, -1, 1)
  -- ox and oy are the origin-x and origin-y of the image.
  --  ▫️ by default all scaling and rotating is down off the origin point (0,0) which is the top left
  --    corner.
  --  ▫️ If I want to scale or rotate the image from the center I use the ox and oy to move the origin
  --    to the center

  -- then I have to redo the color every time I want it different. Just like most canvas coding tools
  love.graphics.setColor(1,1,1)
  love.graphics.draw(myImage, 100, 450, 5, 2, 2)
  love.graphics.draw(myImage, 100, 450, 5)
  -- center rotation moving the ox & oy
  love.graphics.draw(myImage, 450, 450, 5, 2, 2, width/2, height/2)
  love.graphics.draw(myImage, 450, 450, 5, 1, 1, width/2, height/2)

  -- then kx and ky is for shearing (which doesn't have a 'k' at all so I'm not sure what to make of that)
  -- its basically for skewing images (there's a k in skew 🤔)
  -- love.graphics.draw(myImage,350,450,2,1,1,39,50,7,10) -- not sure this worked 🤔
end

--[[
Summary:
We load an image with image_name = love.graphics.newImage('path.to.image.png'), which returns an image
"object" (table) that I can store in a variable. I then pass that to love.graphics.draw(image_name)
to draw the image. this function has optional args for the position, angle, and scale of the image.
An image object has functions that I can use to get data about it. I can use love.graphics.setColor(r,g,b,a)
to change in what color the iamge and everything else is drawn.

]]