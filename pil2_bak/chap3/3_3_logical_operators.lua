--[[
3.3 LOGICAL OPERATORS

The logical operators are 'and', 'or', 'not'. like control structures all logical 
operators consider both false and nil as false, and everything else as true. The 
operator 'and' retusn its first argument if its false; otherwise, it returns its second
argument. The 'or' oeperator returns its first argument if it is not false; otherwise
it returns its second argument:
]]
print()
print(4 and 5)
print(nil and 13)
print(false and 13)
print(4 or 5)
print(false or 5)

--[[
Both 'and' and 'or' use short-cut evaluation, that is, they evaluate their second operand 
only when necessary. Short-cut evaluation ensures that expressions like 
(type(v)=='table' and v.tag=='h1') do not cause run-time errors. Here lua won't try to evaluate

A useful lua idiom is x = x or v which is equivalent to 'if not x t hen x = v end'

That is, it sets x to a default value v when x is not set (provided that x is not set to
false)

Another useful idiom is (a and b) or c (or simply a and b or c, because 'and' has a higher
precedence than or), which is equivalent to the C ternary expression a?b:c, provided that b 
is not false. (I'm not sure why they keep saying "provided x is not set to false"). For instance,
I can select the max of two numbers x and y with a statement like

  max = (x > y) and x or y

When x>y, the first expression of the 'and' is true, so the 'and' results in its second expression
(x), which is always true (because  it is a number), and then the 'or' expression results in the
value of its first expression, x. When x>y is false the 'and' expression is false and so the 'or'
result is its second expression, which is y. 

The operator 'not' always returns true or false:
]]
print()
print(not nil)
print(not false)
print(not 0) -- false remembering that 0 is actually truthy
print(not not nil)

