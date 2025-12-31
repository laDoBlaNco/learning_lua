--[[
SAVING TABLES WITHOUT CYCLES

So our next and harder task is to save tables. There are several ways to save
them, according to what restrictions we assume about the table structure. No
signle algorithm is appropriate for all cases. Simple tables not only need 
simpler algorithms, but the resulting files can be more aesthetic, too. 

Our first attempt is below. Despite its  simplicty, the function does a 
reasonable job. It even handles nested tables (that is, tables within
tables), as long as the table structure is a tree (that is, there are no
shared subtables and no cycles). In the context of saving (serializing) 
Lua tables, a cycle (or cirular reference) occurs when a table contains a
reference to itself, either directly or through a chain of other tables. 

  • Definition: a circular reference where table A points to table b and table
    b points back to table a.
  • Direct vs Indirect: A cycle can be a table containing itself as a field
    (t.self = t) or a more complex loop involving multiple sub-tables. 
  • Structure: Cycles represent 'generic topology' rather than a simple tree
    structure. 

Saving tables with cycles is significantly harder than savign simple 'tree-
like' tables. 

A small aesthetic improvement would be to indent occasional nested tables;
we can try it as an exercise. Also instead of assuming that all keys ina  table are
valid identifiers, if a table has numeric keys, or string keys which are not
syntatic valid lua identifiers, we would be in trouble. A simple way to solve for 
this is to change the line

  io.write(' ',k,' = ')

to

  io.write('  ['); serialize(k);io.write('] = ')

with this change, we improve  the robustness of our function, at the cost of the
aesthetics of the resulting file. 
]]
function serialize(o)
  if type(o) == 'number' then
    io.write(o)
  elseif type(o) == 'string' then
    io.write(string.format('%q',o))
  elseif type(o) == 'table' then
    io.write('{\n')
    for k,v in pairs(o) do
      io.write(' ',k,' = ')
      serialize(v)
      io.write(',\n')
    end
    io.write('}\n')
  else
    error('cannot serialize a ' .. type(o))
  end
end

