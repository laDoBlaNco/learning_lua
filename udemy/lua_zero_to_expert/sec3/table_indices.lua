--[[
Representing Structures

In lua we cna represent structures with tables.

Lua supports this representation by providing t.name as syntactic sugar for t['name']

]]

local t,y,test,example

t = {}
t.x = 2  --> same as t['x'] = 2
t.h = 10 --> same as t['h'] = 10
print(t.x) --> same as print(t['x']) 
print()

--[[ A common mistake for beginners is to confuse t.x with t[x] The first form represents
t['x'] that is, a table indexed by the string 'x'. The second form is a table indexeed by
the value in the VARIABLE x which is different]]
y = 'z'
t[y] = 50 -- put 50 in field 'z'
print(t[y]) --> 50 --> value of the field z
print(t.y) --> not the same as the above (still undefined) 
print(t.z) --> 50 --> value of the field z

--[[ Finally when used as a key, any float value that can be converted to an integer is converted]]

print()
test = {}
test[5.5] = 'a float'
test[5.0] = 'converted to int'
test[7.5] = 'still a float'
test[7.0] = 'converted again'
test[2] = 'indexed?'
test[3] = 'another?'
test[10] = 'and this one?'
for k,v in next,test do
  print(k..'==>'..v)
end
print()
-- for k in ipairs(test) do
--   print(k..'==>'..test[k])
-- end
print()

-- so I use ipairs when its an array and I want the index, but THE INDEXES (REGARDLESS OF WHAT THEY ARE, CAN'T BE SET EXPLICITLY)
example = {'here','is','an','array'}
for k,v in ipairs(example) do
  print(k..'==>'..v)
end
print()