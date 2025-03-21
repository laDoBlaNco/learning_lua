-- for_loops_for_iteration.lua

-- the numeric for loop is ideal when we know the number of iterations in advance
print()
for i = 1,5 do
  print('Iteration number:',i)
end

print()

-- When dealing with arrays or tables, where we may not not the number of items, we can use 
-- the for loop in combination with the length operator (if its a sequence with no holes)
names = {'Alice','Bob','Charlie','Dana'}
for index=1,#names do
  print('Name at index ' .. index .. ' is ' .. names[index])
end
print()

-- we can also use ipairs (for array sequences without holes), or pairs (which returns a 'next' function
-- which we an also use explicitly) for associative or record-style arrays, though it also works
-- with array with holes 
for i,k in ipairs(names) do
  print('Name at index ' .. i .. ' is ' .. k)
end
print()

for i,k in next,names do
  print('Name at index ' .. i .. ' is ' .. k)
end
print()

names[10] = 'Odalis'
for i,k in pairs(names) do
  print('Name at index ' .. i .. ' is ' .. k)
end
print()

for i,k in next,names do
  print('Name at index ' .. i .. ' is ' .. k)
end
print()

-- The use of pairs, ipairs, and next is mainly a decision based on the type of table you are 
-- working with as well as preference (next vs pairs)

