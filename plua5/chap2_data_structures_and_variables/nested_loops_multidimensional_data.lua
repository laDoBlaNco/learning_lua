-- nested_loops_multidimensional_data.lua

-- in the wild I'll encounter situations where nested loops are necessary to process
-- multidimensional data. Here we use them to iterate over rows and columns in a 2d table
grid = {
  {1,2,3},
  {4,5,6},
  {7,8,9},
}

print()
for r=1,#grid do
  for c=1,#grid[r] do
    print('Value at row ' .. r .. ', col ' .. c .. ' is ' .. grid[r][c])
  end
end