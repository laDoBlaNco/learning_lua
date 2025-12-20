--[[
V - TRUE ITERATORS

It is strange that we've been calling these iterator functions, iterators even though
they don't actually do the iteration., the generic for loop does. The iterator function
just determines what value to return next, the generic for loop uses it to do the
iteration. Taht's why the lua PiL preferes to give the iterator name to the generic
for loop. Wwould we name the previously-named iterator function then? Well lua PiL
likes to call them GENERATORS, since they generate the next value, and this 
naming convention is present in many other languages (e.g. python's generators
or generator functions)

Also at a certain point in lua, generic for loops didn't yet exist. You had to use
table.foreach (table.foreach exists as well which is equivalent to ipairs).
Essentially it taks two parameters, the table to iterate through, and a function
to apply to each element. So if you had something arbitary like this in
the modern lua
]]
local myTable = {1,2,3,4,5,6,7,8,9,10,33,56,76,45,33,2,5,3}
for i,v in pairs(myTable) do
  if v>10 then
    print(tostring(v)..' is greater than 10')
  else
    print(tostring(v)..' is less than 10')
  end
end
print()

--[[
This almost looks like the body of the floor loop is a function where each element
is passed as an argument to that function each time. If I were to write this using
table.foreach, I would do this
]]
local function f(i,v)
  if v > 10 then
    print(tostring(v)..' is greater than 10')
  elseif v == 10 then
    print(tostring(v)..' is equal to 10')
  else
    print(tostring(v)..' is less than 10')
  end
end

table.foreach(myTable,f)

--[[
table.foreach does the iteration on its own. It doesn't need a for loop to do so. 
Cool right? Fore tha reason table.foreach and table.foreachi are called TRUE iterators
they are actual iterators that do the iteration on their own, unlike the iterators
we have been talking about this whole time that are actually just plugged into a
generic for loop.
]]

--[[
So in summary, when is iterator creation usefull in the real world?

There are mostly two cases, if you want a special way to parse a table that follows
a certain format.
for example if your table looks like {{name='hi',rarity=5},{name=8,rarity=6}}, say 
you want to only loop through the names of these items. You can make an iterator 
for that specifically, although personally this is a trivial example and you could
just loop through the items and index the name. But for more complicated tables
this is a nice idea.

Another interesting use case is maybe extracting other things from a piece of info
and looping through it. Say you want to generate all the permutations that a string 
of characters can have (e.g. an iterator permutations() that given 'abc' would make
you loop through 'abc','acb','cab','cba','bca','bac'), You can make an iterator for
this as well. This is a kind of niche use case.
]]