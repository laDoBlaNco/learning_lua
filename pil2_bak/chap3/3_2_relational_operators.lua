--[[
3.2 RELATIONAL OPERATORS

lua provides the following relation operators, which is normal except for one:
  ▪ < less than
  ▪ > greater than
  ▪ <= less than or equal to
  ▪ >= greater than or equal to
  ▪ == is equal to

All the oeprators always result in true or false

I can apply both operators to any two values. If the values have different types, lua
considers them not equal. Otherwise, lua does the comparison according to their types
Specifically, nil is equal only to itself.

lua compares tables, userdata, and functions by reference, that is, two such values are
considered equal only if they are the very same object. For instance:
]]
a = {}; a.x = 1; a.y = 0
b = {}; b.x = 1; b.y = 0
c = a

-- here a == c, but a ~= b
print()
print(a == c)
print(a ~= b)
print()

--[[
I can apply the order operators only to two numbers or to two strings. Lua compares strings
in alphabetical order, which follows teh locale set for lua. Values other than numbers
and strings can be compared only for equality (and inequality) 

When comparing values with different types I need to be careful then. I need to remember
that '0' is different from 0. Moreover, 2<15 is obviously true, but '2' < '15' is false
(alphabetical order). To avoid inconsistent results, lua raises an error when you mix
strings and numbers in an order comparison, such as 2 < '15' - (using string.byte I see why
this is asi)
]]
