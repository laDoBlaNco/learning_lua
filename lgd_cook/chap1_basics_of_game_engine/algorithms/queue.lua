--[[
Making a queue

This data structure can be created in a similar way as our stack with the table. We
can use the table.insert and table.remove functions. However this will add unecessary
overhead because each element insertion at the beginning of the list will need to move
other elements as well. A better solution is using two indices (like pointers) indicating
the beginning and end of the list. Think of how I would do this in C memory management 🤔🤔

My structure will consist of a constructor that returns a new table with 3 functions:
  ▫️ push
  ▫️ pop
  ▫️ iterator
The resulting table uses a modified version of the length operator to get the right length
of our queue
]]
local function queue()
  local out = {}
  -- my pointers/markers
  local first,last = 0,-1
  out.push = function(item)
    last = last+1
    out[last] = item
  end
  out.pop = function()
    -- just moving pointers around
    if first <= last then
      local value = out[first]
      out[first] = nil
      first = first + 1
      return value
    end
  end
  out.iterator = function()
    return function()
      return out.pop()
    end
  end
  -- first time I see metaprogramming in this way in lua
  setmetatable(out,{
    __len = function()
      return (last-first+1)
    end
  })
  return out
end

-- Let's play with it
local q1 = queue()
-- place a few elements into the queue
for _,el in ipairs({'lorem','ipsum','dolor','sit','amet'}) do
  q1.push(el)
end

print('Length of the queue after pushing on 5 items:',#q1)
-- now I'll use the iterator to process elements in a single for loop as I did with my stack
for el in q1.iterator() do
  -- each queue element will be printed onto screen
  print(el)
end
print('Length of queue after using iterator:',#q1) -- again the iterator pops everything rather than
-- just displaying it
print()print()

--[[
How it works:

This algo uses a pair of integer indices that represent positions of the first and last 
element of the queue. This approach provides element insertion and deletion in constant 
time 🤔, because the original length operator isn't suitable for this case, a modified one
is created.

The iterator function creates a new closure that is used in a for loop. This closure is called
repeatedly until the pop function returns an empty result.
]]

print("Again, let's play a little with manually pushes and pops:")
print("First I'll push on 5 names manually:")
q1.push('Odalis')
q1.push('Kevin')
q1.push('Kelen')
q1.push('Xavier')
q1.push('Rocky')
print("Here the length of the queue after manually pushing the names:",#q1)
print("Now let's start to pop names off (they should come off FIFO)")
print('First pop:',q1.pop())
print('Second pop:',q1.pop())
print('Third pop:',q1.pop())
print('And finally the length after the 3 pops:',#q1)
