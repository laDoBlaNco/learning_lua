-- in lua the for loop has two variants
-- numerical for
-- generic for

-- for var=exp1,exp2 exp3 do -- exp3 is optinal step
--  something
-- end

-- this loop will execute 'something' for each value of var from exp1 to exp2 using exp3 as
-- the step to increment var.

-- This third expression is optional. When absent lua assumes that 1 is the step value.

-- print all even values to 20
print()
for i = 2, 20, 2 do
  print(i)
end

print()
-- solution = i -- this won't work
-- print(solution) -- i doesn't exist outside of i so this will be nil.

-- A very important aspect of the numerical for is that the control variable is a LOCAL variable
-- declared by the for loop and it is visible ONLY INSIDE the loop. a common mistake is to assume that 
-- the variable still exists after the loop ends.

-- find index of negative value in a list

function findFirstNegValue(a)
  local pos = nil
  for i=1,#a do
    if a[i]<0 then
      pos = i
      break
    end
  end
  print(pos)
end
findFirstNegValue({1,2,4,7,5,-45,2,5,7,2,-19})