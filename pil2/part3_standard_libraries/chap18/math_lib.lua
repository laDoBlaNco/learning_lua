--[[
Chapter 18 - THE MATHEMATICAL LIBRARY

In this and the next chapters about the standard libs, we aren't going to be looking
at the complete specification of each function, but rather seeing the kind of 
functionality each library can provide. We'll probably omit some subtle options
or behaviors for clarity of exposition. The main idea is to spark curiosity and
get an idea of what we have in the bag. We can satisfy that curiosity with the
lua reference manual. 

The 'math' library comprises a standard set of mathematical functions, such as

  • trigonometric funtions - sin, cos, tan, asin, acos, etc
  • exponentiation and logarithms - exp, log, log10, etc
  • rounding functions - floor, cell
  • max
  • min
  • funtions for generating pseudo-random numbers - random, randomsee, etc
  • constant variables - pi, huge (the special value inf on some platforms)

All trigonometric funtions work in radians. We can use the functions 'deg' and
'rad' to convert between degrees and radians. So if we want to work in degrees,
we can simply redefine the trigonometric functions:
]]
--[[
local sin,asin = math.sin,math.asin
local deg,rad = math.deg,math.rad
math.sin = function(x) return sin(rad(x)) end
math.asin = function(x) return deg(asin(x)) end
--]]

--[[
The math.random function generates pseudo-random numbers. We can call it in three 
ways. 

  • when we call it without args, it returns a psuedo-random real number with uniform
    distribution between 0,1
  • when we call it with only one arg, an integer 'n', it returns a pseudo-random integer
    'x' such that 1 <= x <= n. For example, we can simulate tossing a die with 
    random(6)
  • when we call it with two integer args, 'l' and 'u', it returns a pseudo-random integer
    'x' such that l <= x <= u.

We can set a seed for the pseudo-random generator with the 'randomseed' function; its
numeric sole argument is the seed. Usually when a program starts, it initializes the
generator with a fixed seed. That means that, every time we run our program, it'll
generate the same sequence of pseudo-random numbers. For debugging, this is a nice
property; but in a game, for example, we'll see the same scenario repeating every time.
A common trick to solve this problem is to use the current time as a seed:

  math.randomseed(os.time())

The os.time function returns a number that represents the current time, usually as the
number of seconds since some epoch.

The math.random function uses the 'rand' function from the standard C library. In some
implementations, this function produces numbers with not-so-good statistical properties.
We can check for independent distributions of better pseudo-random generators for Lua.
(The standard lua distribution does not include any such generator to avoid copyright
problems. It contains only code written by the lua authors.)


]]

