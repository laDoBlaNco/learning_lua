--[[
        Number Storage
▫️ As of version 5.3, lua stores numbers internally as either integer or double (64 bit)
  by default

▫️ Prior to 5.3, lua stored numbers as double (64 bit)

▫️  tonumber('42') -- converts strings to numbers 

        Basic Operators Available in Lua
▫️ ^ - exponential
▫️ * - multiplcation
▫️ / - division
▫️ % - modulus or modulo
▫️ + - addition
▫️ - - subtraction

        Precedence
▫️  ^
▫️  not # -(unary)
▫️  * / %
▫️  + -(subtraction)

]]

local answer = 2+5*4
print(answer)
answer = (2+5)*4
print(answer)
answer = 5%4
print(answer)
print()

--[[
    Standard Libraries
▫️ Math
▫️ String
▫️ Table
▫️ Input/Output
▫️ Operating System
▫️ Debug 

Focusing on the math library today and I'll see the others later.
Math
▫️ acos  ▫️ asin  ▫️ ceil
▫️ cos   ▫️ deg   ▫️ exp
▫️ floor ▫️ huge  ▫️ log
▫️ log10 ▫️ max   ▫️ min
▫️ pi    ▫️ rad   ▫️ random
▫️ randomseed    ▫️ sin 
▫️ tan 

We'll look at pi and random here
]]
local my_pi = math.pi
print(my_pi)
-- random will return a random number between set values. If you don't set the values
-- it will return a random number between 0 and 1
local my_number = math.random()
print(my_number)
my_number = math.random(10)
print(my_number)
my_number = math.random(10,20)
print(my_number)
-- this is a pseudo-random number generator. Meaning that if we don't reseed the generator
-- then we will get the same random numbers again.
math.randomseed(os.time())
my_number = math.random(10)

-- some trig functions as well which are useful for games and gfx



