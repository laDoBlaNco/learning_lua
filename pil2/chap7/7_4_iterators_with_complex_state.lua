--[[
7.4 - ITERATORS WITH COMPLEX STATE

Frequently, an iterator might need to keep more state than fits into a single invariant state
and control variable. The simplest solution is to use closures. An alternative solution is to
pack all ti needs into a table and use this table as the invariant state itself for each iteration.
Usinga table, an iterator can keep as much data as it needs along the loop. Moreover, it an change this
data as it goes. Although the state is always the same table (and therefore invariant) The table 
contents can change along the loop. Because such iterators have all their data in the state, they
typically ignore the second argument provided by the generic 'for' (the iterator variable)

As an example fo this technique, I'll rewrite the iterator allwords, which traverses all the words
from the current input file. This time, I'll keep its state using a table with two fields: 
  ▪ line
  ▪ pos



]]