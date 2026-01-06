--[[
17.1 - MEMOIZE FUNCTIONS

A common programming technique, that we've heard many times is trade space for time.
We an speed up some functions by memoizing their results so that, later, when we 
call the function with the same argument, it can reuse the result.

Imagine a generic server that receives requests containing strings with lua code.
Each time it gets a request, it runs loadstring on the string, and then calls the  
resulting function. However, loadstring is an expensive function, and some commands
to the server may be quite frequent. So instead of calling loadstring repeatedly each
time it receives a common command like 'closeconnection()', the server can memoize
the results from loadstring using an auxiliary table. Before calling loadstring
the server checks in the table whether the given string already has a translation.
If it can't find the string, then (and only then) the server calls loadstring and
stores the new result into the table. We can pack this behavior inta a new function
like so:
]]

--[[
local results = {}

function mem_loadstring(s)
  local res = results[s]
  if res == nil then
    res = assert(loadstring(s))
    results[s] = res
  end
  return res
end
--]]

--[[
Pretty simple to follow. The savings with this scheme can be huge, even though it 
doesn't seem like it. However, it may also cause unsuspected waste. Although some
commands repeat over and over, many other commands happen only once. Gradually, the
table results accumulates all commands the server has ever received plus their 
respective code. After enough time, this behavior will exhoust the server's memory.
A weak table provies a simple solution to this problem. If the results table  has
weak values, each garbage-colleciton cycle will remove all translations not in use
at that moment (which is virtually all of them)
]]

--[[
local results = {}
setmetatable(results,{__mode='v'}) -- making it weak values table

function mem_loadstring(s)
  local res = results[s]
  if res == nil then
    res = assert(loadstring(s))
    results[s] = res
  end
  return res
end

--]]
-- technically since the indices are strings we can make this fully weak with 'kv'
-- The net result will be the same

--[[
The memoize technique is useful also to ensure the uniqueness of some kind of 
object. For instance, assume a system that represents colors as tables, with
fields red, green, and blue in some range. A naive color factory generates a new
color for each new request:
]]

--[[
function create_rgb(r,g,b)
  return {red=r,green=g,blue=b}
end

--]]

--[[
Using the memoize technique we can reuse the same table for the same color. To
create a unique key for each color, we simply concatenate the color indices with
a spearator in between:
]]

---[[
local results = {}
setmetatable(results,{__mode='v'})
function create_rgb(r,g,b)
  local key = r..'-'..g..'-'..b
  local color = results[key]
  if color == nil then
    color = {red=r,green=g,blue=b}
    results[key] = color
  end
  return color
end
--]]

--[[
An interesting consequence of this implementation is that the user can compare colors
using the primitive equality operator, because two coexistent equal colors are 
always represented by the same table. Note that the same color may be represented
by different tables at different times, because from time to time a garbage-collector
cycle clears the results of table (if not in use). However, as long as a given color
is in use, it is not removed from 'results'. So, whenever a color survives long 
enough to be compared with a new one, its representation also survives long enough
to be reused by the new color.
]]



