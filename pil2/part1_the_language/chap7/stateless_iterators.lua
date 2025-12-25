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
So when lua calls ipairs(a) in a for loop, ti gets the 3 values:

  -- the iter function
  -- the invariant state
  -- the zero as the initial value

The lua calls iter(a,0), whcih results in 1,a[1] (unless a[1] is already nil). In
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
table, in an arbitrary order, plus the vaue associated with this key as a second
return value. The call next(t,nil) returns a first pair. When ther are no more pairs,
next returns nil.

The are some folks that like to use 'next' directly, in fact, I've done that before
as well, but I remember hearing that there are no real benefits to that. 

  for k,v in next,t do
    <loop body>
  end

Remember that the <exp-list> of the for loop is adjusted to 3 results, so lua gets
next, t, and nil, which is exactly what it gets when it calls pairs(t). An iterator
to traverse a linked lis is another interesting example of  stateless iterator. 
(As we already mentioned, linked lists are not frequent in lua, but sometimes we
need them).
]]
local function getnext(list,node)
  return not node and list or node.next
end

function traverse(list) return getnext,list,nil end

--[[
The trick here is to use the list main node as the invariant state (the second value
returned by traverse) an dnthe current node as the control variable. The first time 
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


