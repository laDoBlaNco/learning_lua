--[[
Chapter 17 - WEAK TABLES

As we know, lua does automatic memory management. A program only creates objects
(tables, functions, etc); there is no function to delete objects. Lua automatically
deletes objects that become garbage, using garbage collection. This frees us from
most of the burden of memory management and, more important, frees us from most
of teh bugs related to this activity, such as dangling pointers and memory
leaks.

Unlike some other collectors, lua's gc has no problems with cycles. We don't
need to take any special action when using cyclic data structures; they are
collected like any other data.

  (Just for reference accoring to Google, cyclic data structures are where elements
  link back to form a closed loop or ring, meaning we can traverse from point and
  eventually return to it, unlike a simple chain that ends in null. Examples include
  circular linked lists (last node points to the first) and graphs with cycles (a path
  leads back to its starting node), often seen in complex object references where 
  objects point to each other, creating circular dependencies. These structures require
  special handling and tracking in most cases, to prevent infinite loops, but apparently
  that's not the case with Lua)

Nevertheless, sometimes even the smarter collector needs our help. No garbage collector
allows us to forget all worries about memory management. None are perfect.

A gc can collect only what it can be sure is garbage; it can't guess what is considered
garbage. A typical example is a stack, implemented with an array and an index to the
top. We know that the valid part of the array does only up to the top, but Lua
doesn't know that. If we pop an element by simple decrementing the top, the object
left in the array isn't garbage for Lua. Similarly, any object stored in a global variable
isn't garbage for lua, even if our program will never use it again. In both cases, its up 
to us (i.e., our program) to assign nil to these positions so taht they don't lock an
otherwise free object. 

However, simply cleaning our references isn't always enough. some constructions need
extra collaboration between the program and the gc. A typical exaample happens when
we want to keep a collection of all live objects of some kind (e.g., files) in our
program. This task seems simple: all we have to do is insert each new object into the
collection, right? However, once the object is inside the collection, it will NEVER be
collected. Even if no one else points to it, the collection will have the reference
and thus always be pointing to it.  Lua can't know  that this reference shouldn't
prevent the reclamation of the object, unless we tell it so.

Weak tables are the mechanism that we use to tell lua that a reference shouldn't
prevent the reclamation of an object. A 'weak reference' is a reference point to
an object that is not considered by the garbage collector. If all references
pointing to an object are weak, the object is collected and somehow these weak
references are deleted. Lua implements weak references with weak tables:

  A weak table is a table whose entries are weak.🤔🤔 This means that there 
  are three kinds of weak tables:

    1. tables with weak keys
    2. tables with weak values
    3. fully weak tables (where both keys and values are weak)

    Regardless of which of these 3 we are dealing with, when a key or value is
    collected the whole entry disappears from the table. 

The weakness of a table is given by the field __mode of its metatable. The value
of this field, when present, should be a string: if this string contains the letter
'k', the keys in teh table are weak; if this string contians the letter 'v', the values
in this table are weak. The following example, although artificial, illustrates the
basic idea of weak tables:
]]
a = {}
b = {__mode='k'}
setmetatable(a,b)  -- so now 'a' has weak keys
key = {}
a[key] = 1
key = {}
a[key]=2
collectgarbage()  -- this forces a garbage collection in Lua
for k,v in pairs(a) do print(v) end

--[[
So in this example, the second assignment keys={} overwrites the first key. When the
collector runs, there is no other reference to teh first key, so it is collected
and the corresponding value is also removed. The second key, however, is still
anchored in variable key, so it is not collected. 

Notice that only objects can be collected from weak tables. Values, such as numbers
and booleans, are not collectable. For instance, if we insert a numeric key in a table
'a', it will never be removed by the gc. Of course, if the value corresponding to
a numeric key is collected, then the whole entry is removed from the table  as well. 

Strings present a subtlety here: although strings ARE collectible, from an implementation
point of view, they are not like other collectible objects. Other objects, such as tables 
and functions, are created explicitly. For instance, whenever lua evaluates the 
expression {}, it creates a new table. Whenever it evaluates function() ... end,
it creates a new function (a closure actually). However, does lua create a new string
when it evalutes 'a'..'b'? What if there is already a string 'ab' in the system? Does
lua create a new one? Can the compiler create this string before running the program?
It doesn't really matter: These are implementation details. From the programmer's point
of view, strings are values, not objects. Therefore, like a number or a boolean, a string
is not removed from weak tables (unless its associated value is collected)

]]

