---@diagnostic disable: unused-local
--[[
Chapter 7 - ITERATORS AND THE GENERIC FOR

Here we are go into how to write iterators for the generic for. Starting with simple 
iterators, we'll learn how to use all the power of the generic for construction to write
simpler and more efficient iterators. Really getting a deep understanding of what lua
is doing here.

7.1 - ITERATORS AND CLOSURES

An iterator is any construction that allows you to iterate over the elements of a 
collection. In lua, we'll typically represent iterators by functions: each time
we call the function, it returns the 'next' element from the collection. 

Every iterator needs to keep some stte between successive calls, so that knows
where it is and how to proceed from there. Closures provide an excellent mechanism
for this task. Remember that a closure is a function that accesses one or more local
variables from its parent environment. These variables keep their values and state
across successive calls to the closure, allowing the closure to remember where it
is along a traversal. Of course, to create a new closure we need to creTe its 
non-local variables. Therefore, a closure construction typically involves two functions:
  the closure itself and
  a factory, the function that creates the closure
  
As an example, let's write a simpler iterator for a list. Unlike ipairs, this iterator
doesn't return the index of each statement, only its value

]]
function values(t) -- non-local variable for our closure but local to the factory
  local i = 0 -- non-local variable for our closure but still local for the factory
  return function()
    i = i + 1 
    return t[i]
  end
end

-- here 'values' is a factory. Each time we call this factory, it creates a new
-- closure (the iterator itself). This closure keeps its state in it external 
-- variables t and i. Each time we call the iterator, it returns a 'next' value
-- from the list t, since 'i' increase by 1. After the last element the iterator
-- returns nil, which signals the end of the iteration. 

-- we can use that signal in a while loop
local tbl = {10,20,30}
local iter = values(tbl)  -- creates the iterator
while true do
  local element = iter()  -- calls the iterator
  if element==nil then break end
  print(element)
end
print()

-- however, it is easier to user the generic 'for', after all, that was designed for
-- this exact situation
for element in values(tbl) do -- NOTE WE ARE USING OUR ITERATOR FACTORY, NOT THE ITER
  print(element)
end
print()

--[[
The generic for does all the bookkeeping for an iteration loop; it keeps the 
iterator function internally, so we don't need the iter variable; it calls the
iterator on each new iteration; and it stops the loop when the iterator returns
nil. (it actually does even more than that, which we'll see in a bit)

For a more advanced example, we'll see an iterator traverse all the words from
the current input file. To do this traversal, we keep two values: the current
line (variable line) and where we are in this line (variable pos). With this
data, we can always generate the next word. The main part of the iterator 
function is the call to string.find. This call searches for a word in the current
line, starting at the current position. It describes a 'word' using the pattern
'%w+', which matches one or more alphanumeric characters. If it finds the word,
the function updates the current position to the first character afer the 
word and returns the word. Otherwise, the iterator reads a new lin and repeats
the search. If there are no mre lines, it returns nil to signal the end of the 
interation. 

Despite the complexity, with generic for its use is simple

  for word in allwords() do
    print(word)
  end

This is a common situation with iterators; they may not be easy to write, but the
are super simple to use. This is not a big problem; more often than not, end users
programming in lua don't define iterators, but just use those provided by the 
application. 

But not me, since I want to create full systems in lua
]]

function all_words()
  local line = io.read() -- current line
  local pos = 1         -- current position in the line
  return function()   -- iterator function
    while line do     -- repeat while there are lines
      local s,e = string.find(line,'%w+',pos)
      if s then   -- found a word?
        pos = e+1 -- next position is after this word
        return string.sub(line,s,e)  -- return the word
      else
        line = io.read()  -- word not found; try next line
        pos = 1         -- restart from first position
      end
    end
    return nil  -- no more lines: end of traversal
  end
end
