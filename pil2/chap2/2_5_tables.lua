--[[ 2.5 TABLES

The table type implements associate arrays and is probably one of the most versatile and
powerful features in lua. An associative array that can be indexed not only with numbers
but also with strings or any other value of the language, except 'nil'. Moreover, tables
have no fixed size; so I can ad as many elements as I want or need to a table dynamically.
Tables are the main (in fact, the only) data structuring mechanism in lua, and a powerful
one. I will use tables to represent ordinary arrays, symbol tables, sets, records, queues,
and any other data structure, in a simple, uniform, and efficient way. Lua uses tables 
internally to represent modules, packages, and objects as well. When I write io.read, I
mean 'the read function from the io module'. for Lua, this means 'index the table io
using the string "read" as the key'.

So its all tables, like other langs say that everything is an object, well in lua an object
is a table, so its literally all tables. Even the main 'thread' or top-level environment, must
be a table

Tables in lua are neither values nor variables; they are 'objects'. Like arrays in Java or 
Scheme. I can think of a table as a dynamically allocated object; my program manipulates only
references (or pointers) to them. This more than likely the reason why when I try to print a 
table I just get its memory address as it itself is a pointer to a place in memory that we
are manipulating. There are no hidden copies or creation of new tables behind the scenes.
Moreover, I don't have to declare a table in lua either; in fact, there is no way to do so.
I create tables by means of the 'constuctor expression', which is in its simplest form just
writing {}
]]
print()
a = {} -- creates a table and store its reference in 'a'
print(a) -- this prints that reference or the memory address
k = 'x'
a[k] = 10 -- new entry, with the key='x' and value=10
a[20] = 'great' -- new entry, with key=20 and value='great'
print(a['x'])
k = 20
print(a[k])
print(a['x']) -- the key is still 'x' even though we change k to something else
a['x'] = a['x']+1 -- increments the entry 'x'
print(a['x'])

--[[ A table is always anonymous. There is no fixed relationship between a variable that
holds a table and the table itself:
]]

print()
a = {}
a['x'] = 10
b = a  -- 'b' refers to the same table as 'a'
print(b['x'])
b['x'] = 20
print(a['x']) --> now 20
a = nil  -- only 'b' still refers to the table
b = nil -- no references left to the table

--[[ When a program has no references to a table left, then lua's gc will eventually delete
the table and reuse that memory

Each table may store values with different types of indices, and it grows as needed to
accomodate new entries:]]

print()
a = {} -- an empty table again
-- create 100 new entries
for i=1,1000 do a[i] = i*2 end
print(a[9]) --> 18
a['x'] = 10
print(a['x']) --> 10
print(a['y']) --> nil
-- for k,v in pairs(a) do print(k .. ':' .. v) end

--[=[ Note the last line: like global vars, table fields evaluate to nil when they are
not initialized. also like global vars, I can assign nil to a table field to delete it. 
This is not a coincidence: Lua stores global vars in an ordinary table. I'll dive into that
in later chapters. 

To rep records, I use the field name as an index. Lua supports this representation by 
providing a.name as syntactic sugar for a['name']. So I can write the last lines of the 
previous example in a cleaner way as well
]=]
print()
a.x = 10 -- which is the same as a['x'] = 10
print(a.x)
print(a.y)

--[[
For lua the two forms are equivalent and can be intermixed freely; for a human reader,
each form may signal a different intention. The dot notation clearly shows that we are
using the table as a record, where we have some set of fixed, pre-defined keys. The string
notation gives the idea that the table may have any string as a key, adn that for some
reason we are manipulating that specific key.

A common mistake for beginners is to confuse a.x with a[x]. The first form represents
a['x'], that is a table indexed by the string 'x'. the second form is a table indexed
by whatever the value of the variable x is. 
]]
print()
a = {}
x = 'y'
a[x] = 10 -- put 10 in the field 'y'
print(a[x])
print(a.x) --> nil as field 'x' is undefined
print(a.y) --> value of field 'y' which is 10

--[[
To represent a conventional array or list, I simply use a table with integer keys.
There is neither a way nor a need to declare a size; I just start using the elements
I need. 
]]

--[[ COMMENTED CODE
-- read 10 lines storing them in a table
print()
print('Enter 10 lines here:')
a={}
for i=1,10 do
  a[i] = io.read()
end

-- since I can index a table with any value, I can start the indexes of an array with any
-- number that I want. however, it customary in lua to start arrays with 1 (an not with 0
-- as in most other langs)
-- In lua 5.1 the length operator '#' returns the last index (or the size) of an array or
-- list. Witht is functionality I print the lines read in the last example with the following

-- print the lines
for i=1,#a do
  print(a[i])
end
--]]

--[[
The length operator provides several common lua idioms or ways to use it to refactor 
the code. using '#a' in different ways for example to
  ▪ print the last value of the list 'a'
  ▪ remove the last value
  ▪ append something to the end of the array
  ▪ alternative ways to read into the array 'a[#a+1] = io.read()'
  ▪ etc.

Because an array is actually a table, the concept of its 'size' can be a bit fuzzy to
the new lua hacker. For example:
]]

-- what's the size of this?
print()
a = {}
a[10000] = 1

--[[
Remembering that any non-initialized index resuls in nil; lua uses this value as a sentinel
to find the end of the array. When the array has holes -- nil elements insid it -- the length 
operator may assume any of these nil elements as the end marker. Of course, this unpredictability
is hardly what I'm looking for in a production script. Therefore I will always avoid using the
length operator on arrays that may contain holes. Most arrays can't contain holes (for example
in the previous example a file line can't be nil) and, therefore, most of the time the use 
of '#' is safe. If I really need to handle arrays that may have holes up to their last index,
I can use the function table.maxn, which returns the largets numerical positive index of
a table:
]]

print(#a)
print(table.maxn(a))

--[[
Since I can index a table with any type, when indexing a table I have the same 
subtleties that arise in equality. Although I can index a tble both with the number 0 
and with the string '0', these two values are different (according to equality) and 
therefore denote different entries in a table. Similarly, the strings '+1','01', and '1'
all denote different entries. When in doubt about the actual types of my indices, I can 
use explicit conversion to be sure:
]]

i = 10; j = '10' ; k = '+10'
a = {}
a[i] = 'one value'
a[j] = 'another value'
a[k] = 'yet another value'
print()
print(a[j])
print(a[k])
print(a[tonumber(j)])
print(a[tonumber(k)])
-- NOT PAYING ATTENTION TO THIS CAN ENTER SUBTLE BUGS INTO MY PROGRAMS
