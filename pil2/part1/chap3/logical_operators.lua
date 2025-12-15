--[[
3.3 - LOGICAL OPERATORS

Again what's expected. Remember that only 'false' and 'nil' are false

'and' returns its first arg IF its false, otherwise returns the second
'or' returns its first arg if its not false, otherwise its second

]]
print(4 and 5) --> 5
print(nil and 13) --> nil
print(false and 13) --> false
print(4 or 5) --> 4
print(false or 5) --> 5
print()

-- both 'and' and 'or' are short-cut evaluations
-- a useful lua idiom based on this which is lua's version of a default assignment
-- for assignment
-- x = x or v (if not x then x = v end)

-- then theres lua's ternary since 'and' has higher precedence than 'or'
-- a and b or c (a ? b : c) 

-- and finally 'not' always returns true or false (negation)
print(not nil) --> true
print(not false) --> true
print(not 0) --> false
print(not not nil) --> false
print()





