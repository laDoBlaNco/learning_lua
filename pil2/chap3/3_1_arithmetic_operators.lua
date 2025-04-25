--[[
lua supports teh usual arithmetic operators:
  ▪ the binary
    ▪ + (addition)
    ▪ - (subtraction)
    ▪ * (multiplication)
    ▪ / (division)
    ▪ ^ (exponentiation)
    ▪ % (mmodulo) - a % b == a - floor(a/b)*b
  ▪ the unary
    ▪ - (negation)
    ▪ 

For integer arguments, it has the usual meaning, with the result always having the same
sign as the second argument. For real arguments, it has some extra uses. for instance,
  ▪ x%1 is the fractional part of x
  ▪ x-x%1 is its integer part
  ▪ x-x%0.01 is x with exactly 2 decimal digits
]]
x = math.pi
print(x - x%0.01)

--[[
As another example of the use of the modulo operator, suppose suppose that I want to check
whether a vehicle turning a given angle will start to backtrack. If the angle is given in
degrees, I can use the following formula:
]]
local tolerance = 10
function isTurnBack(angle)
  angle = angle % 360
  return (math.abs(angle-180) < tolerance)
end

-- This definition works even for negative angles:
print()
print(isTurnBack(-180))

-- if I want to work with radians instead of degrees, I simply change the constants
-- in the function
local tolerance2 = 0.17

function isTurnBack2(angle)
  angle = angle % (2*math.pi)
  return (math.abs(angle-math.pi) < tolerance2)
end

-- The operation angle%(2*math.pi) is all we need to normalize any angle to a value in
-- the interval