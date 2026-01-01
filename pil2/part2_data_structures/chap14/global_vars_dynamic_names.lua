--[[
Chapter 14 - THE ENVIRONMENT

This is again going to  be a key chapter for me as I need to review and understand
more about the global vs local environment. So here we go...

Lua keeps all its global variables in a regular table, (surprise surprise) called
'the environment'. (To be more precise, Lua keeps its 'global' variables in several
environments, but we'll ignore this multiplicity for now). One advantage of this
structure is that it simplifies the itnernal implementation of Lua, because there
is no need for a different data struture for global variables. The other (actually
the main) advantae is that we can manipulate this table just as any other table in 
lua. To facilitate such manipulations, lua stores the environment itself in a global
variable _G. 🤯 (Yes, _G._G is equal to _G). for example the following prints
all the global variables defined in the current environment. (And I did it already 
in the lua interpreter without even seeing that line. ) Lua is my language baby!!

In this chapter, we will see several useful techniques for manipulating the
environment.
]]
for n in pairs(_G) do print(n) end
print(#_G) -- but this prints 0 for the length. Is that due to to it being a proxy? 🤔🤔

--[[

14.1 - GLOBAL VARIABLES WITH DYNAMIC NAMES

Usually, assignment is enough for accessing and setting global variables. However,
often we need some form of meta-programming, such as when we need to manipulate a
global variable whose name is stored in another variable, or somehow computed at run
time. To get the value of this variable, many programmers are tempted to write
something like this

  -- value = loadstring('return ' .. varname)()

If varname is 'x', for example, the concatenation will result in 'return x', which
when run achieves the desired result. However, this code involves the creation and
compilation of a new chunk. We can accomplish the same effect with the following,
which is mroe than an order of magnitude more efficient than the previous

  value = _G[varname]

Because the environment is a regular table, we can simply index it with the desired
key (the variable name).

In a similar way, we can assign a value to a gloval variable whose name is dynamically
computed, writing

  _G[varname] = value

Beware, however, some programmers get a little excited with these facilities and end
up writing code like 

  _G['a'] = _G['var1']

...which is just a complicated way to write a=var1.

A generalization of the previous problem is to allow fields in the dynamic name,
such as 'io.read' or 'a.b.c.d'. If we write _G['io.read'], we don't get the read
field from the io table. But we can write a function getfield such that
getfield('io.read') returns the expected result. This function is mainly a loop,
which starts at _G and evolves field by field:
]]
function getfield(f)
  local v = _G      -- start with teh table of globals
  for w in string.gmatch(f,'[%w_]+') do
    v = v[w]
  end
  return v
end

--[[
We rely on gmatch, from the string library, to iterate over all words in f (where 
'word' is a sequence of one or more alphanumeric characters and underscores).

The corresponding function to set fields is a little more complex. An assignment
like a.b.c.d = v is equivalent to the following:

  local temp = a.b.c
  temp.d = v

That is, we must retrieve up to the last name and then handle it separately. The next
setfield function does the task, and also creates intermediate tables in a path
when they do not exist:
]]
function setfield(f,v)
  local t = _G          -- start with the table of globals
  for w,d in string.gmatch(f,'([%w_]+)(.?)') do
    if d=='.' then      -- not last field?
      t[w] = t[w] or {} -- create table if absent with default
      t = t[w]          -- get the table
    else                -- last field
      t[w] = v          -- do the assignment
    end
  end
end

--[[
This new pattern captures the field name in variable 'w' and an optional following
dot in variable d. if a field name is not followed by a dot, then its the last
name. 
]]
setfield('t.x.y',10)

-- creating a global table t, another table t.x, and assinging  10 to t.x.y
print();print(t.x.y)
print(getfield('t.x.y'))

