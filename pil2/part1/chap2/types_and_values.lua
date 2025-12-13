--[[
CHAPTER 2 TYPES AND VALUES
]]

-- there are 8 basic types in lua
-- nil, boolean, number, string, userdata, function, thread, and table
print(type('hello world')) --> string
print(type(10.4*3)) --> number
print(type(print)) --> function
print(type(type)) --> function
print(type(true)) --> boolean
print(type(nil)) --> nil
X = 123
print(type(type(X))) --> string since result of type function is string

-- any variable can contain any type
print()
print(type(a))
a=10
print(type(a))
a='a string'
print(type(a))
a=print -- yeap this is valid, functions are first class values
a(type(a))
print()

-- Nil - nil has a single value of nil and is different from any other value

-- booleans are false and true. Both nil and false are false and EVERYTHING ELSE
-- is true. Meaning both 0 and '' are true

-- numbers - represent real (double floating point) numbers. lua 5.1 has no
-- integer type, those new lua versions do. 
-- i can write numeric constants with optional decimal part
print(4)
print(0.4)
print(4.57e-3)
print(0.3e12)
print(5e+20)
print()

-- strings - a sequence of chars that may contain chars with any numeric code.
-- meaning that I can store any binary data into a string. they are immutable.
-- a new string is created
a = 'one string'
b = string.gsub(a,'one','another') -- change string parts
print(a) -- still the original string
print(b) -- a new string returned to b
print()

-- use of normal c-like escape sequences
print("one line\nnext line\n\"in quotes\", 'in quotes'")
print('a backlash inside quotes: \'\\\'')
print("a simpler way: '\\'")
print()

-- using escape sequence with char codes
print('\97lo\10\04923"') -- \97 for a, \10 for newline, \049 for 1 
print()

-- delimiting literal strings with [[]]
page = [[
<html>
<head>
<title>An HTML Page</title>
</head>
<body>
<a href="http://www.lua.org">Lua</a>
</body>
</html>
]]

print(page)
print()

-- if I need to adjust the [[]] for text classes I can add ==s
print([==[
This also
works
]==])
print()

-- same works for comments so we can have comments embedded in comments
--[=[
this is 
commented out
]=]

-- any numeric operation applied to a string tries to convert the string
-- to a number
print('10'+1)
print('10 + 1')
print('-5.3e-10'*'2')
-- print('hello' + 1) ERROR: attempt to perform arithmetic on a string value
print()

-- lua does this anywhere a number is expected
-- and if lua finds a number where it expects a string -- here string concatentation
print(10 .. 20) -- must be separated by spaces or lua thinks its a decimal
print(type(10 .. 20))
print()

--[[
-- but its better not to use them as they enter uneeded complexity
line = io.read() -- read a line
n = tonumber(line) -- try to convert it to a number
if n == nil then
  error(line .. " is not a valid number")
else
  print(n*2)
end
]]

-- number to string using tostring or concat to ''
print(tostring(10)=='10')
print(10 ..'' == '10')
print()

