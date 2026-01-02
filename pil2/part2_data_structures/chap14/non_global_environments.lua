--[[
14.3 - NON-GLOBAL ENVIRONMENTS

One of the problems that we have with the lua environment table is that it IS global. Any
modification we do on it affects all parts of our program. For example, when we 
install a metatable to control global access, our whole program must  follow the 
guidelines since the metatable is added to the global table or the global lua world. 
If we want to use a library that uses global variables without declaring them, we are 
out of luck. 

Lua 5 ameliorated (fixed) this problem by allowing each function to have its own environment,
wherein it looks for global variables. 

  • Again, looking to Google for a little clarification, Lua 4 introduced full lexical
    scoping and a global environment as a table (_G) as we've seen here, simplifying
    implementation. But Lua 5 enhanced this with ENVIRONMENT TABLES ATTACHED TO
    FUNCTIONS, allowing isolated global namespaces for better modularity (like with
    require), making lua 5's scoping more powerful and controlled for library
    management compared to lua 4's simpler, single global environment. Lua 4 primarily
    focused on making globals manageable, while lua 5 REFINED scope control with
    environment-specific globals for functions. 

    • So in Lua 5 functiosn can have their own environment tables, separate from _G,
      where their global lookups occur, enabling sandboxing and clearer module 
      boundaries. 
    • The require function uses these new environment tables to load modules in 
      isolated scopes, preventing library variables from polluting the main _G table.
    • Local variables in lua 5 are highly optimized (often in registers), leading to
      faster access than globals. 

This facility may sound strange at first; after all, the goal of a table of global 
variables is for it to BE global. However, in section 15.3, we will see that this 
facility allows several interesting constructions, where global values are still 
available everywhere even they we now have multiple environment tables.

We can change the environment of a single function with the setfenv function (set function
environment). It takes as arguments the function and the new environment. Instead
of the function itself, we can also give a number, meaning the active function at
that given stack level. Number 1 means the current function, number 2 means the
function calling the current function (which is handy to write auxiliary functions
that change the environment of their caller) similar to the concept of levels of blame
when working with 'error', and so on.

A naive first attempt to use setfenv fails miserably. The code would be:
]]
-- local _ENV = require('std.strict')(_G) -- I also installed the normal file
require 'strict' -- which I'll use for simplicty sake for now as long as it works

a = 1 -- here we create a global
-- then we change the current environment to a new empty table
-- setfenv(1,{})
-- print(a) -- error: attempt to call global 'print' (a nil value)

--[[
(This must be run in a single chunk because if we try to run it in the interpreter
each line is a different function and the call to setfenv affects only its line.) Once
we change our environment, all global accesses will use the new table. If its empty,
then we've lost all our normal global variables (and even _G) 🤔🤯. So we need to 
first populate the new environment with some useful values, such as the old environment
]]
--[[
setfenv(1,{g = _G}) -- change current env
g.print(a) --> gives us nil
g.print(g.a) --> gives us what want, but not HOW we want
--]]


-- Now now we can rewrite this using _G instead of g
--[[
setfenv(1,{_G=_G})
_G.print(a)
_G.print(_G.a)
--]]

--[[
For lua, _G is a name like any other. Its only special status happens when lua
creates the initial global table and ASSIGNS this table to the global variable _G.
Lua doesn't care about the current value of this variable; setfenv doesn't set it
in new environments. But it is customary to use this same name whenever we have a
reference to the initial global table, as we did in the rewritten example above.

Another way to populate our new environment is with "inheritance": (which I'll 
hopefully understand way more in the next chapters)
]]
---[[
local newgt = {}    -- create the new environment
setmetatable(newgt,{__index=_G}) -- setting global _G as our metatable of the new env
setfenv(1,newgt)  -- now set the current environment to our new environment
print(a) -- and it all works
--]]
--[[
In this code, the new environment "inherits" both 'print' and 'a' from the old one.
Nevertheless, any assignment goes to the new table. There is no danger of changing
a really global variable by mistake, although we could if we wanted to through _G
]]
---[[
-- continued from previous code
a = 10
print(a)
print(_G.a) -- global 'a' doesn't change, just shadowed in this new environment
_G.a = 20 -- but we can access it to change it, which is probably not ideal
print(_G.a)
--]]

--[[
Each function, or more specifically each closure, has an independent environment.
The next chunk, for example, illustrates this
]]
function factory()
  return function()
    return a -- the global 'a'
  end
end

a = 3
f1 = factory()
f2 = factory()
print()
print(f1())
print(f2())
print()

setfenv(f1,{a=10})
print(f1())
print(f2())
print()

--[[
The factory function creates simple closures that return the value of their global
'a'. Each call to factory creates a new closure (universe, world, environment) with
its own environment. When we create a new function, it "inherits" its environment
from the function creating it. (and since everything is a function call, from the
main chunk down it simple trickles down). So when created, these closures share
the environment they were created in where the value of 'a' is 3. The call
'setfenv(f1,{a=10})' changs the environment of 'f1' to a new environment table
where 'a' is 10, without impacting the environment of f2 or the environment they
were both created in. 🤯🤯🤯

(I know has to do with why local and global work they way they do and why certain
things are accessible and others aren't as I was getting confused about and going
to deep dive into. But its getting clearer and clearer with each chapter. In a nutshell
since the environments are inherted down with each chunk created in each chunk, the
'global' vars declared are also inherited and typically doesn't matter  if they are
referenced before or after in that ineherited environment. But if they are 'local'
then the order  matters. They can't be referenced prior to their declaration. There's
definitely more detail, but its a lot clearer as to what's happening when using local
vs not.)

Because new functions inherit their environments from teh function creating them,
if a chunk changes its own environment (setfenv), all functions it defines afterward
will share this NEW environment. This is a useful mechanism for creating namespaces,
as we'll see moving forward in the next chapter. 
]]
--[[

function tester()
  print(test)
end
-- tester() -- but trying to run it even before even the global version won't work

-- local test = 69 -- this errors because its declared after its use in tester() declaration
test = 69 -- this works as its global and the global environment is inherited into function
-- declaration so the order doesn't matter. 
tester() -- so in the end even with globals, order does impact to a point. 
--]]






