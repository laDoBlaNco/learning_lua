-- combining_data_types_in_expressions.lua

-- This will produce an error because '100' is a string, not a number
result = "100" + 50 -- this didn't error. Lua auto converted
print()
print('Result:',result)

-- but its still a good idea to do the conversion explicitly
score = 85
message = 'Your score is ' .. tostring(score)
print()
print(message)
