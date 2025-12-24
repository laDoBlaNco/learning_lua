--[[
9.3 - COROUTINES AS ITERATORS

We can see loop iterators as another particular example of the producer-consumer
pattern. An iterator produces items to be consumed by the loop body. Therefore, it
seems appropriate to sue coroutines to write iterators as well. Indeed, coroutines
provide a powerful tool for this task. Again, the key feature is their ability to
turn upside-down the relationshp between caller and callee (and thus connect paths or
pipes between them). With this feature, we can write iterators without worrying about
how to keep track of state between successive calls to the iterator.

To illustrate this kind of use, let's write an iterator to traverse all permutations
of a given array. Its not an easy task to write direclty such an iterator, but
it is not so difficult to write a recursive function that generates all these
permutations. The idea is simple:

  - put each array (table) element in the last position, and in turn,
  - recursively generate all permutations of the remaining elements

We need to create our recursive permutationer and then put it to work defining
an appropriate 'print_result' function and then calling it with the propert args:
--]]

-- permgen
function permgen(a,n)
  n = n or #a  -- default for 'n' is size of 'a'
  if n<=1 then
    print_result(a)
  else
    for i=1,n do
      -- put i-th element as the last one
      a[n],a[i] = a[i],a[n] -- 🤓🤓🤯
      -- generate all permutations of the other elements
      permgen(a,n-1) -- the recursive part
      -- restore i-th element
      a[n],a[i] = a[i],a[n]
    end
  end
end

function print_result(a)
  for i=1,#a do
    io.write(a[i],' ')
  end
  io.write('\n')
end

-- testing our permgen
permgen({1,2,3,4});print()
permgen({1,2,3,4},2);print() -- so the default n is the length of the array, but if
-- we only want to permgen the 1st or to the 2nd element, we just add that index
-- for n

--[[
After we have the generator ready, it is an automatic task to convert it to an
iterator. We first change print_result to yield:
--]]
function permgen2(a,n)
  n = n or #a
  if n<=1 then
    coroutine.yield(a)  -- instead of print_result we 'yield'
    -- again thinkin of 'yield' like pushing our value through a tube
  else
    for i=1,n do
      a[n],a[i] = a[i],a[n]
      permgen2(a,n-1)
      a[n],a[i] = a[i],a[n]
    end
  end
end

--[[
Then we need to define a factory that arranges for the generator to run inside 
a coroutine, and then create the iterator function. The iterator simply resumes
the coroutine to produce the next permutation. (Remember that lua 'iterators' are
actually 'generators' in other languages):
--]]
function permutations(a)
  local co = coroutine.create(function() permgen2(a) end)
  return function() -- iterator - stateful
    local code,res = coroutine.resume(co) -- .resume checks status and returns value
    return res -- here our iterator/generator returns our result
  end
end

--[[
With this mechanism in place, its trivial to iterate over all permutations of
an array with a for statement. since our iterator/generator is stateful (remembering
that stateful vs stateless is just depending on where the state (invariant and control
variables) are coming from. In this case they come from permutations and our coroutine
internally). Our 'for' loop just has to worry about the 'p in permutations' since that's
all we are return as 'res'
--]]
for p in permutations{'a','b','c'} do -- (remember the syntax func{} rather than func()
-- just means I have only one arg and its either a {} or a "") 
  print_result(p)
end;print()

--[[
The permutations function uses a common patter in lua, which packs a call to resume
with its corresponding coroutine inside a function. This pattern is SO COMMON that 
lua provides a special function for it:

  coroutine.wrap

Like .create, .wrap creates a new coroutine. But .wrap doesn't return the coroutine
itself (like we did our pipe example); instead, it returns a function that, when called,
resumes the coroutine. Unlike the original .resume, that returned function doesn't
return an error code as its first result, so instead of...

  status,value = coroutine.resume(co) - with status being that error code

it actually throws/raises the error. Using wrap, we can write permutations as 
follows:
--]]
function permutions2(a)
  return coroutine.wrap(function() permgen2(a) end) -- as opposed to the 5 lines in 
  -- the previous
end

--[[
Usually, coroutine.wrap is simpler to use than coroutine.create. It gives us exactly
what we need from a coroutine, which is a function to resume it. However, it is also
less flexible, which can be expectated. There is no way to check the status of a 
coroutine created with .wrap. Moreover, we can't check for runtime errors.
--]]



