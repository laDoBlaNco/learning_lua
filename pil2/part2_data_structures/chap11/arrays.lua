--[[
Chapter 11 DATA STRUCTURES
(This is a key chapter, part, of the book, so I'm going to be typing in detail for 
this one)
So, as I've heard, Tables in lua are not A data structure; they are THE data structure.

All structures that other languages offer -- arrays, records(maps/dicts), lists, queues,
sets -- can be represented with tables in lua. More to the point, lua tables implement
all these structures efficiently.

In traditional languages, such as C, Python, JS, etc, we implement most data structures 
with arrays and lists (where lists = records + pointers). Although we can implement 
arrays and lists using lua tables (and sometimes we do this), tables are more powerful
than arrays and lists; many algorithms are simplified to the point of triviality with
the use of tables. For example, we seldom write a search in lua, since tables offer
direct access to any type 🤓🤯.  

It takes a while to learn how to use tables efficiently. Here, we'll see how to
implement typical data structures with tables and will also see some examples
of their use. We'll start with arrays and lists, not because we need them for 
the other structures, but because most programmers are already familiar with
them. We've already seen the basics of this material in the chapters about the
language, but we'll repeat some concepts for completeness.

11.1 ARRAYS
So we implement arrays in lua simply by indexing tables with ints. Therefore,
arrays do not have fixed sizes, but grow as needed. usually, when we initialize
the array we define its size indireclty. For instance, after the following code
any attempt to access a field outside the range 1-1000 will return nil, instead
of zero:
--]]

a = {} -- new array
for i=1,1000 do a[i]=0 end

-- the length operator (#) uses this fact to find the size of an array
print(#a);print()

-- we can also start an array at index 0,1 or any other integer value
-- here we have an array starting at index -5
a = {}
for i=-5,5 do a[i] = 0 end

--[[
However, it is customary in lua to start with the index 1. The lua libraries adhere to this
convention; so does the length operator. If our arrays don't start with 1, then we can't
really use these tools
--]]
print(#a);print() -- gives us the wrong length

-- we can use a constructor ({}) to create and intialize arrays in a single expression
-- as expected
squares = {1,4,9,16,25, 36, 40, 86, 81}

-- such constructors can be as large as we need (well at least up to a few million
-- elements)


