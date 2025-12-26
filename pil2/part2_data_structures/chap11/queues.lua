--[[
11.4 - QUEUES AND DOUBLE QUEUES

A simple way we can implement queues in lua with functions 'insert' and 'remove'
(from the table library). These functions insert and remove elements in any
position of an "array" (table), moving other elements to accomodate the operation
(so this has a tc of O(n) and a sc of O(1)). A more efficient implmementation uses
two indices, one for the first element and another for the last:
--]]
function list_new()
  return {first=0,last=-1} -- so I can reference lists with (-)s 🤔🤔🤔 (NO DOESN'T WORK🤓)
end

--[[
To avoid polluting the global space, we'll define all list operations inside a table,
properly called 'list' (that is, we'll create a 'module'). Therefore, we rewrite
our last  example like this:
--]]
List = {} -- looks like capital letter is convention for modules, which are basically 
-- how we do object constructors/classes in other languages
function List.new()
  return {first=0,last=-1}
end

-- now we can insert or remove an element at both ends in constant time (O(1))
function List.pushfirst(list,value)
  local first = list.first-1 -- get list.first value (0) -1 as local first
  list.first = first -- we change our list.first value to our local first value to identify
  -- where the first index of our list is now
  list[first] = value -- then use that local first index value to hold our value arg
end
l = List.new()
print(l.first)
print(l[1])
--[[
(Now let's not get confused here as tables can be tricky. in our function, list.first is
not the same as list[first]. list.first is a integer value we are adding to our table
under the index 'first', while list[first] is an actual indexing (list[1]) that's why
in my printing example, l.first gives 0 as set in List.new but l.[1] is still nil)
--]]

function List.pushlast(list,value)
  local last = list.last+1
  list.last = last
  list[last] = value
end
-- NOTE: so both of these methods cause us to break the convention of starting lists with index 1

function List.popfirst(list)
  local first = list.first
  if first>list.last then error('list is empty') end
  local value = list[first]
  list[first] = nil  -- to allow garbage collection
  list.first = first+1 -- put our index back 1 to note new first location
  return value
end
-- 🤓🤓🤓🤯🤯🤯 LUA IS JUST SO SIMPLE THAT EVERYTHING MAKES SENSE!!! 🥰🥰🥰

function List.poplast(list)
  local last = list.last
  if list.first > last then error('list is empty') end
  local value = list[last]
  list[last] = nil -- to allow garbage collection
  list.last = last - 1
  return value
end

--[[
If we use this structure in a strict queue discipline, calling only pushlast and
popfirst, both first and last will increase continually. However, since we 
represent arrays in lua with tables, we can index them either from 1 to 20
or from 16777216 to 16777236. Since Lua uses double precision to represent
numbers, our program can run for two hundred years, do one million insertions
per second, before it has problems with overflows 🤯🤯🤯🤯🤯
--]]


