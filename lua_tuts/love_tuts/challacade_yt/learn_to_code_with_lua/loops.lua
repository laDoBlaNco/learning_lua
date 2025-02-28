-- Loops
local message = 0
local test = 0
local pickle = 0

-- while loop
while message < 10 do -- checks our 'condition'
  message = message + 1
  test = test - 5
end

-- for loop
for i = 1, 3, 1 do -- iterator, limit, step value
  pickle = pickle + i
end

print(message)
print(test)
print(pickle)
