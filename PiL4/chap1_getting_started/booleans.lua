--[[
Booleans

This type has two values:
    ▫️ @false{}
    ▫️ @true{}

These represent the traditional boolean values. However Booleans don't hold a monopoly
over condition values. In lua, any value can represent a condition. In lua
    ▫️ both false and nil are considered as false
    ▫️ everything else is considered true 
        ▫️ including both 0 (zero) and '' (empty string)

Lua also has the expected logical operators:
    ▫️ and
    ▫️ or
    ▫️ not

With short circuting they work pretty much as I would see them in other languages
returning the evaluated value depending on whether it had to evaluate them or not
]]

print(4 and 5) --> the result is 5
print(nil and 13) --> the result is nil
print(false and 13) --> result is false
print(0 or 5) --> result is 0
print(false or 'hi') --> result is 'hi'
print(nil or false) --> the result is false

-- The above evaluate the second operand only when necessary. Short-circuited evaluation
-- ensures that expressions like i ~= 0 and a/i > b don't give us run-time errors. If i 
-- is zero, then lua won't even try to do the division.

-- based on the above, a much seen lua idiom is x = x or v which means if not x then x = v end
-- Also good to keep in mind precedence with logical operators. 'and' has higher precedence
-- than 'or'. so something like 'a and b or c' is the same C expression a ? b : c if b isn't
-- false of course.

-- Finally the 'not' operator always gives a bool, regardless of what its used with
print()print()

print(not nil) --> true
print(not false) --> true
print(not 0) --> false
print(not not 1) --> true
print(not not nil) --> false
