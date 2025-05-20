--[[
7.3 - STATELESS ITERATORS

As the name implies, a stateless iterator is an iterator that doesn't keep any state by itself.
Therefore, I can use the same stateless iterator in multiple loops, avoiding the cost of creating
new closures. Remembering the role that proper tail calls and creating new closures has with
keeping state.

For each iteration, the for loop calls its iterator function with two arguments:
  ▪ its invariant state
  ▪ its control variable

A stateless iterator generates the next element for the iteration using only these two values. A
typical example of this kind of iterator is 'ipairs', which iterates over all elements of an
array
]]
a = { 'one', 'two', 'three', 'four', 'five' }
for i, v in ipairs(a) do print(i, v) end
print()

-- The state of the iteration is the table being traversed (that means it is the invariant state
-- which does not change during the loop), plus the current index (the control variable). Both
-- ipairs (the factory) and the iterator are quite simple; I could write them both in lua itself
-- as follows

local function iter(a, i)
  i = i + 1
  local v = a[i]
  if v then
    return i, v
  end
end

function myIpairs(a)
  return iter, a, 0
end

--[[
So here when lua calls myIpairs(a) in the for loop, it gets the 3 values expected:
  ▪ the iter function as the iterator
  ▪ 'a' as the invariant state
  ▪ and 0 as the initial value for the control variable.

Then lua calls iter(a,0), which returns 1,a[1] (unless a[1] is already nil)
In the second iteration, it calls iter(a,1) which returns 2,a[2], and so on, until the first
nil element  THIS IS IMPORTANT TO NOTE BECAUSE ITS ALSO THE REASON WHY ARRAYS OR TABLES WITH HOLES
HAVE THE IMPACT THAT THEY DO WITH ipairs

The 'pairs' function, which iterates over all elements of a table, is similar, except that the
iterator function is the 'next' function, whic is a primitive function in lua:
]]
function myPairs(t)
  return next, t, nil
end

--[[
So here the call next(t,k), where k is the key of the table t, returns a next key in the table,
in an arbitary order, plus the value associated with this key as a second return value. The call
next(t,nil) returns a first pair. When there are no more pairs, next returns nil

Some lua devs prefer to use next directly, without calling pairs:

  for k,v in next,t do
    <loop body>
  end

This tells me that the use of 'next' directly is really only useful when dealing with tables and
the typical use of 'pairs' not ipairs. Although I believe it can be used with both

I have to remember though that the expression list of the 'for' loop is adjusted to the 3 results,
so lua gets next,t, and nil which is exactly what it gets when it calls pairs(t).

An iterator to travese a linked list is another interesting example of a stateless iterator. (As
already mentioned, linked lists are not frequent in lua, but sometimes they are needed.)

  local function getnext(list,node)
    return not node and list or node.next
  end

  function traverse(list) return getnext,list,nil end  -- still returning the 3 needed results for 'for'

The trick I'm seeing here is to use the list main node as the INVARIANT STATE (the second value returned
by traverse) and the current node as the control variable. The first time the iterator function getnext
is called, node will be nil, and so the fucntion will return list as the first node. In subsequent
calls 'node' will not be nil, and so the iterator will return node.next, as expected. As usual, it is
trivial to use the iterator in lua

]]

local function getnext(list, node)
  return not node and list or node.next
end

function traverse(list) return getnext, list, nil end -- still returning the 3 needed results for 'for'

list = nil
for line in io.lines() do
  list = {val = line, next = list}
end

for node in traverse(list) do
  print(node.val)
end

-- so my observation is that it traverse in reverse order. Why is that??? 🤔🤔🤔 Ok, it looks like its
-- cause we are building from the tail since 'next = list' is the previous list we had, meaning as we
-- add stuff the list is backwards