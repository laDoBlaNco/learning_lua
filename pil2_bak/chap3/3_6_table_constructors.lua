--[[
3.6 TABLE CONSTRUCTORS

Constructors are expressions that create and initialize tables. They are a distinctive
feature of lua and one of its most useful and versatile mechanisms.

The simplest constructor is the empty constructor, {}, which creates an empty table; I've
seen it before. Constructors also initialize arrays (called also sequences or lists)
for Example:
]]
days = { 'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday' }

-- the first element of the constructor has index 1, not 0
print(days[4])
print()
-- lua also offers special syntax to intialize a table record-like, as in the next
-- example:
a = { x = 10, y = 20 }
print(a.x, a.y)
-- this previous is the same as
a = {}
a.x = 10
a.y = 20
print(a.x, a.y)
print()

-- no matter what constructor I use to create a table, I can always add fields to and remove
-- fields from the result
w = { x = 0, y = 0, label = 'console' }
x = { math.sin(0), math.sin(1), math.sin(2) }
for k, v in pairs(w) do print(k .. ':' .. v) end
print()
for k, v in pairs(x) do print(k .. ':' .. v) end
print()

w[1] = 'another field' -- add key 1 to table 'w'
x.f = w                -- add key 'f' to table 'x'
print(w['x'])
print(x[1])
print(x.f[1])
w.x = nil -- remove field 'x'

--[[
That is, all tables are created equal; constructors affect only their initialization
Every time lua evaluates a constructor, ti creates an intiializes a new table.
So i can use tables  to implement things like linked lists
]]
--[[
list = nil
for line in io.lines() do
  list = {next=list,value=line}
end
--]]
--[[
This code reads lines from the standard input and stores them in a linked list, in
reverse order. Each node in the list is a table with two fields: value, with the line
contents, and next, with a reference to the next node. The following code traverses
the list and prints its contents:
]]
--[[
local l = list
while l do
  print(l.value)
  l=l.next
end
--]]

--[[
Because i implmeented the list as a stack, the lines will be printed in reverse order
Although instructive, I will seldom use the above implementation in real lua programs;
lists are better implemented as arrays, as I'll see in chap 11

I can also mix record-style and list-style initializations in the same constructor
]]

polyline = {
  color = 'blue',
  thickness = 2,
  npoints = 4,
  { x = 0,   y = 0 },
  { x = -10, y = 0 },
  { x = -10, y = 1 },
  { x = 0,   y = 1 },
}

--[[
In this example above I illustrate how I can nest constructors ({}) to represent more complex
data structures. Each of the elements 'polyline[i]' is a table representing a record:
]]
print()
print(polyline[2].x)
print(polyline[4].y)
print()

--[[
Now these two constructor forms do have their limitations though. For example, I can't
initialize fields with negative indices, nor with string indices that aren't proper
identifiers. For such needs, there is another, mor general, format. In this format,
I explicitly write the index to be initialized as an expression, between square brackets:
]]

opnames = { ['+'] = 'add', ['-'] = 'sub', ['*'] = 'mul', ['/'] = 'div' }
-- This is interesting, I don't think I've seen this before 🤔
i = 20; s = '-'
a = { [i + 0] = s, [i + 1] = s .. s, [i + 2] = s .. s .. s } -- 🤔

print(opnames[s])
print(a[22])
print()

--[[
So the syntax above is a bit more cumbersome, but also more flexible after all: both the
list-style and the record-style format are special cases of this more general syntax. The
constructor {x=0,y=0} is equivalent to {['x']=0,['y']=0}, and the
constructor {'r','g','b'} is equivalent to {[1]='r',[2]='g',[3]='b'}

For those that really want their arrays starting at 0, it isn't too difficult to write
the following, explicitly setting the numeric index to start
]]
days2 = { [0] = 'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday' }
--[[
This doesn't do what it appears. Its not an enumeration where I'm putting the starting
index and it'll follow suit. What lua sees is an explicit index setting of [0] and then
the following is the 'list-style' index which will naturally start at 1. To prove this
I'll print the above using both pairs and ipairs (I forget how to use 'next'):
]]

-- nota la diferencia entre  pairs and ipairs (where ipairs expects list style indexing)
for k, v in pairs(days2) do
  print(k .. ':' .. v)
end
print()
for k, v in ipairs(days2) do
  print(k .. ':' .. v)
end
print()

--[[
The first value, 'sunday' is set to index 0, This zero isn't the natural setting of the
list-style, but it doesn't effect the other fields either, since  'monday' is still seen
by lua as the first 'list-style' element and thus set to 1 automatically. Note the order when
I loop through as well. Despite this facility, it'll cause confusion bugs later. Lua is
designed to use 1-indexing and in order for it to handle arrays correctly, Its better to
follow that design, if I want to use lua.

Trailing commas are also optional after the last entry, but always valid.

With such flexibility, programs that generate lua tables do not need to handle the last
element as a epcial case.

Finally, I can always use a semicolon instead of a comma in a constructor. I will might try
to use this to delimit differnt sections inside a constructor. For example to separate its
list part from its record part. 🤔 This seems to give me an error though, so I don't 
think I'll follow  this convention
]]

    { x = 10, y = 45, 'one', 'two', 'three' }
