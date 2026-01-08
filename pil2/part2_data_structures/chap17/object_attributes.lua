--[[
17.2 - OBJECT ATTRIBUTES

So another important use of weak tables is to associate attributes with objects.
There are endless situations where we need to attach some attribute to an objet:
Names to functions, default values to tables, size to arrays, etc

When the object is a table, we can store the attribute in the table itself, with
the appropriate unique keys. As we saw before, a simple and error-proof way to 
create a unique key is to create a new object (typically a table) and us it as
the key. However, if the object is not a table, it can't keep its own attributes
through keys. Even for tables, sometimes we may not want to store the attribute in
the original object. For example, ewe may want to keep the attribute private, or
we don't want the attribute to disturb a table traversal. In all these cases, we
need an alternative way to associate attributes to objects. Of course, an external
table provides an ideal way to associate attributes to objects (it is not by chance
that tables are sometimes called 'associative arrays'). We use the objects as keys,
and their attributes as values. An external table can keep attributes of any type 
of object, as lua allows us to use any type of object as a key. Moreover, attibutes
kept in an external table don't interfere with other objects, and can be as private
as the table itself.

However, this seemingly perfect solution has a huge drawback: once we use an object
as a key in a table, we lock the object into existence. Lua can't collect an object
that is being used as a key. If we use a regular table to associate funtions to 
their names, none of these functions will ever be collected. As we might expect, we
can avoid this drawback by using weak tables. This time, however, we need weak keys.
The use of weak keys doesn't prevent any key from being collected, once there are no
other references to it. On the other hand, the table can't have weak values; otherwise,
attributes of live objects could be collected. (This seems very much like the first
use of weak tables. So not sure up until now is this is an IMPORTANT SECOND USE)


]]
