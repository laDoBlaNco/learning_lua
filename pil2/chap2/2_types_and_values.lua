--[[
2 - TYPES AND VALUES

So lua is a dyanmically typed language There are no type definitions such as in C in the
language; eavh value carries its own type.

There are 8 basic types in lua:
  ▪ nil
  ▪ boolean
  ▪ number
  ▪ string
  ▪ userdata
  ▪ function
  ▪ thread
  ▪ table

The 'type' function gives us the type name of a given value as a string
]]
print()
print(type('hello world')) --> string
print(type(10.4 * 3))      --> number
print(type(print))         --> function
print(type(type))          --> function
print(type(true))          --> boolean
print(type(nil))           --> nil
print(type(type(nil)))     --> string
print()

--[[
Variables have no predefined types; any variable may contain values of any type:
]]
print(type(a)) --> nil ('a' not initalized)
a = 10
print(type(a)) --> number
a = 'a string!!'
print(type(a)) --> string
a = print      -- yeap this will also work
a(type(a))     --> function
print()

--[[
Noticing those last two lines: functions are first-class values in lua; so I can manipulate
them like any other value. 

Usually, when I use a single varible for different types, the result is messy code. However,
there are times when the judicious use of this feature is helpful, for instance in the use
of nil to differentiate a normal return value from an abnormal condition. I've see that before 
in the wild.
]]



