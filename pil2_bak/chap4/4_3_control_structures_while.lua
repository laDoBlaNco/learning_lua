--[[
4.3 CONTROLS STRUCTURES: while

As usual, lua first test the while condition, just like any other language; if the condition
is false, then the loop ends; otherwise, lua executes the body of the loop and repeats the
process. As expected, I must control the counter to avoid an infiite loop
]]

local i = 1
while i <= 10 do
  print('Iteration: '..i)
  i = i + 1  -- note that there is no i++ or i--
end