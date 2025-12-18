--[[
https://devforum.roblox.com/t/all-you-need-to-know-about-iterator-functions/572366

Tutorial from Roblox dev forum to really understand iterators in Lua

In this article we'll be covering an important piece of the lua pil, iterator functions.

I INTRODUCTION

first of all, I need to change the way I think about the generic for loop. A generic
for loop is the 'for ... in x' loop. Most of the time, I'll find myself writing:

  for i,v in pairs(t) do
    <something>
  end

where 't' is the table I wanna loop through (or in other words, iterate through). Most
beginners learn this and just think its a solid set of lua keywords including 'pairs' 
that can't be changed (e.g. calling this last snippet of code an 'in pairs' loop), and 
the same thign when they encounter 'ipairs'. But that isn't the case. paris (and ipairs)
are just functions, and I can put any other function I create instead of those in a
for loop. Earlier I noted the generic for loop as 'for ... in x do' end . This is 
really a brillant manner of thing about it. 

... and x are the only independent parts that can be changed. x is the function (and to
not cause confusion, its NOT the iterator function here, we'll get to that in a bit) 
that takes the table to iterate through as input. 

... are the pieces of info that the functiong ives back (it's not actually the function
that gives these pieces of info, its the iterator function that does, again which I'll
get to in a bit). For example, pairs gives back the current value's index (commonly 
called the variable i) and the current value (commonly called the variable v). I can
actually make a function that gives back more than 2 pieces of info, or even less. 

Now let's talk about how I would write a fucntion like this that can be used in a 
generic loop. Something I've run into before in lua is the 'next' function. pairs
actually returns 'next', 'next' is the iterator function here. 

So, the function x (in for) that I want to write needs to return a function, and 
not any function, an iterator function. An iterator function determines the next
value to be returned from the inputted table given the previous index. That's 
actually how 'next' works, it takes two inputs, the table being iterated and the
previous index. So if I wanted the 3rd index, I would do

  next({1,3,4,5},2)

which is basically saying that I was previously at the 2nd index of this table, 
get me the value from the next index. and that's how the generic for loop works,
it uses the iterator function returned from x, starting at 0 (it starts with 0
so tha the first iteration is 1) and keeps on incrementing that value until the
iterator function returns nil. Since technically if I have a table {1,2,3,4} and
I said I was previously at 4, it will give the 5th value which doesn't exist,
in other words its nil. Thus nil is returned and the loop stops. As I can gather
I just provide the iterator function and the generic for loop does the rest.

So if the returned function is called an iterator function, than what is 'x'
called? its actually called a factory in lua. A factory is a function that
creates and returns a function, just like in our case. 

let's see this in action:
]]

local function xpairs(t) -- calling my factory function 'xpairs'
  local idx = 2
  local function iterator()
    idx = idx+1
    return t[idx]
  end
  return iterator
end

--[[
I can see exactly what was noted above in action. The FACTORY is called 'xpairs' and
the iterator function it returns is called 'iterator'. I keep a variable call 'idx',
this is our STATE, it's used to keep track of the previous index. I can see at the
start idx is 0 and not 1, since iterator increments before returning the value, so
at the first iteration the index is 0+1, or 1. The way 'iterator' is written is
pretty simple. It increments the previous index by 1 and then returns whatever value
is at that index in 't'.
]]

for v in xpairs({'hi',true,3,4}) do
  print(v) -- actually prints the elements of the table sequentially
end

-- since our iterator only returns the value, that is used in 'v' in the for loop. If
-- I return idx,v then I would have i,v in the for loop. Also I believe if I start  the
-- function at a different idx than 0, it'll correspondingly start somewhere else 
-- in my loop...y asi sucesivamente. 

--[[
v is the current element returned by 'iterator'. I can see here I only have one 
piece of the info which is the current value, unlke 'next' which returns the 
current index and its value. If I wanted to do that I would simply replace

  return t[idx] with 
  return idx, t[idx]

and additionaly I would need to check if I hit the table's length (idx == #t) since
t[idx] would be nil if I'm out but since in our function idx will just continue 
to increase, not only nil is returned and the loop would continue to increase.S
]]