--[[
TRACKING TABLE ACCESSES

Both __index and __newindex are relevant only when the i ndex doesn't exist
in the table. The only way to catch all accesses to a table is to keep it empty.
So, if we watn to monitor all accesses to a table, we should create a proxy for
the real table. This proxy is an empty table, with proper __index and __newindex
metamethods that track all accesses and redirect them to the original table. 
Suppose that t is the original tble we want to track. We can write sometihng
like the following:
]]
t = {}    -- original table created somewhere

-- keep a private access to the original table
local _t = t

-- create the proxy
t = {}

-- create metatable
local mt = {
  __index = function(t,k)
    print('*access to element ' .. tostring(k))
    return _t[k]  -- access the original table
  end,

  __newindex = function(t,k,v)
    print('*update of element ' .. tostring(k) .. ' to ' .. tostring(v))
    _t[k] = v -- update original table
  end
}
setmetatable(t,mt)
-- this code tracks every access to t:
t[2] = 'hello'
print(t[2]);print()

--[[
Interestingly we are using the 'shadow' to hide our origina table. even those we replace 
the original with an empty {}, since we have a reference of _t to that memory block, 
it doesn't get recouped by the gc and we still have the "hidden" access to it. that's 
how we "keep" t empty at the same time of filling it up

(Notice that, unfortunately, this scheme doesn't allow us to traverse tables. The
pairs function will operate on the proxy and not the  original since its shadowed 'hidden',
even though we still have access to it through _t. but couldn't we traverse it through the
hidden access? 🤔🤔)

if we want to monitor several tables, we do not need a different metatable for each
one. Instead, if we can somehow associate each proxy to its original table and share
a common metatable for all proxies it would work. This problem is similar to the 
problem of associating tables to their default values, which we discussed in the
previous section. For instance, we can keep the original table in a proxy's field
using an exclusive key. The result is the following: 
]]
local index = {}      -- create private index
local mt = {          -- create metatable
  __index = function(t,k)
    print('*access to element ' .. tostring(k))
    return t[index][k]    -- access the original table
  end,

  __newindex = function(t,k,v)
    print('*update of element ' .. tostring(k) .. ' to ' .. tostring(v))
    t[index][k] = v   -- update original table
  end
}

function track(t)
  local proxy = {}
  proxy[index] = t
  setmetatable(proxy,mt)
  return proxy
end

-- now whenever we want to monitor a table t, all we have to do is execute 
t = track(t)


