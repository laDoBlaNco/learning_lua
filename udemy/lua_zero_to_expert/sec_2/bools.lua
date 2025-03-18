--[[
Booleans and Logical Operators
Lua supports a convential set of logical operators: and, or, and not
  • The result of the 'and' operator is its first operand if that operand is false;
    otherwise, the result is its second operand
  • The result of the 'or' operator is its first operand if it is not false;
    otherwise, the result is its second operand
]]
print()
print(4 and 5) --> 5
print(nil and 13) --> nil
print(false and 13) --> false
print(0 or 5) --> 0
print(false or 'hi') --> 'hi'
print(nil or false) --> false
print()

-- A useful lua idiom is x = x or v, which is the same as 'if not x then x = v end'
local a,b,x,y
a = 'something'
a = a or 'default'
b = b or 'default'
print(a) --> something
print(b) --> default
print()
-- Another useful idiom is 'a and b or c' which is the same as the c ternary operator 'a ? b : c' 
x = a and 'something' or 'nothing'
y = nil and 'something' or 'nothing'
print(x) --> something
print(y) print() --> nothing

print(not nil) --> true
print(not false) --> true
print(not 0) --> false
print(not not 1) --> true
print(not not nil) --> false
