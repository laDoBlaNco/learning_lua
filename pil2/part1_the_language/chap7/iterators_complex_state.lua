--[[
7.4 ITERATORS WITH COMPLEX STATE

Frequently, an iterator needs to keep more state than fits into a single 
invariant (the table for my understanding) state and a control variable. 
The simplest solution is to use closures. An alternative solution is to pack
all it needs into a single table and use this table as the invariant state 
for iteration. 

  -- again for my undestanding what its saying here is that rather than the
  iterator function using just a table (array) as the invariant state as 
  opposed to this complex state when we use a table packed with info for
  the iterator 🤔🤔🤔

Using a table, an iterator can keep as much data as it needs along the loop. 
Moreover it can change this data as it goes. Although the state is always the
same table (and therefore invariant, so the invariant state remains the "invariant
state", as far as the iterator knows), the table contents can change along the loop.
Since such iterators have all their data in the states, they typically ignore 
the second argument provided by the generic for (the iterator variable)

As an example of this technique, let's rewrite the iterator allwords, which 
traverses all the words from the current input file. But this time, we'll keep its
state using a table with two fields: line and pos

The function that starts the iteration is simple. It must return the iterator
function and the initial state:  
]]
local iterator -- to be defined later
function allwords() -- our factory
  local state = {line=io.read(),pos=1}
  return iterator,state
end

-- The iterator function does the real work
function iterator(state)
  while state.line do         -- repeat while there are lines
    -- search for next word
    local s,e = string.find(state.line,'%w+',state.pos)
    if s then       -- found a word?
      -- update next position (after this word)
      state.pos = e+1
      return string.sub(state.line,s,e)
    else                    -- word not found?
      state.line=io.read()  -- try next line ...
      state.pos=1           -- ... from the first position
    end
  end
  return nil          -- no more lines: end the loop
end

--[[
Whenever possible, I should try to write stateless iterators, those that keep 
all their state in the for variables. With them I don't need to create new
objects when the loop starts. If I can't fit my iteration into this model, then
I should try closures. Besides being more elegant, typically a closure is more
efficient than an iterator using tables: 

  -- first, its cheaper to create a closure than a table
  -- second, access to a non-local variable is faster than access to table fields
    (so in regards expense it goes from cheap to expensive:
      local variabes --> non-local variables --> table fields)

Later I'll see yet another way to write iterators, with coroutines. This is the
most powerful solution, but a bit more expensive. 
]]

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

