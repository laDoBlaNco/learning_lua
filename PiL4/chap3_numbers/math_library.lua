--[[
        The Lua Mathematical Library

Lua provides a standard math library with a set of mathematical functions, including
trig functions (sin, cos, tan, asin, etc) again used a lot in gfx. Also Logarithms,
rounding functions, max and min, pseudo-random numbers and constants for pi and 
huge (the largest representable number on your system, which is 'inf' or 'Infinity'
in other langs) 
]]
print(math.sin(math.pi/2)) --> 1.0
print(math.max(10.4,7,-3,20)) --> 20
print(math.huge) --> info
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