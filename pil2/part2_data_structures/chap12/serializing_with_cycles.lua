--[[
SAVING TABLES WTIH CYLCES

To handle tables with generic topology (i.e., with cycles and shared subtables)
we need a different approach. {}s can't represent  such tables, so won't be using
them. To represent cycles we need names, so our next function will get as args
the value to be saved plus its name. Moreover, we must keep track of the names
of the tables already saved, to reuse them when we detect a cycle. We will use
an extra table for this tracking. This table will have tables as indices and their
names as the associated values. 

The result code is below. We keep the restriction that the tables we want to save
have only strings and numbers as keys. The basic_serialize function serializes
these basic types, returning the result. The next function, 'save', does the 
hard work. The saved parameter is the table that keeps track of tables already
saved. 
]]
function basic_serialize(o)
  if type(o) == 'number' then
    return tostring(o)
  else    -- assume it is a string
    return string.format('%q',o)
  end
end

function save(name,value,saved)
  saved = saved or {}       -- initial default value
  io.write(name,' = ')
  if type(value) == 'number' or type(value) == 'string' then
    io.write(basic_serialize(value),'\n')
  elseif type(value) == 'table' then
    if saved[value] then    -- value already saved?
      io.write(saved[value],'\n') -- use its previous name
    else
      saved[value] = name         -- save name for next time
      io.write('{}\n')            -- create a new table
      for k,v in pairs(value) do  -- save its fields
        k = basic_serialize(k)
        local fname = string.format('%s[%s]',name,k)
        save(fname,v,saved)
      end
    end
  else
    error('cannot save a ' .. type(value))
  end
end

a = {x=1,y=2;{3,4,5}}
a[2] = a -- cycle
a.z = a[1] -- shared subtable
save('a',a);print()

--[[
The actual order of these assignments may vary, as it depends on a table traversal
Nevertheless, the algorithm ensures that any previous node needed in a new 
definition is already defined. 

If we want to save several values with shared parts, we can make the calls to 'save'
using the same 'saved' table. For instance, assume the following two tables:
]]
a = {{'one','two'},3}
b = {k = a[1]}

-- saving them independently, the result will not have common parts:
save('a',a);print()
save('b',b);print()

-- however if we use the same 'saved' table for both calls to save, then the result
-- will share common parts
local t = {}
save('a',a,t)
print()
save('b',b,t)

--[[
As is usual in lua, there are several other alternatives. Among them, we can save
a value without giving it a global name (instead, the chunk builds a local value
and returns it), we can handle functions (by building an auxiliary table that
associates each function to its name), and so one. Lua gives us the power; we
build the mechanisms. 
]]


