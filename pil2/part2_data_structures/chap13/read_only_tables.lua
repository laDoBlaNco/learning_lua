--[[
READ-ONLY TABLES

It is easy to adapt the concept of proxies to implement read-only tables as well.
All we have to do is to raise an error whenever we track any attempt to update
the table. For the __index metamethod, we can use a table -- the original table
itself -- instead of a function, as we do not need to track queries; it is
simpler and rather more efficient to redirect all queries to the original table. 
This use, however, demands a new metatable for each read-only proxy, with __index
pointing to the original table:
]]

function read_only(t)
  local proxy = {}
  local mt = {
    __index = t,
    __newindex = function(t,k,v)
      error('attempt to update a read-only table',2)
    end
  }
  setmetatable(proxy,mt)
  return proxy
end

-- as an example of use, we can create a read-only table for weekdays:
days = read_only{
  'Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday',
}
print(days[1])
days[2] = 'Noday'