-- if_statements_for_decisions.lua

-- if is pretty straight forward in Lua
number = 17

print()
if number > 10 then
  print('The number is greater than 10')
end

if number > 20 then
  print('The number is greater than 20')
else
  print('The number is not greater than 20')
end

if number > 20 then
  print('The number is greater than 20')
elseif number > 15 and number < 20 then
  print('The number is greater than 15 and not greater than 20')
elseif number == 15 then
  print('The number is exactly 15')
else
  print('The number is less than 15 and not greater than 20')
end
