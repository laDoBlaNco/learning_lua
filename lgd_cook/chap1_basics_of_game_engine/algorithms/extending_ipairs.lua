-- extending_ipairs.lua

--[[
The ipairs function in the lua language is used to iterate over entries in a sequence. this
means every entry must be defined by the pair of key and value, where the key is the integer
(the 'i' in ipairs) The main limitation of the ipairs function is that the keys must be
consecutive numbers.

You can modify the ipairs function so that you can successfully iterate over entries with
integer keys that aren't consecutive. This is commonly seen in 'sparse arrays'

In our recipe below we'll define our own iterator function which will return every entry
of a sparse array in a deterministic order. in this case, the iterator function can be
included in the code as a global function to accompany pairs and ipairs functionss; or
we can put it in a lua module file not to pollute the global env space.
]]

-- this is a very simple smarse array iterator, with no caching

local function iparis_sparse(t)
  -- tmpIndex will hold sorted indices, otherwise
  -- this iterator would be no different from pairs iterator
  local tmpIndex = {}
  local index, _ = next(t)
  while index do
    tmpIndex[#tmpIndex + 1] = index
    index, _ = next(t, index)
  end
  -- sort table indices
  table.sort(tmpIndex)
  local j = 1

  return function()
    -- get index value
    local i = tmpIndex[j]
    j = j + 1
    if i then
      return i, t[i]
    end
  end
end

-- now let's see some usage examples
-- table below contains unsorted sparse array
local t = {
  [10] = 'a', [2] = 'b', [5] = 'c', [100] = 'd', [99] = 'e',
}
-- iterate over entries
for i,v in iparis_sparse(t) do
  print(i,v)
end

--[[
How it works...

The lua language uses iterator functions in the control structure called the 'generic for'.
The 'generic for' calls the iterator function for each new iteration and stops when the 
iterator function returns nil. The iparis_sparse function works in the following steps:
  ▫️ It builds a new index of keys from the table
  ▫️ It sorts the index table
  ▫️ It returns a closure where each call of the closure returns a consecutive index and a
    value from the sparse array

Each call to iparis_sparse prepares a new index table call index. The index consists of 
(integer, entry) pairs.
]]
