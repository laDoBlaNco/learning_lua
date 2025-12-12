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

The function that starts the iteration is pretty simple. it must return the iterator function
and the initial state:
]]

local iterator -- to be defined later, but doing this we don't get an error using it below

function allwords()
  local state = {line=io.read(),pos=1}
  return iterator,state
end

-- the iteration function does the real work
function iterator(state)
  while state.line do  -- repeat while there are lines
    -- search for next word
    local s,e = string.find(state.line,'%w+',state.pos)
    if s then
      -- update next position (after this word)
      state.pos = e + 1
      return string.sub(state.line,s,e)
    else  -- if word not found
      state.line = io.read() -- try next line...
      state.pos = 1  -- ... from first position in line again
    end
  end
  return nil  -- no more lines: end the loop then
end

--[[
Whever possible, I want to try to write stateless iterators, those that keep all their state in the
for variabls. With them I don't create new objects when I start a loop. If I can't fit my iteration
into this model, then I should try closrues. Besides being more elegant, typically a closure is
also more efficient than an iterator using tables:
  ▪ first it cheaper to create a closre than table
  ▪ second, access to non-local variables is faster than access to table fields

Later I'll see yet another way to write iterators, with coroutines. This is the most powerful solution
but as expected a bit more expensive.
]]