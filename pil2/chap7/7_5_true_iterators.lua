--[[
7.5 - TRUE ITERATORS


So, the name iterator is a little misleading, because my 'iterators' don't actually iterate:
what is iterating is the for loop. Iterators only provide the successive values for the iteration
Maybe a better name would be 'generator' (as I think they are called in python), but iterator
is already well established in other languages, just as Java

However, there is another way to build iterators wherein iterators actually do the iteration
work. When I use such iterators, I don't write a loop; instead, I simply call the iterator with 
an argument that describes what the iterator must do at each iteration. More specifically, the
iterator receives as an argument a function that it calls inside its loop

As a concrete example, let me rewrite once more the allwords using this style:
]]

function allwords(f)
  for line in io.lines() do
    for word in string.gmatch(line,'%w+') do
      f(word)  -- call the function
    end
  end
end


-- to use this iterator, I supply the loop body as a function. If I want only to print each
-- word, then I simply use print
allwords(print)  -- use ctrl-d to get out of it

-- often we use an anonymous function as the body. For instance, the next code fragment counts 
-- how many times the word 'hello' appears in the input file:

--[[
local count = 0
allwords(function(w)
  if w == 'hello' then count = count + 1 end
end)

print(count)
--]]

--[[
True iterators were popular were popular in older versions of lua, when the language did not
have the for statement. How do they compare the generator-style iterators?  Both styles have
approximately the same overhead: one function call per iteration. On the one hand, it is 
easier to write the iterator with true iterators (although we can recover this easiness with
coroutines). On the other hand, the generator style is more flexible. First, it allows two
or more parallel iterations. (For instance, consider the problem of iterating over two files
comparing them word by word.) Second, it allows the use of break and return inside the iterator 
body. With a true iterator, a return returns from the anonymous function, not from the function
doing the iteration. Overall, I usually prefer generators

]]
