--[[
Assignment is the basic means of changing the value of a variable or table from 'nil'
to something
]]
a = 'hello'..'world'
t = {n=0}
t.n = t.n + 1
print()
print(a)
print(t.n)
print()

--[[
Lua allows for multiple assignment, where a list of values is assigned to a list of variables
in one step. Both lists have their elements separated by commas
]]
a,b = 10,2
print(a,b)
print()

-- In multiple assignment, lua first evals all values and only then executes the assignments
-- Therefore I can use a multiple assignment to swap two values, as in
x = 10
y = 20
print(x,y)
x,y=y,x
print(x,y)
print()
a = {i=66,j=55}
print(a.i,a.j)
a.i,a.j = a.j,a.i
print(a.i,a.j)
print()

--[[
Lua always adjusts the number of values to the nubmer of variables: when the list of
values is shorter thatn the list of variables, teh extra vars receive 'nil' as their
values; when the list of values is longer, the extra values are silently discarded:
]]
a,b,c = 0,1
print(a,b,c)
a,b = a+1,b+1,b+2
print(a,b)
a,b,c = 0
print(a,b,c)
print()

--[[
The last assignment in the above example shows a common mistake. To initialize a set of 
variables, I must provide a value for each
]]
a,b,c = 0,0,0
print(a,b,c)

--[[
Actually, most of the previous examples are somewhat artificial. I'll probably seldomly use
multiple assignment simply to write several unrelated assignmentes in one line. A multiple
assignment is not faster than it equivalent single assignments. But often I'll really
need multiple assignment. I already saw an example, to swap two values. A more frequent
use is to collect multiple returns from function calls. As I'll see discussed in detail
in chapter 5, a function call can return multiple values. In such cases, a single 
expression can supply the values for several variables. For instance, in the assignment
a,b = f() the call to f returns two results: 'a' gets the first and 'b' gets the second
]]

