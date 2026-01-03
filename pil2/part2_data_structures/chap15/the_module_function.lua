--[[
15.4 - THE MODULE FUNCTIONS

So its obviously noticeable the repitiions of code in these previous examples. All
of them start with the same pattern

  local modname=...
  local m={}
  _G[modname]=m
  package.loaded[modname]=m
    <our setup for external access (sea inheritance, locals, etc)
  setfenv(1,m)

So as of lua5.1 we have the new function called 'module' that packs all of this
functionality together. Instead of the previous setups we've done, we can simply
start our modules with ...
]]
module(...)

--[[
This call creates a new table, assigns it to the appropriate global variable and to
the loaded table, and then sets the table as the environment of the main chunk.

By default, module doesn't provide external access, so we need to declare appropriate
local variables (the last example we saw) with the external functions or modules that
we want to access. We an also use inheritance for external access adding the option
package.seeall to the call to module. This option does the same as 

  setmetatable(m,{__index=_G})

So the call would now be the following, if we wanted to inherit everything

  module(...,package.seeall)

This at the beginning of the file turns it into a module. We can then write whatever 
lua code without the need to qualify neither module names nor external names. Also no
need to write the module name (in fact we don't even need to know the module name). 
We don't worry about returning the module table either. All we have to do is add that
single statement at the top and we have a module.  (Again, Roberto likes to get all
the detail before telling me the easy  real-world way of doing it. Which is fine
as I'll probably see lots of the detail in code in the real-world as well.)

The module function provides some extra facilities as well. Most modules don't need 
these facilities, but some distributions need some special treatment (e.g., to create
module that contains both C functions and lua functions). Before creating the
module table, 'module' checks whether the package.loaded already contains a table 
for this module, or whether a variable with the given name already exists. If it
finds a table in one of these places, 'module' reuses this table for the module;
this menas we can use 'module' for reopening a module arleady created. If the 
module doesn't exist yet, then 'module' creates the table. After that, it populates
the table with some predefined variables:

  • _M contains the module table itself (its an equivalent of _G);
  • _NAME contains the module name (the first argument  passed to module);
  • _PACKAGE contains the package name (the name without the last component, more on 
    this in the next section)
]]


