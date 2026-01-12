--[[
7.5 TRUE ITERATORS

So now after going through a deep dive tutorial, I'm undestanding the different
parts and states involved in iterators as well as the reasons they are stateful
or stateless. Meaning I'm now ready for this last section True Iterators, which I've 
learned are 'generators' such as table.foreach

The name 'iterator' is a little misleading in lua, since our iterators don't actually
iterate; what iterates is the actual for loop. Iterators only provide the successive
values for the iteration, o better said they provide the state and context for the 
iteration. Maybe a better name would be 'generator', but 'iterator' is already 
well established in the language. 

However there is another way to build iterators wherein iterators actually do
the iteration. When we use such iterators, we don't write a loop; instead, we 
simply call the iterator with an argument that describes what the iterator 
must do at each iteration. More specifically, the iterator receives as argument
a function and that function has its own loop

As a concrete example ,lets rewrite once more the all_words iterator using this
style:
]]
local function all_words(f)
  for line in io.lines() do
    for word in string.gmatch(line,'%w+') do
      f(word)   -- call the function
    end
  end
end

--[[
To use this iterator, we must supply the loop body as a function. If we want only
to print each word, we simply call

all_words(print)

often, we use an anony function as the body. For example, the next code fragment
counts how many times the world 'hello' appears in the input file
]]
local count = 0
all_words(function(w)
  if w=='hello' then count=count+1 end
end)
print()
print(count)

--[[
True iterators were popular in older versions of lua, when the language didn't have 
the for statement. How do they compare with generator-style iterators? Both styles
have approximately the same overhead: one function call per iteration. One the one 
hand, its easier to write the iterator with true iterators (although we can recover
this easiness with coroutines). On the other hand, the generator style is more flexible
First it allows two or more parallel iterations. (For instance, consider the problem
of iterating over two files comparing them word by word). Second it allows the use 
of break and return inside the iterator body. With a true iterator, a 'return' returns
from the anony function, not from the function doing the iteration. Overall, the 
creator of lua prefers generators. 
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
