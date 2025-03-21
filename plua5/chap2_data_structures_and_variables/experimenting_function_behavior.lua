-- experimenting_function_behavior.lua

-- Function to sum a variable number of arguments.
function sumAll(...)
  local total = 0
  local numbers = { ... }

  for i = 1, #numbers do
    total = total + numbers[i]
  end

  return total
end

print()
print('Sum of numbers:', sumAll(1, 2, 3, 4, 5))

-- here we use the elipses ... to collect all the arbitrary args into a table. Then iterate
-- over them to compute the sum. By playing around with these variations and refactoring, I can
-- see lua's function features and get a better idea of how functions work as flexible, reusable
-- patterns.


