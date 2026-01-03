--[[
Chapter 15 - MODULES  AND PACKAGES
Usually, lua does not set policies. Instead, lua provides mechanisms that are 
powerful enough for groups of developers to implement the policies that best
suit them. However, this approach doesn't work well for modules. One of the main
goals of a module system is to allow different groups to share code. The lack of
a common policy impedes this sharing and that goal.

Starting with lua 5.1, lua DEFINES a set of policies for modules and packages
(a package being a collection of modules). These policies do not demand any
extra facility from the language; programmers can implement them using what we
have seen so far:
  • tables
  • functions
  • metatables
  • and environments

However, two important functions ease the adoption of these policies: 
  • 'require', for using modules
  • and 'module', for building modules. 

Programmers are free to re-implement these  functions with different policies. Of 
course, alternative impmlementations may lead to programs that cannot use foreign
modules and modules that can't be used by foreign programs. 

From the user point of view, a MODULE is a library that can be loaded through
'require' and that defines one single global name containing a table. Everything
that the module exports, such as functions and constants, it defines inside this
table, which works as a NAMESPACE. A well-behaved module also arranges for 
'require' to return this table. 🤔

An obvious benefit of using tables to implement modules is that we can manipulate
modules like any other table and use the whole power of Lua to create extra 
facilities. In MOST languages, modules are NOT first-class values (that is, they
can't be stored in variables, passed as arguments to functions, etc.), so those
languages need special mechanisms for each extra facility they want to offer
for modules. In Lua though, we get those extras for free.

For example, there are several ways for a user to call a function from a module.
The easiest being:

  require 'mod'
  mod.foo()

If preferred we can set a local name for it

  local m = require 'mod'
  m.foo()

or rename individual functions

  require 'mod'
  local f = mod.foo
  f()

The nice thing about these facilities is that they involve no explicit support from
the language. They use what the language already offers
]]

m = require 'mod' -- the first way above  doesn't work for some reason. Not a 
-- biggie. I'll come back to this when I figure out why.

m.foo()



