--[[
15.3 - USING ENVIRONMENTS

A major drawback of that basic method we used for creating modules is that it calls
for special attention from the programmer. We must qualify names when accessing other
public entities inside the same module. We have to change the calls whenever we 
change the status of a function from private to public (or from public to private).
Moreover, it is all too easy to forget a local in a private declaration.

Function environments offer an interesting technique for creating modules that solve
all of these problems. Once the module main chunk has an exclusive environment (its
own world to play in), not only all its functions share this table, but also all its
global variables go to this table. Therefore, we can declare all public functions as
global variables and they will go to a separate table automatically. All the module
has to do is to assign this table to the module name and also to package.loaded. The
next code fragement shows this technique change from what we last did
]]
--[[
local modname = ... -- this is the bit that facilitates our filename into our mod name
local m = {} -- This is creating our actual module table
_G[modname] = m -- this assigns our module table to our global env with our filename as
-- the key
package.loaded[modname] = m  -- This sets our mod in package.loaded, so we don't have to
-- worry about returning it
setfenv(1,m) -- this is the change. Setting the current environment over to our m table

-- now when we declare a function 'globally' it automatically goes to our 
-- filename.function (i.e., below would now be filename.add)
function add(c1,c2)
  -- <our normal code from before
end
--]]

--[[
Moreover we can call other functions from the same module without any prefix as. 
For instance, above add would use 'new' rather than m.new, etc as it gets it from
its environment, that is, it gets complex.new from its creating function. 

This method offers a good support for modules, with little extra work for the progrmmer.
It needs no prefixes at all. There is no difference between calling an exported and a 
private function. If the programmer forgets a local, he doesn't pollute the global
namespace; instead, a private function simply becomes public.

So what's missing with this version? Of course, access to other modules. Once we make the
empty table m our environment, we lose access to all previous global variables. 
There are several ways to recover this access, each with their own pros and cons.
The simplest solution is inheritance, as we saw earlier:
]]

--[[
local modname=...
local m={}
_G[modname]=m
package.loaded[modname]=m
setmetatable(m,{__index=_G}) -- and we do this link up prior to linking setting our env
setfenv(1,m)
--]]
--[[
As I mentioned, we need to call setmetatable before calling setfenv. Also since with this
construction the module has direct access to any global indentifier, paying a small
overhead for each access. A funny consequence of this solution is that, conceptually
our module now contains all global variables. So for example, someone using our module
may call the standard 'sine' function by writing 'filename.math.sin(x)' (Perl's package
system has the same peculiarity). 

Another quick method of accessing other modules is to declare a local that holds the
old environment aparte:
]]
--[[
local modname=...
local m={}
_G[modname]=m
package.loaded[modname]=m
local _G=_G
setfenv(1,m)
--]]
--[[
Now with this version, we need to prefix any global-variables with _G., but the access
is a little faster since there is no metamethod involved.

A more disciplined approach is to declare as locals only the functions that we need,
or at most the modules that we need:
]]
---[[
-- module setup
local modname=...
local m={}
_G[modname]=m
package.loaded[modname]=m

-- import section:
-- declare everything this module needs from outside (locals are also faster)
local sqrt = math.sqrt
local io = io

-- no more external access after this point
setfenv(1,m)

--]]
--[[
This technique demands more  work, but it documents the module dependencies better
(and from what I can tell many of the builtin modules use this method as well).
It also results, as mentioned, in code that runs faster than code with the
previous schemes.
]]





