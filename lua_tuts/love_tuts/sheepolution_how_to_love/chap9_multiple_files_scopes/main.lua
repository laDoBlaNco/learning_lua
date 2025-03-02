local required = require('example')

--[[

Multiple files

With multiple files our code will look more organized and easier to navigate. Let's start by
creating a new file 'example.lua'

Scope

Local variables are limited to their scope. in the case of Test, the scope
is the file 'example.lua' This means that test can be used everywhere inside that file, but not in
other files. I did this with some of vars to have them global in a file but not mixing in others.

If I create a local var in a block, like a function, if-statement or for-loop, then that would be
the variable's scope

Parameters of functions are just more local variables. Only existing inside the function
To really understand this, let's take a look at the following code below:

When creating a local variable, I don't have to assign a value right away, for this reason i can
set my 'local global vars'

Returning a value

If I add a return statement at the top scope of a file (o sea not in a function) it will be returned
when I use require to load the file.


]]
-- print(Test)

Test = 10
print(Test)
print(required) -- from our returned var from example.lua

--[[
When and why locals?

The best practice is to always us local variables. The main reason for this is that with globals
I'm more likely to make mistakes. I might accidentally use the same variable twice at different
locations, changing the var to something at location 1 where it won't make sense to have that
value at location 2. If I'm going to use a var only in a certain scop then make it local.

So in the other chapter when I made the function the creted rectangles. In that function I could
have made the vr rect local, since I only use it in that function. I still use that rectangle
outside the function, but I access it from the table to which I added it.

The ListOfRectangles had to be global since we used it in various functions. But again, making it
local at the top scope will make it global to all the functions, but local to the file. Which I think is
better. And that's actually the next example that sheepollution uses.

🤔🤓
We could still make it local by creating the variable outside of the love.load function and then
we wouldn't even need the love.load function at all.
]]
local listOfRectangles = {}

local function createRect()
  local rect = {}
  rect.x = 100
  rect.y = 100
  rect.width = 70
  rect.height = 90
  rect.speed = 100

  table.insert(listOfRectangles, rect)
end


function love.update(dt)
  for i, v in ipairs(listOfRectangles) do
    v.x = v.x + v.speed * dt
  end
end

-- now that we have 'properties' we can draw our rectangle
function love.draw()
  for i, v in ipairs(listOfRectangles) do
    love.graphics.rectangle('line', v.x, v.y, v.width, v.height)
  end
end

function love.keypressed(key)
  -- remember 2 equal signs for comparing
  if key == 'space' then
    createRect()
  end
end

-- Summary
-- With require we can load other lua-files. When you create a variable you can use it in all files. 
-- Unless you create a local variable, whic is limited to its scope. Local variables do not affect 
-- variables with the same name outside of their scope. Always try to use local variables over global,
-- as they are faster and safer. 
