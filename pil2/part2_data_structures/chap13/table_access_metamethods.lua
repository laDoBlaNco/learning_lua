--[[
13.4 - TABLE-ACCESS METAMETHODS

The metamethods for arithmetic and relational operators all define behavior
for otherwise erroneous situations. They do not change the normal behavior
of the language. But lua also offers a way to change the behavior of tables
for two normal situations:
  • the query and
  • modification

of absent fields in a table. 

THE __INDEX METAMETHOD
As we mentioned earlier, when we access an absent field in a table, the result is
nil. This is true, but it is not the whole truth. Actually, such accesses trigger
the interpreter to loo for an __index metamethod:
  • if there is no such method, as usually happens, then the result is nil
  • otherwise the metamethod will provide the result

The archetypal example here is INHERITANCE (though lua isn't OOP so it doesn't have
real inheritance). Suppose we want to create several tables describing windows. Each 
table must descibe several window parameters, such as position, size, color scheme, and
the like. All these parameters have default values and so we want to  build window 
objects giving only the NON-DEFAULT parameters. A first alternative is to provide
a constructor thta files in the absent fields itself, as we've done before. A second
alternative is to arrange for the new windows to "inherit" any absent field from a 
prototype window. First, we would declare the prototype and a constructor function,
which creates new windows sharing a metatable. (I don't like this double use of the
term 'constructor'. So lua has constructors ({}) and now 'constructor functions??🤔🤔)
]]

Window = {}     -- create a namespace (which again is just a table)
-- create a prototype with default values
Window.not_a_prototype = {x=0,y=0,width=100,height=100} -- does it have to be called 'prototype'? NO
Window.mt = {}      -- create a metatable
-- now let's declare a "constructor function"
function Window.new(o)
  setmetatable(o,Window.mt)
  return o
end

--[[
So I think this is an example of how lua builds on its simple  concepts. Technically we
could call our Set.new function from before a "constructor function" as it created '.new'
objects and it took care of setting the metatable.

We then defin the __index metamethod:
]]

Window.mt.__index = function(table,key)
  return Window.not_a_prototype[key]
end
-- so when Lua checks for a field with __index, if its found it'll return if from our
-- prototype. I don't think we need to use the word prototype, but I'll test here 
-- here in a bit. - and the answer is that the word prototype is just a convention

-- after this we can create a window and query it for an abseent field
local w = Window.new{x=10,y=20}
print(w.width); print()

--[[
Now when lua detects that 'w' doesn't have the requested field, but has a metatable
with an __index field, it calls the __index metamethod, with args w (the table) and
'width' (the absent key). The metamethod then indexes the prototype with the given
key and returns the result. 

The use of the __index metamethod for inheritance is so common that lua provides a 
shortcut. Despite the name, the __index metamethod doesn't need to be a function;
it can be a table, instead. When it is a function, lua calls it with the table
and the absent key as its args, as we've already seen. But when its a table, lua
redoes the access IN this table. Therefore, in our previous example, we could
just declare __index simply like this
]]
Window.mt.__index = Window.not_a_prototype
-- which I've seen before. and if I remember correctly it gets even easier with more
-- "shortcuts" but Roberto likes to give us the details behind it all first. 
--[[
Now when lua looks for the metatable's __index field, it finds the value of 
Window.not_a_prototype, which is another table. Consequently, lua repeats the access
in thsi table, that is, it executes the equivalent of the following code:

  Window.not_a_prototype['width'] 

Which is very "inheritance" or at least JS prototypal like. 

The use of a table as an __index metamethod provides a fast and simple way of 
implementing single  inheritance. A function, although more expensive, provides
more flexibiltiy; we can implement multiple inheritance, caching, and several
other variations. We'll discuss that more when we get to chapter 16.

when we want to access a table without invoking its __index metamethod, we use
the 'rawget' function. The call 'rawget(t,i)' does a rawdog access to table 't',
that is, a primitive access without considering metatables. Doing a raw access
will not speed up our code (the overhead of a function call kills any gains we
could have anyways), but sometimes we need it, as we'll see later. 

THE __NEWINDEX METAMETHOD

The __newindex metamethod does for table updates what __index does for table
accesses. When we assign a value to an absent index in a table, the interpreter
looks for a __newindex metamethod:
  • if there is one, it calls it instead of making the assignment
  • if the metamethod is a table, the interpreter does the assignment IN this table
    instead of the original one. 

Moreover, there is a raw function that allows us to bypass the metamethod. The
call 'rawset(t,k,v)' sets the value v associated with the key k in the table t 
without invoking any metamethods. 

The combined use of the __index and __newindex metamethods allows several powerful
constructs in lua, such as read-only tables, tables with default values, and 
inheritance for OOP. In this chapter we'll take a look at some of their uses,
but OOP has its own dedicated chapter. 

TABLES WITH DEFAULT VALUES

the default value of any field in a regular run of the mill table is 'nil'. It is
easy to change this default value with metatables 
]]
function set_default(t,d)
  local mt = {__index=function() return d end}
  setmetatable(t,mt)
end

tab = {x=10,y=20}
print(tab.x,tab.z)
set_default(tab,0)
print(tab.x,tab.z);print()

--[[
After the call to set_default, any access to an absent field in tab calls its __index
metamethod (instead of metatable), which returns zero (the value of d for this method)

The set_default function creates a new metatable (mt) for each table that needs a 
default value. This may be expensive if we have many tables that need default values.
However, the metatable has the default value d wired into its metamethod, so the
function can't use a single metatable for all tables. To allow the use of a single
metatable for tables with different default values, we can store the default value
of each table in the table itself, using an execlusive field. If we aren't worried
about name clashes, we can use a key like "---" for our exclusive field.
]]
local mt = {__index = function(t) return t.___ end}
function set_default(t,d)
  t.___ = d
  setmetatable(t,mt)
end

--[[
If we are worried about name clashes, its easy to ensure the uniqueness of this
special key. All we need is to create a new table and use IT as the key 🤓🤯
]]
local key = {} -- unique key
local mt = {__index = function(t) return t[key] end}
function set_default(t,d)
  t[key] = d
  setmetatable(t,mt)
end

--[[
An alternative approach for associating each table with its default value is to use
a separate table, where the indices are the tables and the values are their default
values. however, for the correct implementation of this approach we need a special
breed of table, call 'weak tables', and so we won't use it here; we'll return to 
that in Chapter 17.

Another alternative is to memoize metatables in order to reuse the same metatable for
tables with the same default. However, that also needs weak tables, so again, in 
Chapter 17



]]

