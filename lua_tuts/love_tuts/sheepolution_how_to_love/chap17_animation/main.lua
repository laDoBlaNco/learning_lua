--[[
Chapter 17 - Animation
Let's talk about frames. Various images which we'll put into a table after loading them

]]

local frames, current_frame, image, max_frames

love.load = function()
  -- table.insert(frames, love.graphics.newImage('jump1.png'))
  -- table.insert(frames, love.graphics.newImage('jump2.png'))
  -- table.insert(frames, love.graphics.newImage('jump3.png'))
  -- table.insert(frames, love.graphics.newImage('jump4.png'))
  -- table.insert(frames, love.graphics.newImage('jump5.png'))

  -- but let's do this much more efficiently with a loop
  -- for i = 1, 5 do
  --   table.insert(frames, love.graphics.newImage('assets/jump' .. i .. '.png'))
  -- end

  -- The above is still inefficient if we are going to have a lot of animations. We need to get it
  -- all in one image. That means 'sprite sheets' or as said here  'quads'
  image = love.graphics.newImage('assets/jump_3.png')
  local width = image:getWidth()
  local height = image:getHeight()
  -- quads is like a rectangel that we cut out of our image. We tell the game what part of the image
  -- we want. We can do this with loves newQuad function
  frames = {}
  local frame_width = 117
  local frame_height = 233
  max_frames = 5
  for i = 0, 1 do
    -- I changed i to j in teh inner for-loop
    for j = 0, 2 do
      -- meaning you also need to change it here
      table.insert(frames,
        love.graphics.newQuad(1 + j * (frame_width + 2), 1 + i * (frame_height + 2), frame_width, frame_height, width,
          height))
      if #frames == max_frames then
        break
      end
    end
    print("I don't break!")
  end

  current_frame = 1
end


love.draw = function()
  love.graphics.draw(image, frames[math.floor(current_frame)], 100, 100)
end

--[[
SUMMARY:
With quads we can draw part of an image, we can use this to turn a spritesheet into an animation. In case
of multiple rows we can use a for-loop inside a for loop to cover the whole sheet. I can use a 'break'
to end a loop if needed. Then with 1 pixel border we ensure there is no bleeding.

]]