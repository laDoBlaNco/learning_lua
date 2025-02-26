--[[
Chapter 5 - Moving a Rectangle

Now we start to do the fun stuff. First with our 3 main callbacks

We need to start thinking like programmers. Rather than using literals for args, we need
to use variables that we can manipulate and give the impression of movement.

and where do we create our variables? in love.load()

]]

function love.load()
  x = 100
end

function love.update(dt)
  --[[
  So what is that 'dt' all about?

  Delta Time - after we got the rectangle moving, we still have a problem. If I run this game on a
  different computer, the rectangle might move with a different speed. This is because not all 
  computers update at the same rate, and that can cause problems. 

  If one pc runs at 100fps (frames per second), and another one runs at 200fps
  100 x 5 = 500
  200 x 5 = 1000
  So in 1 second, x has increased with 500 on computer A, and on computer B x has increased with 1000
  The solution is delta time. When LOVE calls love.update it passes in the argument 'dt'

  dt is the time that has passed between the previous and current update (the delta of the updates). So
  on computer A running at 100fps, dt could average 1/100 or 0.01. And on computer B its 1/200 or 0.005.
  so using dt we scale accurately:
  100 * 5 * 0.01 = 5
  200 * 5 * 0.005 = 5

  Our rectangel will move at the same speed no matter what computer we are on. 🤯🤯🤯🤯🤯
  ]]
  x = x + 100 * dt
end

function love.draw()
  -- so now with x-position using our var x. So if we want to make our rect move we increase x
  -- in our love.update function above
  love.graphics.rectangle('line', x, 50, 200, 150)
end

--[[
In summary, I learned something I didn't know about delta time and what its for. I used a variable
to increase the x coordinate and make the rectangle move. When increasing i multiply the added value
on each update with dt (delta time). The delta time is the time between previous and current updates.
Using dt makes sure that our rectangle moves with the same speed on all computers. 
]]
