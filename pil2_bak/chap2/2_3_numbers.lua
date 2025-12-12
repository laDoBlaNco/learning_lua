--[[
The number type represents real (double-precision floating-point) numbers. This changes
in lua 5.4, but I'm sticking to 5.1 since that is the version that most real products
are using. Lua51 has no integer type, as it does not need it. There is a widespread 
misconception about floating-point arithmetic errors; some people fear that even a simple
increment can go weird with floating-point nubmers. The fact is that, when you use a double
to represent an integer, there is no rounding error at all (unless the number is greater than
10^14). Specifically, a lua number can represent an 32-bit integer without rounding problems.
Morever, most modern CPUs do flaoting-point arithmetic as fast as (or even faster than) integer
arithmetic. 

Nevertheless, it is easy to compile lua so that it uses another type for numbers, such as longs
or single-precision floats. This is particularly useful for platforms without hardward support
for floating point. I can see file luaconf.h in the distro for detailed instuctions on how to 
do that.

I can write numeric constants with an optional decimal part, plus an optional decimal exponent.
Here are some examples fo numeric constants:
]]

print(4)
print(0.4)
print(4.57e-3)
print(0.3e12)
print(5e+20)
print(5e20) -- i guess its the same thing then 🤔🤔🤔