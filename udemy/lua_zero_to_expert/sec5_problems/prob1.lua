--[[
  Write a function that given a natural numbmer n it returns the square and the
  square root of this number

]]

local squares = function(n)
  return n ^ 2, math.sqrt(n)
end

print()
print(squares(4))
print(squares(2))
print(squares(1000))
