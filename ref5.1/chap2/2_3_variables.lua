--[[
2.3 - VARIABLES

Variables are places that store values. Thre are 3 kinds of variables in lua:
▫️ global vars
▫️ local vars
▫️ table fields

A single name can defnote a global var or a local var (or a function's formal parameter, 
which is a particular kind of local var):
  var ::= name
name denotes an identifier

Any variable is assumed to be global unless explicitly declared as local. Local variables
are lexically scoped: local variables can be freely accessed by functions defined inside
their scope

Before the  first assignment to a variable its value is nil

Square brackets are used to index a table:
  var ::= prefexexp[exp]

The meaning of accesses to global variables and table fields can be changed via metatables.
an access to an indexed variable t[i] is equivalent to a call gettable_event(t,i) This function
isn't defined or callable in lua, we use it for explanatory purposes only.

The syntax var.name is just syntactic sugar for var['name']
  var ::= prefixexp.name

All global vars live as fields in ordinary lua tables, call environment tables or simply 
environments. Each function has its own reference to an environment, so that all global
variables in this function will refer to this environment table. When a function is created,
it inherits the environment from the function that created it. To get the environment table
of a lua function, you call getfenv. To replace it, you call setfenv. 

An access to a global variable x is equivalent to _env.x which in turn is equivalent to
  gettable_event(_env,'x')

where _env is the environmental of the running function. These functions are only used here as
examples, they aren't defined in lua.

]]