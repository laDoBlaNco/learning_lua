--[[
    Chapter 3. Numbers

Until version 5.2, lua had all numbers using double precision floating-point format. Starting
in version 5.3, lua now uses TWO ALTERNATIVE representations for numbers:
    ▫️ 64-bit integer numbers, called simply ints
    ▫️ double-precision floating-point numbers called simply floats

The intro of ints is a hallmark of lua, its main difference agaisnt previous versions.
nevertheless this change created a few incompatibilities, because double-precision floating
point numbers can represent integers up to 2^53. Most of the material we will present here
is valid for lua 5.2 and older versions too.
]]

-- Numerals:
-- we can now write constants with an optional decimal part plus an optional decimal
-- exponent
-- numerals with a decimal or exponent are considered as floats, otherwise they are ints
print(type(3))
print(type(3.5))
print(type(3.0)) -- they show as the same type as they are interchangeable
print(1 == 1.0)
print(-3 == -3.0)
print(0.2e3 == 200)
print()
-- if we need to distiguish between them we can use math.type
print(math.type(3))
print(math.type(3.0))
print()
-- lua also supports hexidecimal constants with the right prefix (like C)
print(0xff)
print(0x1A3)
print(0x0.2)
print(0x1p-1)
print(0xa.bp2)
print()
-- lua mapping very similarly to C can format  using string.format with %a option
print(string.format('%a',419))
print(string.format('%a',0.1))
-- this format preserves the full precision of any float value and the conversion is
-- faster than with decimals.
