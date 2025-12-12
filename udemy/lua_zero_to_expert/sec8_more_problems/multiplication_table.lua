--[[
PROBLEM 1 - MULTIPLICATION TABLE

Write a function in lua that given a number n it prints the multiplication
table of n. Use the numerical for to solve this problem

had to get a quick reminder from google, but numeric 4 is pretty simple with 
'var=start,stop,[step=1] do ...'
]]

function multi_table(n)
  for i=1,10 do
    print(string.format('%i * %i = %i',n,i,n*i))
  end
end

multi_table(5)
print()
multi_table(3)