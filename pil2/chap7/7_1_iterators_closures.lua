--[[
7.1 - ITERATORS  AND CLOSURES

An iterator is ANY construction that allows me to iterate over the elements of a collection. In
lua, I'll typically represent iterators by functions: each time I call the function it will
return the  'next' element from the collection. that simple.

Every iterator needs to keep some state between successive calls, so that it knows where it is
and how to proceed from there. Closures provide an excellent mechanism for this task. Remembering
that a closure is just a function that accesses one or more local variables from its enclosing
environment. These variables keep their values across successive calls to the closure, allowing
the closure to remember where it is along a traversal. Of course, to create a new closure I
must also create its non-local varialbes. Therefore, a closure construction typically involves
TWO functions: the closure itself and a 'factory', the function that creates the closure.

Is this the same 'factory' concept that I saw in the Defold engine? 🤔🤔🤔???

Here is an example, writing a simple iterator for a list. Unlike ipairs, this
iterator does not return the index of each element, just the value
]]
function values(t)  -- and this would be the 'factory' then???
  local i = 0
  return function() -- so this is the closure
    i = i + 1; return t[i]
  end
end

--[[
In this example, 'values' is the factory. Each time I call this 'factory', it creates a new
closure (the iterator itself). This closure keeps its state in its external variables t and i
Each time I call the iterator, it returns the next value from the list t. After the last element
the iterator returns nil, which signals the end of the iteration.

I can then use this iterator in a while loop as such:
]]

t = { 10, 20, 30 }
iter = values(t) -- remember this returns a closure function (creating the iterator)

while true do
  local element = iter()           -- this calls the iterator which returns the next value in the collection
  if element == nil then break end -- this takes care of acting on the 'signal' that we are done
  print(element)
end
print()

-- it would be easier to just use the generic for here, since that's what it was designed for
-- generic for uses whatever iterator I need it to, NOT JUST PAIRS AND IPAIRS
for element in values(t) do
  print(element)
end

--[[
Generic for takes care of all the bookkeeping for an iteration loop, meaning it keeps the iterator
function internally, so I don't need to worry about the iter variable; it calls the iterator on each
new iteration; and it stops the loop when the iterator returns nil. (in the next section I'll see that
the generic for does even more than that!!!)

As a more advanced example, I'll see an iterator traverse all the words from an input file. To
do this traversa, I keep two valeus; the current line (variable line) and wherre we are on this
line (variable pos). With thid data, I can always generate the next word. The main part of the
iterator function is the call to string.find. This call will search for a word in the current
line, starting at the current position. It describes a 'word' using the pattern %w+, which matches
one or more alphanumeric characters. If it finds the word, the function updates the current position
to the first character after the word and returns this word. Otherwise, the iterator reads a new line
and repeats the search. If ther are no more lines, it returns nil to signal the end of the iteration.

Despite its complexity, the use of 'allwords' is straightforward with the use of generic for.

This is a common situation with iterators; they may not be easy to write all the time, but they are
very easy to use. This is not a big problem; more often than not, end users programming in lua
do not define iterators, but just use those provided by the application.
]]

function allwords()
  local line = io.read()              -- current line
  local pos = 1                       -- current position in the line
  return function()                   -- iteration function closure to be returned
    while line do                     -- repeat while there are lines
      local s, e = string.find(line, '%w+', pos)
      if s then                       -- found a word?
        pos = e + 1                   -- next position is after this word
        return string.sub(line, s, e) -- return the word
      else
        line = io.read()              -- word not found; try next line
        pos = 1                       -- restart from first position
      end
    end
    return nil -- no more lines: end the traversal, but we didn't create any code to handle this
    -- but did we need to?
  end
end

for word in allwords() do
  print(word)
end
