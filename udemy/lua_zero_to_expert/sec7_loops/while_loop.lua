-- A while loop repeats its body while a condition is true

-- Lua first tests the while condition. If the condition is false, then the loop
-- ends. Otherwise, lua executes the body of the loop and repeats the process

--[[

while condition_evaluation do
  code block
  adjust of the control varible
end
]]

local count = 10
while count > 0 do
  print(count)
  count=count-1
end
print('BLAST OFF!!!')