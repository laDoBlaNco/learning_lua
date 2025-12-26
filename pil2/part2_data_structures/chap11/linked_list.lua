--[[
11.3 - LINKED LISTS

Since tables are dynamic entities, it is easy to implement linked lists in
lua. Each node is represented by a table and links are simply fields that 
contain references to other tables. for example, to implement a basic list
where each node has two fields, 'next' and 'value', we create a variable to
be the list root:
--]]
-- list = nil -- (technically I don't have to do this I don't think, i can just make
-- nil my first 'next')

-- then insert an element at the beginning of the list, with a value v:
list = {next=nil,value='a value'} -- this is the head of my list with next = nil
list = {next=list,value='another value'} -- this the next part with next = my head table
list = {next=list,value='a third value'} -- this is a third part with next = m second table


-- to traverse our list, we write
local l = list -- now local l.next = my third table which links to the rest
print(l.value,l.next)
print(l.next.value,l.next.next)
print(l.next.next.value,l.next.next.next)
-- print(l.next.next.next.value,l.next.next.next.next) -- this errors out
-- 'attempt to index the fields 'next' and 'value' of a nil value
-- l.next.next.next refers to 'nil', sooo l.next.next.next.value errors since nil doesn't
-- have a .value.

--[[
other kinds of lists, such as double-linked lists or circular lists, are also implemented
easily with lua. However, we really seldom need those structures in lua, since usually
there is a simpler way to represent our data without using linked lists. For example,
we can represent a stack with an (unbounded) array.
--]]





