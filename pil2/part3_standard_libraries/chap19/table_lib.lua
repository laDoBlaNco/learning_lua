--[[
Chapter 19 - THE TABLE LIBRARY

The table library comprises auxiliary functions to manipulate tables as arrays.
It provides functions to insert and remove elements from lists, to sort the
elements of an array, and to concatenate all strings in an array.

19.1 - INSERT AND REMOVE

The table.insert function inserts an element in a given position of an array (table)
moving up other elements to open space. For instance, if t is the array {10,20,30},
after the call table.insert(t,1,15), t will be {15,10,20,30}. As a special (and
frequent) case, if we call insert WITHOUT a position, it inserts the element in the
LAST position of the array (and therefore, moves no elements). As an example, the
following code reads the program input line by line, storing all lines in an array:
]]

---[[
t = {}
for line in io.lines() do
  table.insert(t,line)
end
print(#t) --> number of lines read
--]]
--[[
(In Lua 5.0 this idiom was common, but now in lua 5.1, the author prefers the following
t[#t+1]=line to append elements to a list)

The table.remove function removes (and returns) an element from a given position
in an array, moving down other elements to close space. When called without a 
position, it removes the last element of the array. (so the opposite of .insert)

With these two functions, it is straightforward to implement stacks, queues, and
double queues. We can 

  • initialize such structures as t={}. 
  • a push operation would be table.insert(t,x)
  • a pop operation would be table.remove(t)
  • inserting at the end of the structure would be table.insert(t,1,x) (actually its beginning)
  • and removing from the end is table.remove(t,1)

The last two operations are not particularly efficient, as they must move elements
up and down (so they are O(n)) However, because the table library implements these
functions in C, these loops are not too expensive, so that this implementation is
good enough for small arrays (up to some hundred elements or so)
]]


