--[[
19.2 - SORT

Another useful function on arrays is table.sort, which we have seen before. it
takes the array to be sorted, plus an optional order function. This order function
takes two arguments and must return true when the first argument should come first
in the sorted array. If this function is not provided, sort uses the default
less-than operation (corresponding to the '<' operator)

A common mistake is to try to order the indices of a table. In a table though,
remember that the indices for a set, and have no order whatsoever. If we want
to order them, we have to copy them to an array and then sort the array. 🤯🤯🤯 (that
would have gotten me as well). So let's see an example. Suppose we read a source
file and build a table that gives, for each function name, the line where this 
function is defined; something like this:
--]]
---[[
lines = {
  luaH_set = 10,
  luaH_get = 24,
  luaH_present = 48,
}
--]]
--[[
Now if we want to print these function names in alphabetical order, if we traverse
the table with pairs, the names will be in arbitrary order. We can't sort them
directly, since these names are keys of the table. However, when we them into
an array, THEN we can sort them. First we must create an array with the names,
then sort it, and finally print the result.
]]
---[[
a = {}
for n in pairs(lines) do a[#a+1]=n end
for _,v in ipairs(a) do print(v) end;print()
table.sort(a)
for _,v in ipairs(a) do print(v) end;print()
for i,n in ipairs(a) do print(n) end;print()
--]]
--[[
Note that, for lua, arrays also ahve no order (they are just tables, after all).
But we know how to count, so we get ordered values as long as we access the array
with ordered indices. That is wy we need to traverse arrays with 'ipairs' instead
of 'pairs' (REMEMBER THE ONLY REAL DIFFERENCE IS IPAIRS ORDERED, PAIRS NO ORDER). 
The first imposes the KEY order 1,2,..., whereas the latter uses the natural arbitrary
order of the table.

As a more advanced solution, we can write an iterator that traverses a table 
following the order of its keys. An optional parameter f allows the specification
of an alternative order. It first sorts the keys into an array, and then iterates
on the array. At each step, it returns the key and the value of the original table:
]]
---[[
function pairs_by_keys(t,f)
  local a = {}
  for n in pairs(t) do a[#a+1]=n end
  table.sort(a,f)
  local i = 0  -- iterator control variable (remember the 3 things for an iterator???)
  return function()  -- iterator function so we can use this in our for..in loop
    i = i + 1
    return a[i],t[a[i]]
  end
end

-- with this function its easy to print those function anmes in alphabetical order

for name,line in pairs_by_keys(lines) do
  print(name,line)
end
--]]





