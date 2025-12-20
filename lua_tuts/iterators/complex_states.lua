--[[
IV - ITERATORS WITH COMPLEX STATES

so with stateless iterators you can only pass two things as an argument to the
iterator which are the invariant and the control variables. But what if you wanted
to pass more info? for instance let's say you have an iterator which will loop
through 4 odd numbers that were inside of that table. You need to keep a state to
keep track of how many odds there have been so far. Well we can do what we do with
stateful iterators and store that state within the factory (an upvalue would be a
better term) and use a closure
]]

local function loop_until_4_odds(t)
  local odds = 0

  return function(inv,ctl)
    ctl=ctl+1

    if odds==4 then return end

    if ctl<=#inv then
      if inv[ctl]%2~=0 then
        odds=odds+1
      end
      return ctl,inv[ctl],odds -- also returning how many odds there are each time
    end
  end,t,0
end

--[[
but we don't wanna do that. This is a mix of statefulness and statelessness in there
which is ugly. we should be fully on oneside of that line. Fully stateless

What we should remember is that the invariant and control variable arguments that we
need can be anything, they don't need to be precisely a tble and a number. Using
that fact, couldn't we pack the invariant and control variable into one thing, say 
a dictionary (table)? so its like {inv=t,ctl=0}. This dictionary will be returned  by
the factory instead of the invariant, and nil is returned instead of the control
variable. That dictionary will be passed to the iterator as an argument instead of
the invariant. 
]]

local function xpairs(t)
  return function (dict)
    dict.ctl=dict.ctl+1
    if dict.ctl<=#dict.inv then
      return dict.ctl,dict.inv[dict.ctl]
    end
  end,{inv=t,ctl=0},nil -- the initial values are put into a dictionary, not that the
  -- ', nil' can be omitted
end

--[[
Here we can see {inv=t, ctl=0} is gonna be passed as an invariant each time, and each
iteration we increment the ctl key by 1, an dsince the invariant doesn't change 
there is no problem. This is actually a way to bypass the fact tha you need to 
return an index with a stateless iterator. 

Remember that the invariant an the control variable are both considered states (YESSSS I
said that), here instead of having two separate states, we have one complex one.

We can definitely pack more info into that dictionary. We can store mroe states into it
as well, like the odds state. It's initial value is gonna be 0 of course
]]
local function loop_until_4_odds2(t)
  return function(dict)
    dict.ctl=dict.ctl+1

    if dict.odds == 4 then return end

    if dict.ctl <= #dict.inv then
      if dict.inv[dict.ctl]%2~=0 then
        dict.odds=dict.odds+1
      end
      return dict.ctl,dict.inv[dict.ctl],dict.odds
    end
  end,{inv=t,ctl=0,odds=0},nil
end

for i,v,odds in loop_until_4_odds2({1,2,3,4,5,6,7,8,9}) do
  -- so this is wheree we say if we need more data variables than the normal v or i,v
  -- we can use complex iterators with tables
  print(i,v,odds)
end
print()

--[[
This helped to concrete the idea of lua iterators in my head with two main points:

  1. when talking about state, we are referring to BOTH the invariant state and the 
     control variable. Both are state. They need each other to represent the state
     of our table, for example. tbl is invariant, it doesn't change and doesn't mean 
     much alone. An index 2 does change when incremented, but again doesn't mean much
     alone. But tbl[2] now means something.

  2. The difference between iterators is subtle but simple:
    - how your iterator gets the info needed (stateful vs stateless) 
    - if we need more data variables than the normal 1 or 2 (v or i,v), then we use
      a complex iterator. 
]]