--[[
4.3 CONTROL STRUCTURES: numeric for

the for statement has two variants: 
  ▪ the numeric
  ▪ the generic

A numeric for has the following syntax;
  for var=exp1,exp2,exp3 do
    <something>
  end

This loop will execute 'something' for each value of var from exp1 to exp2, using exp3
as the step to increment var. This 'exp3' is optional; when absent lua assumes 1 as the
step value. As typical examples of such loops we have:
]]

for i=1,5 do print(i) end
print()
for i=5,1,-1 do print(i) end
print()

-- I can use the constant math.huge if I want a loop without an upper limit, which results
-- inf. So it would be the same as for ;; in C I guess

--[[
The for loop has some subteties that I should be aware of in order to make good use of it
  ▪ First, all three expressions are evaluated once, before the loop starts. 
  ▪ Second, the control variable is a local variable automatically declared by the for 
    statement and is visible ONLY inside the loop. A typical mistake is to assume that the var 
    still exists after the loop ends. If I need the value of the control var after the loop
    usually when I would break the loop, I need to save it into another variable (below example)

  ▪ Third, I should never change the value of the control variable programatically: the effect
    of such changes is unpredictable. If I want to end a 'for' loop before its normal termination
    then I should use 'break' as I did below
]]

-- trying to print the 'i' from the above loop
print(i) --> nil
print()

-- saving control variable to another var
local found = nil
a = {1,2,3,4,5,6,-7,8,9,10}
for i=1,#a do
  if a[i] < 0 then
    found = i     -- saving index of 'i' to found
    break
  end
end
print(found)


