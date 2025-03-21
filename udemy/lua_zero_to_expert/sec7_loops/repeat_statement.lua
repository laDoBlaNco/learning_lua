-- repeat..until statement repeats a chunk of code until its condition is true

-- This statement does the test after the body, so like a do_while loop in other languages
-- it always executes the body at least once.

--[[
Syntax:

repat
  code block
until concition_to_exit

]]
print()
print('Example 1:')

local count = 1
repeat
  print('Count: ' .. count)
  count = count + 1
until count > 5
print()

print('Example 2:')
local i = 1
repeat
  print('Inside loop ' .. i)
  i = i + 1

  if i == 4 then break end
until i > 5
print('Outside loop ' .. i)
print()

print('Example 3:')
local x=1
repeat
  local y=1
  repeat
    print('x: ' .. x .. ' y: ' .. y)
    y=y+1
  until y > 3
  x=x+1
until x > 2
