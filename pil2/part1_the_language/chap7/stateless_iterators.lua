--[[
7.3 - STATELESS ITERATORS

As the ane implies, a stateless iterator is an iterator that doesn't keep any
state by itself. Therefore, we may use the same stateless iterator in multiple
loops, avoiding the cost of creating new closures. 

For each iteration, the for loop calls its iterator function with two args:

  -- the invariant state
  -- the control variable

A stateless iterator generates the next element for the iteration using only these 
two values. A typical example of this kind of iterator is ipairs, which iterates
over all elements of an array:
]]
local a = {'one','two','three'}
for i,v in ipairs(a) do
  print(i,v)
end
print()

-- The state of the iteration is the table being traversed (according to gemini that is
-- the invariant state, which does not change during the loop), plus the current index
-- (the control variable). Both ipairs (the factory) and the iterator are quite simple;
-- We could write them in lua ourselves as follows:
local function iter(a,i)
  i=i+1
  local v = a[i]
  if v then
    return i,v
  end
end

function ipairs(a) -- so ipairs is my factory and it returns
  return iter,a,0  -- my iterator ,my invariant (table), the control var
end

--[[
So when lua calls ipairs(a) in a for loop, it gets the 3 values:

  -- the iter function
  -- the invariant state
  -- the zero as the initial value

The lua calls iter(a,0), which results in 1,a[1] (unless a[1] is already nil). In
the second iteration, it calls iter(a,1) and returns 2,a[2], and so on, until the
first nil element.

Now the pairs function, which iterates over all elements of a table, is similar, 
except that the iterator function is the NEXT function, which is a primitive in 
lua:
]]
function pairs(t)
  return next,t,nil
end

--[[
The call next(t,k), where k is a key of the table t, returns the next key in the
table, in an arbitrary order, plus the value associated with this key as a second
return value. The call next(t,nil) returns a first pair. When there are no more pairs,
next returns nil.

The are some folks that like to use 'next' directly, in fact, I've done that before
as well, but I remember hearing that there are no real benefits to that. 

  for k,v in next,t do
    <loop body>
  end

Remember that the <exp-list> of the for loop is expeccting its 3 results, so lua gets
next, t, and nil, which is exactly what it gets when it calls pairs(t). An iterator
to traverse a linked list is another interesting example of  stateless iterator. 
(As we already mentioned, linked lists are not frequent in lua, but sometimes we
need them).
]]
local function getnext(list,node)
  return not node and list or node.next
end

function traverse(list) return getnext,list,nil end

--[[
The trick here is to use the list main node as the invariant state (the second value
returned by traverse) and the current node as the control variable. The first time 
the iterator function getnext is called, node will be nil, and so the function will
return list as the first node. In subsequent calls node will not be nil, and so the 
iterator will return node.next, as expected. As usual, it is trivial to use the 
iterator:
]]
local list = nil
for line in io.lines() do
  list = {val = line, next = list}
end

for node in traverse(list) do
  print(node.val)
end

--[[ FROM MY DEEP DIVE INTO ITERATORS, PLUGGING THIS ON THE END OF EACH OF THESE FILES
This helped to concrete the idea of lua iterators in my head with two main points:

  1. when talking about state, we are referring to BOTH the invariant state and the 
     control variable. Both are state. They need each other to represent the state
     of our table, for example. tbl is invariant, it doesn't change and doesn't mean 
     much alone. An index 2 does change when incremented, but again doesn't mean much
     alone. But tbl[2] now means something.

  2. The difference between iterators is subtle but powerful:
    • First, how my iterator gets the info needed (stateful vs stateless) 
      • STATEFUL being that our factory just returns a function that tracks its own state
        typical in its own universe in closures. Our loop just runs that function and 
        doesn't worry about anything else as the other expected args (invarint and variant
        state) are nil
      • STATELESS being that our factory returns an iterator function that expects its
        state  as args. Meaning the function doesn't control its  own state, its waiting
        for someone else to track it and give it, typically our for loop. 
    • Second, if I need more data variables than the normal 1 or 2 (v or i,v), then we use
      a complex iterator, which is just packing more info in a table and using that to provide
      all that data that we need including state.
]]
