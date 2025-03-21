-- combining_control_structures.lua

-- here we use ifs and loops for more complex logic. Going through an array and doing something
-- specific for certain elements

numbers = {3,7,12,5,18,9}

print()
for i = 1,#numbers do
  if numbers[i] > 10 then 
    print('Number ' .. numbers[i] .. ' is greater than 10') 
  else
    print('Number ' .. numbers[i] .. ' is 10 or less')
  end
end
