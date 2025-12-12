--[[
3.4 CONCATENATION

Lua denotes teh string concatentation oerator by .. (two dots). If any of its operands
is a number, lua converts this number to a string:
]]

print()
print('Hello ' .. 'World')
print(0 .. 1)

-- Remember that strings in lua are immutable values. The concatenation operator always 
-- creates a new string, without any modification to its operand.
print()
a = 'Hello'
print(a .. ' World')
print(a)
