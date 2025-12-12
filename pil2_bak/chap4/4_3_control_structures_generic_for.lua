--[[
4.3 CONTROL STRUCTURES - generic for
The generic for loop traverses ALL values by an iterator function
]]
local a = { 'just', 'some', 'random', 'string', 'values' }
for i, v in ipairs(a) do print(v) end
print()
--[[
The basic lua library provides ipairs, a handy iterator function to traverse an
array. For each step in that loop, i gets an index, while v gets the value ossociated
with this index. A similar example shows how we traverse all keys of a table:]]
for k in pairs(a) do print(k) end
print()
--[[
Despite its apparent simplicity, the generic for is very powerful. With proper iterators,
I can traverse almost anything in a readable fashion. The standard libraries provide
several iterators, which allow us to iterate over the lines of a file, for example (io.lines),
the pairs of a table(pairs), the entries of an array (ipairs), the words of a string (string.gmatch),
and so on. Of course, I can also write my own iterators if I need to. Although the use of
generic for is easy, the task of writing my own iterator has its subtleties. I'll look at that
more closely in chapter 7.

The generic for loop shares two properties with the numeric for loop:
  ▪ first the loop variables are local to the loop body
  ▪ I should never assign any value to them programatically

Below is a more concrete example of the use of a generic for.
]]

days = { 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', }

--[[
Now let's say I want to transalte a name into its position in the week. I can search
the table, looking for the given name. Frequently however a more efficient approach in
lua is to build a 'reverse' table, say revDays, that has the names as indices and the
numbers as values. This table would be the following:
]]
revDays = {
  ['Sunday'] = 1,
  ['Monday'] = 2,
  ['Tuesday'] = 3,
  ['Wednesday'] = 4,
  ['Thursday'] = 5,
  ['Friday'] = 6,
  ['Saturday'] = 7
}

x = 'Tuesday'
print(revDays[x])

-- of course rather than building the reverse table manually, I can just build it
-- programatically from the original
revDays2 = {}
for k, v in pairs(days) do
  revDays2[v] = k
end
for k, v in pairs(revDays2) do
  print(k .. ':' .. v)
end

