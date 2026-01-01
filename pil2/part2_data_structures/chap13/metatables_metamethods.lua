--[[
Chapter 13 - METATABLES AND METAMETHODS

(THIS IS ANOTHER CHAPTER WHERE WE ARE GOING TO DIVE DEEP AND DO A LOT OF TYPE BECAUSE
JUST LIKE TABLES, METATABLES AND METAMETHODS ARE WHERE THE LUA MAGIC HAPPENS)

Usually, each value in lua has a quite predictable set of operations. We can add
nuambers, we can concatentate strings, we can insert key-value pairs into tables,
etc. But we can't add tables, we can't compare functions, and we can't call a
string.

Metatables allow us to change the behavior of a value when confronted with an undefined
operation. (Its lua's version of OOP or polymorphism). For example, using metatables, we
can define how lua comuts the expression a+b, where a and b are tables. Whenever lua
tries to add two tables, it checks whether either of them has a 'metatable'and whether
this  metatable has an __add field. If lua finds this field, it calls the corresponding
value -- the so-called 'metamethod', which should be a function -- to compute the sum.

All values in lua CAN have a metatable:

  • tables and userdata have individual metatables;
  • values of other types share one single metatable for all values of that type
    • In Lua 5.0, only tables and userdata could have metatables. 

Lua ALWAYS creates new tables WITHOUT metatables
]]
t = {}
print(getmetatable(t));print()

-- we can then 'setmetatable' to set OR change the metatable for any table:

t1 = {}
setmetatable(t,t1)
print(getmetatable(t)==t1);print()

--[[
All the following configurations are valid:
  • ANY table can be a metatable of ANY value;
  • a group of related tables can share a COMMON metatable, which describes their shared
    behavior;
  • a table can be its OWN metatable, describing its own individual behavior. 

From lua we can set the metatables ONLY of tables. To manipulate the metatables of values 
of other types WE MUST USE C CODE. (The main reason for this restriction is to curb 
excessive use of type-wide metatables. Experience with older versions of lua has shown
that those settings frequently lead to non-reusable code.) We'll see later in chapter 20
the string library sets a metatable for strings. All other types by default have no 
metatable.
]]
print(getmetatable('hi'));print()
print(getmetatable(10));print()

