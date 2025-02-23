--[[
        The Lua Mathematical Library

Lua provides a standard math library with a set of mathematical functions, including
trig functions (sin, cos, tan, asin, etc) again used a lot in gfx. Also Logarithms,
rounding functions, max and min, pseudo-random numbers and constants for pi and
huge (the largest representable number on your system, which is 'inf' or 'Infinity'
in other langs)
]]
print('Mathematical Library:')
print(math.sin(math.pi / 2))  --> 1.0
print(math.max(10.4, 7, -3, 20)) --> 20
print(math.huge)              --> info
print()

--[[
Random-number Generator - call it 3 ways
    ▫️ we can call it with no args and we get a pseudo-random number between [0,1]
    ▫️ we can call it with one arg, an integer n, it returns a pseudo-random int
      in the interval [1,n]
    ▫️ we can call with two ints, l and u, to get a pseudo-random int in the interval
      [l,u]

Its pseudo-random because if we just use the function we will eventually start to see
the same numbers coming up. We can seed the generator with randomseed and its solo numeric
arg is used to 'seed'. The default is 1, which is why it eventually starts to repeat
numbers. Without a specific seed every run will generate the same sequence of numbers.
    ▫️
]]

--[[
Roundiang Functions:
The math library offers three rounding functions
  ▫️ floor - floor rounds fowards minus infinite
  ▫️ ceil - ceil rounds towards plus infinite
  ▫️ modf - modf rounds towards zero
They return an integer result if it fits in ints in an integer; otherwise, they return a float
(with an integral value, of course) The function modf, besides the rounded value, also returns
the fractional part of the number as a second result
]]
print('Rounding Functions:')
print(math.floor(3.3))
print(math.floor(-3.3))
print(math.ceil(3.3))
print(math.ceil(-3.3))
print(math.modf(3.3))
print(math.modf(-3.3))
print(math.floor(2 ^ 70))

--[[
If the argument is already an integer, it is returned unaltered.

If we want to round a number x to the nearest  integer, we could compute the floor x + 0.5
But just doing the simple addition will introduce some errors in certain cases, like:
]]
local x = 2 ^ 52 + 1
print(string.format("%d %d",x,math.floor(x + 0.5))) -- but 2^52 + 1.5 would be incorrect

-- to avoid this problem we can treat integral values separately
local round = function(x)
  local f = math.floor(x)
  if x == f then return f else return math.floor(x + 0.5) end
end

print(math.floor(3.5 + 0.5))
print(round(3.5))
print(math.floor(2.5 + 0.5))
print(round(2.5))
print()print()
-- we can also use modulo if we want to round to the nearest even number
local function round2(x)
  local f = math.floor(x)
  if(x==f) or (x%2.0 == 0.5) then
    return f
  else
    return math.floor(x + 0.5)
  end
end

print(round2(2.5))
print(round2(3.5))
print(round2(-2.5))
print(round2(-1.5))
