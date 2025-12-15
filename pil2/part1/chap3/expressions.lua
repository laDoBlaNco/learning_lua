--[[
Chapter 3 - Expressions - Arithmetic Operators

Lua supports all the norm (+ - * / % ^)

]]

-- modulo has some interesting impacts on floats
local x = math.pi
print(x % 1) -- fractional part
print(x - x % 1) -- integer part
print(x - x % 0.01) -- x exactly 2 decimal digits
print()

-- working with degrees
local tolerance = 10
function isturnback(angle)
	angle = angle % 360
	return (math.abs(angle - 180) < tolerance)
end

print(isturnback(-180))
print()

-- working with radians
local tolerance2 = 0.17
function isturnback(angle)
	angle = angle % (2 * math.pi)
	return (math.abs(angle - math.pi) < tolerance2)
end
