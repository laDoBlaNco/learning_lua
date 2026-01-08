--[[
17.3 - REVISITING TABLES WITH DEFAULT VALUES

In Section 13.4, we discussed a bit about how to implement tables with non-nil default
values. We saw one particular technique and commented that two other techniques needed
weak tables so we postponed them. Well, now is the time to revisit the subject. As we
will see, these two techniques for default values are actually particular applications
of the two general techniques that we have seen here:

  object attributes and
  memoizing

In the first solution, we use a weak table to associate to each table its default
value:
]]
---[[
local defaults = {}
setmetatable(defaults,{__mode='k'})
local mt = {__index=function(t) return defaults[t] end}
function set_default(t,d)
  defaults[t] = d
  setmetatable(t,mt)
end
--]]

--[[
If 'defaults' did not have weak keys, ti would anchor all tables with default values
into permanent existence.

In the second solution, we use distinct metatables for distinct default values, but we
reuse the same metatable whenever we repeat a default value. This is a typical use
of memoizing:
]]
local metas = {}
setmetatable(metas,{__mode='v'})
function set_default2(t,d)
  local mt = metas[d]
  if mt == nil then
    mt = {__index=function()return d end}
    metas[d] = mt  -- memoize
  end
  setmetatable(t,mt)
end

--[[
We use weak values, in this case, to allow the collection of metatables that are not 
being used anymore.

Given these two implementations for default values, which is best? As usual, it depends.
Both have similar complexity and similar performance. The first implementation needs a
few memory words for each tble with a default value (an entry in defaults). The second
implementation needsa  few dozen memory words for each distinct value (a new table, a new
closure, plus an entry in metas). So, if our applicaiton has thousands of tables with a 
few distinct default values, the second implementation is clearly superior. One the
other hand, if few tables share common defaults, then we should favor the first. 
]]