-- using the length operator '#'
a = 'hello'
print(#a)
print(#'good\0bye')
print()

-- tables - associative arrays in lua that can be indexed not only
-- by numbers, but also with strings or any other value in the language
-- except nil, making it the lua work horse. They are the main (in fact
-- the only) data structuring mechanism in lua. They rep arrays, 
-- symbol tables, sets, records, queues, and any other data structure
-- that I may need. In lua I can use them to rep modules, packages, and
-- objects as well. For example, io.read means 'the read function from
-- the io module'. For lua this means 'index the table io using the
-- string "read" as the key'

-- In Lua tables are neither values nor variables; they are objects.
-- A lua table is like a dynamically allocated object; my program will
-- manipulate only references (or pointers) to them. There are no
-- hidden copies or creation of new tables behind the scenes. Moreover,
-- I don't have to DECLARE a table in lua; in fact I can't. Tables are
-- created using a constructor expression, which in its simplist form
-- is simply {} 

a = {} -- creates a table and stores its reference in 'a'
k = 'x'
a[k] = 10 -- new entry, with key='x' and value=10
a[20] = 'great' -- new entry, with key=20 and value='great'
print(a['x'])
k=20
print(a[k])
a['x'] = a['x']+1
print(a['x'])
print()

-- A table is always anonymous. there is no fixed relationship between
-- a variable that holds a table and the table itself
a = {}
a['x'] = 10
b = a -- here 'b' refers to teh same table as 'a'
print(b['x'])
b['x'] = 20
print(a['x'])
a = nil -- only 'b' still refers to the table
b = nil -- no more references left to the table
print()
-- when a program has no more references to a table left, lua's garbage 
-- collector will eventually delete the table and reuse its memory.
-- Each table may store values with different types of indices, and it
-- grows as needed to accommodate new entries:
a = {} -- empty table
-- create 1000 new entries
for i=1,1000 do a[i]=i*2 end
print(a[9])
a['x'] = 10
print(a['x'])
print(a['y'])
print()
-- like global variables, table fields evaluate to nil when they aren't 
-- initialized. Also like global vars, I can assign nil to a table field
-- to delete it. This is because lua stores global variablves in ordinary
-- tables. 

-- For records, I use the field names for the index. (this sounds like a 
-- map in other languages). lua supports this representation by using
-- a.name as syntactic sugar for a['name']. 
a.x= 10 -- same as a['x'] = 10 (OJO not a[x])
print(a.x)
print(a.y)
print()

a={}
x='y'
a[x] = 10
print(a[x])
print(a.x) -- nil since there is no a['x'] and a.x = a['x'] 
print(a.y) -- this is a['y'] which does exist since x is var for 'y'
print()

-- a conventional array or list simply a table with integer keys
-- read 3 lines storing them in a table
a = {}
for i=1,3 do
  a[i] = io.read()
 end

print(a) -- just prints the pointer address
print()

-- we can use any number to start our array but the lua convent is 1-indexed
-- arrays
-- since # assmes that its 1-indexed, it'll give an incorrect result if not
-- print the lines
for i=1,#a do
  print(a[i])
end
print()

-- as mentioned above since an array is just a table, the concept of its 'size'
-- is a bit fuzzy. For example
a = {}
a[10000] = 1 -- what's the size of this?

--[[
Remember that any non-initialized index results in nil; lua uses this value
as a sentinel to find the end of an array. when the array has 'holes' -- nil
elements inside it -- the length operator may assume any of these nil elements
as the end marker. Of course, this unpredictability is hardly what I want.
Therefore, I should avoid using the length operator on arrays that may have 
holes. Most arrays can't contain holes, and therefore, most of the time the
use of the length operator is fine. If I need to handle arrays with holes
up to their last index, I can sue the table function table.maxn which 
returns the largest numerical positive index
]]
print(table.maxn(a))

--[[
Since I can index a table with any type, when indexing a table I have the
same subtleties that arise in equality. Although I can index a table both
with the number 0 and with the string '0', these two values are different
(according to equality) and therefore denote different entries in a 
table. Similarly the strings '+1', '01', and '1' are all different 
entries. 
]]
print()
i=10;j='10';k='+10'
a = {}
a[i] = 'one value'
a[j] = 'another value'
a[k] = 'yet another value'
print(a[j])
print(a[k])
print(a[tonumber(j)])
print(a[tonumber(k)])
-- not noting this will enter subtle bugs into my scripts

--[[
functions - first class values in lua. This means that functions can be
stored in variables, passed as args to other functions, and returned as
results. Such facilities give great flexibility, to the language: a program
may redefine a fucntion to add new functionality, or simply erase a
function to create a secure environment when running a piece of untrusted
code. Moreover, lua offers good support for functional programming, 
including nested functions with proper lexical scoping. finally, first-class
functions play a key role in lua's object-oriented facilities. 

Lua can call functions written in lua or in C. All the standard libraries
in lua are actually written in C. They comprise of functions for string
manipulation, table manipulation, I/O, access to basic operating system
facilities, mathematical functions, and debugging. Application programs
may define other functions in C as well. ]]

--[[
Userdata and Threads - The userdata type allows arbitrary c data to be
stored in lua variables. It has no predefined operations in lua, except
assignment and equality testing. Userdata are used to represent new
types created by an application program ro a library (like typedefs???)
written in c; for instance, the standard I/O library uses them to
represent files. I'll see them in later chapters. 

I'll also see Threads in the chapter with Coroutines. 
]]


