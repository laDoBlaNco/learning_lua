-- Conditionals - if,elseif,else statements
local message = 0
local condition = -5

if condition > 0 then
  message = 1
elseif condition < -10 then
  message = -1
elseif condition == -5 then -- '==' is equal to vs
  message = 'hello'         -- '=' is assignment
  print('hi')
else
  message = 'no conditions met'
end


print(message)
