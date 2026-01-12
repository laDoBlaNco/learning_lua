--[[
III - STATELESS ITERATORS

This is going to be the most important section of this tutorial, so let's
buckle in. First let's try printing what pair actually returns
]]
print(pairs({1,2,3,4}))

--[[
WTF! Wait...it returns three things? Did we think it was just returning the iterator?

Well, this whole time up until now we've been using stateful iterators, which is 
what I thought since they were using closures with the external idx. What that
means is that the idx variable we used made it a stateful iterator. With stateful
iterators, you keep your state internally, you're the one who takes care of it by 
creating it and incrementing it, etc. With stateless iterators, you don't keep your
state, its given to you. But given by who I say? Well the generic for loop, in our 
case, but we'll see that later. let's look at an example:
]]

-- a simple factory and iterator function. 
local function xpairs(t)
  local i = 0
  return function()
    i=i+1
    return t[i]
  end
end

local iter = xpairs({1,2,3,4})
print(iter())
print(iter())
print(iter())
print(iter())
print()

--[[
As I can see here, this is a stateful iterator, since it keeps its state internally.
Whenever I call it, I don't need to pass an argument or anything, it just knows what
value to return next since its the one keeping track.

So 'next' is a stateless iterator. Remember at the start, 'next' needs to get passed
the previous index, meaning the state, as a second argument. It's stateless! It 
doesn't save the state, its given to it as an argument.

So I understand it theoretically, but I need to see some code. 'pairs' isn't the 
greatest example so I'm going to write my own factory with a stateless iterator. 

As with 'pairs', a factory with a stateless iterator returns 3 things:

  - the stateless iterator itself
  - the INVARIANT variable - which is basically the inputted table to iterate over
    (the table won't be affected or changed which is why its called the invariant)
  - the control variable - which is technically speaking our state. 

  (So this is very much a different picture from what PiL is saying 🤔🤔🤯🤯. In
  PiL2 its the INVARIANT STATE, but here its the control variable which is the state
  which actually makes a bit more sense, if stateful vs stateless is simply WHERE that
  control variable lives or is coming from. )

At first I need to return the initial starting control variable, basically the starting
value for the state which in most cases I've seen here is 0. In my factory, I need to 
return these 3 things for the generic for loop to use. In return, each iteration my
stateless iterator gets passed the invariant and the previous control variable as arguments
(exactly why its STATELESS) in order to determine the next value, increment the control
variable, and, this is important, it has to return the incremented control variable
which will be passed as the control argument in the next iteration, and the current
value as a second value, which means it is essential to return the current index/state
before any other value. And just like stateful iterators, it will keep on going until
the iterator returns nil (but nil index I believe). 
]]

-- rewriting xpairs
local function xpairs2(t)
  return function(invariant,control) -- each iteration, the table and the  previous control
    -- variable are passed as arguments
    control=control+1 -- I increment the control variable each time, at the first iteration
    -- the control variable will be 0, we increment it so it becomes 1, use it, and return it
    -- so in the next iteration we get passed 1, increment it again so its 2 and so on
    if control<=#invariant then  -- we have to add thsi now since we are returning the index
    -- as explained at the start
      return control,invariant[control] -- here we return the current index so it's passed
      -- again in the next iteration and the pieces of info which is the value in this
      -- case
    end
  end,t,0 -- since I'm using an anony func i'm just popping these 2,3 return items on the end
end

local tbl = {a=1,b=2,c=3,d=4}
for v in xpairs2(tbl) do
  print(v) -- actually prints  the elements of the table sequentially, but its actually
  -- the key or the index that we are recieving since that's the first thing we get back
end
print()

--[[
It is fascinating, but I'm a little doubtful because the author of this tutorial has gotten
a couple things wrong, or at least they aren't clear, but let's continue. 

If we were to breakdown what's happening, the factory xpairs2 first returns the stateless
iterator and then the invariant which is {1,2,3,4} and the initial control variable 0,
so {1,2,3,4} and 0 are passed to the iterator. The iterator increments our control var
and returns it along with the current value and in the next iteration the incremented
control variable returned from the previous iteration is passed again, which is now
1, its incremented and returned with its value, and so on.

When we said the stateful version of xpairs was a replica of ipairs, that wasn't actually
true since ipairs returns a stateless iterator just like pairs. The above code is 
actually how ipairs is written. (But I don't believe that is true. This guy is off 
somewhere)

I'll continue with the tutorial, but something is off. Based on my own investigation I
can see that the difference between ipairs and pairs is that ipairs MUST have numerical
indexes or it won't read the table. While pairs doesn't care. But both of them 
seem to return indexes first, not the values, same as my own xpairs2. So what this guy
is saying is either very unclear at the moment or just wrong. 

So it might be that ipairs and xpairs2 are written this same way as said, but something
is still very off for now. -- COMING BACK AFTER A BIT ITS MORE CLEAR NOW THAT THE 
DIFFERNCE BETWEEN PAIRS AND IPAIRS IS SIMPLY THE ORDER THE RESULTS (INDEXES OR KEYS)
ARE RETURNED. BOTH RETURN THE SAME THING AND WORK THE SAME IN THAT FASHION, BUT THE
DIFFERENCE IS:

  • IPAIRS RETURNS IN ORDER BY INDEX WHICH MUST BE AN INTEGER, OTHERWISE ITS IGNORED
    ALSO IF THE VALUE IS NIL, THEN IPAIRS QUITS
  • PAIRS ON THE OTHER HAND RETURNS ITS KEYS (INDEXES) IN ARBITRARY ORDER AND IT DOESN'T
    CARE IF THEY ARE NUMERIC OR TEXT, OR ANY OTHER TYPE AT ALL, ALSO IF THE VALUE IS 
    NIL IT'LL JUST GOT TO THE NEXT ONE UNTIL IT REACHES THE LENGTH OF THE TABLE.

string.gmatch for example returns a stateful iterator. How do I know that? Well if
I printed what it returns I can see it just returns a function and nothing else. 
]]

-- using a record table to prove something to  myself here
-- so even though its still giving me indexes first just as pairs, its the value
-- that can't be nil, or it'll stop. But both pairs and ipairs return i,v its just
-- that ipairs only works with numerical i not keys like a dictionary. And ipairs is 
-- ALWAYS SEQUENTIAL
for v in ipairs({'a','b',nil,'d'}) do
  print(v)
end
print()

for i,v in pairs(tbl) do
  print(i,v)
end
print()

-- sometimes Ive seen the use of 'next' in for like this
for i,v in next,{1,2,nil,4},nil do
  print(i,v)
end
print()

--[[
These are just the values that pairs({1,2,3,4}) would've returned in the first place, 
but instead of calling pairs to get those, we write them straight away. It's just
some way to pretend to be like an epic scripter and confuse beginners. 🤔 (if you
say so). also note that ',nil' could've been omitted. pairs is really just written
like this, next does all the real work (which as we said is written in C)

]]
local function pairs(t)
  return next,t,nil
end

--[[
The reason why we don't use pairs as an example is that it returns 'nil' as an initial
control variable rather than 0. But again, pairs is written in the C-side so we 
don't really know what's happening. But logically, it does this so it can make 
looping through keys and numerical indices at the same time easy or something

So what about stateful iterators? When a factory returns only a stateful iterator
doesn't that disrespect the fact that the 'in x do' part takes 3 values? Well really,
if its not returning anything for those two values, its return like returning nil
as far as 'for' is concerned. So basically nil and nil are being passed to the
iterator function and since we aren't using them anyways, it doesn't matter. 

So which is better to use, a stateful iterator or a stateless iterator? Well use 
which one is fitting. Its a choice really. Personally this author finds stateless
iterators cooler due to the notion of being passed the previous index. The only 
disadvantage to stateless iterators, as said before, is that you are forced to
return an index (state) first along with a value. If you wanted to make an iterator
that only returns the value and not the index, you have to use stateful

So let's move on an re-write some of the previous code with our new found knowledge
]]
local function spairs(str)
  return function(inva,ctrl)
    ctrl=ctrl+1
    if ctrl<=#inva then
      return ctrl,string.sub(inva,ctrl,ctrl)
    end
  end,str,0
end

for i,char in spairs('starmaq101') do
  print(i,char)
end
print()

-- This stupid example creates an infinite loop and I don't have time to debug your garbage
-- local function onlyStrings(t)
--   return function(inva,ctrl)
--     ctrl=ctrl+1
--     while type(t[ctrl]) ~= 'string' do
--       ctrl=ctrl+1
--     end
--     return ctrl,t[ctrl]
--   end,t,0
-- end

-- for i,v in onlyStrings({2,'hi',true,'hgf','kno'}) do
--   print(i,v)
-- end
-- print()

-- (well at least they I get the results I'm expecting.)

-- So coming back to this some time later, its evident that this guy knows a little bit
-- and explains what he knows, but what he can't explain he just does 'wavy hands' and
-- says its magic C code so don't worry about it. Not the greatest tutorial, but it did
-- help me get to a clearer understanding, if not just forcing me to experiment myself
-- to really understand what's going on. 

