-- so lua has all the basic operators for arithmetic, and it also does
-- floor division
-- The intro of integers vs floats in 5.3 was mainly done so people could ignore
-- the difference. They act as expected from what I understand.
print(13 + 5)      -- 2 ints result in an int
print(13.0 + 15.0) -- 2 floats result in a float
print()

-- if the operands are different the result is a float
print(13.0 + 25)
print(-(3 * 6.0))
print()

-- division doesn't follow that rule like it does in Python, so / gives us what we
-- expect
print(3.0 / 2.0)
print(3 / 2)
print()

-- but we can get integer division (floor division) the same way we do in python (//)
-- then the rule on mixed numbers doesn't fully  apply, everything is truncated, though
-- it takes the form of an int or float based on the mixed number rules.
print(3 // 2)
print(3.0 // 2)
print(6 // 2)
print(6.0 // 2.0)
print(-9 // 2)
print(1.5 // 0.5)
print()

-- modulo is a little more complex following this formula: a % b == a - ((a // b) * b)
-- So for ints everything is as expected with the result ALWAYS having the sign of
-- the second argument.

-- For reals its a little different and comes with some unexpected uses:
-- with this formular x - x%0.01 is always 2 decimal digits and x - x % 0.001 is 3
local x = math.pi
print(x - x % 0.01)
print(x - x % 0.001)
print()

-- this allows us to do things like the following which are used a lot in game dev
-- I'm not going to fake as if I understand why, but I'll look at it again later if
-- I have time.
local tolerance = 10
local function isturnback(angle)
    angle = angle % 360
    return (math.abs(angle - 180) < tolerance)
end
print(isturnback(-180)) --> true

-- or working with radians as we do a lot when working with graphics
tolerance = 0.17
local function isturnback2(angle)
    angle = angle % (2 * math.pi)
    return (math.abs(angle - math.pi) < tolerance)
end

-- Relational operators are the same as expected, except for 'not equal'
    -- which is ~= with tilde instead of != as normal
-- comparison operators work the same whether the number is float or int, but
-- there is aa slight efficiency gain when they are the same type
