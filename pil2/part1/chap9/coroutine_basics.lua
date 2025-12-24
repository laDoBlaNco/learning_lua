--[[
Chapter 9 - COROUTINES

So a coroutine is similar to a thread (in the sense of multithreading): its a line
of execution, with its own stack, its own local variables, and its own instruction
pointer; but sharing global variables and mostly anything else with other coroutines.
The main difference between threads and coroutines is that, conceptually (or even 
literally in a multiprocessor machine), a program with threads runs several threads
concurrently. Coroutines, on the other hand, are collaborative, meaning, at any given
time, a program with coroutines is running only one of its coroutines, and this
running coroutine suspends its execution only when it explicitly requests to be
suspended.

Coroutine is a powerful concept. As such, several of its main uses are complex. But we
don't have to worry about understanding some of the examples just yet. We can come 
back to them later if anything, after getting a deeper understanding of lua.

9.1 - COROUTINE BASICS

So lua packs all its coroutine-related functions in the coroutine table. The create
function creates new coroutines. It has a single arg, a function with the code that the 
coroutine will run. It returns a value of type 'thread', which represents the new 
coroutine. Quite often, the arg to 'create' is an anony func, like this:
--]]
local co = coroutine.create(function() print('hi') end)
print(co);print()

--[[
A coroutine can be in one of four different states (I think I remember this from before
or I'm remember something similar from Dart):

  - suspended
  - running
  - dead
  - normal

When we create a coroutine, it starts in suspended state. This means that a coroutine
doesn't run its body automatically when we create it, which is why the above didn't 
print 'hi'. We can check the state of a coroutine with the status function
--]]
print(coroutine.status(co));print()

-- the function .resume (re)starts the execution of a coroutine, changing its state
-- from suspended to running:
coroutine.resume(co);print()

--[[
In this example, when the coroutine body runs it simply says 'hi' and terminates,
leaving the coroutine in the dead state, from which it doesn't return
--]]
print(coroutine.status(co));print()

--[[
So until now, coroutines look like nothing more than a complicated way to call functions.
The real power of coroutines though stems from the .yield function, which allows a
running coroutine to suspend its own execution so that it can be resumed later. 
--]]
co = coroutine.create(function()
  for i=1,10 do
    print('co',i)
    coroutine.yield()
  end
end)

-- now when we resume (start) our coroutine, it starts its execution and runs until
-- the first yield
coroutine.resume(co);print()
-- checking its status we see that its suspended
print(coroutine.status(co));print()

--[[
From the coroutine's point of view, all activity that happens while its suspended
is happening iside its call to 'yield'. When we resume the coroutine, this call to
yield finally returns and the coroutine contines its execution until the next yield
or until its dead
--]]
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co) -- prints nothing, but doesn't crash or err.
coroutine.resume(co) -- prints nothing
print()
print(coroutine.resume(co));print()

--[[
The coroutine body finished its loop and then returned, so the coroutine 
is now dead. If we try to resume it again, resume just returns false plus an 
error message as we see above.

Note that resume runs in protected mode (like pcall). Therefore, if there is 
any error inside a coroutine, lua will not show the error message, but instead
will return it to the resume call.

When one coroutine resumes another, ti is not suspended; after all, we can't
resume it. However, its not in a running state either, since the running 
coroutine is the other one. so, its own status is what we call the 'normal' 
state. 

A useful facility in lua is that a pair resume-yield can exchange data. 🤔 This
means that the first resume, which has no corresponding yield waiting for it,
passes its extra args as args to the coroutine main function:
--]]

co = coroutine.create(function(a,b,c)
  print('c',a,b,c)
end)
coroutine.resume(co,1,2,3);print()

-- a call to resume returns (after returning the TRUE that signals no errors) any args passed
-- to the corresponding yield:
co = coroutine.create(function(a,b)
  coroutine.yield(a+b,a-b)
end)
print(coroutine.resume(co,20,10));print()

-- symmetrically, yield returns any extra args passed, to the corresponding resume:
co = coroutine.create(function()
  print('co',coroutine.yield())
end)
coroutine.resume(co)
coroutine.resume(co,4,5)

--[[
Finally, when a coroutine ends, any values returned by its main function go to the
corresponding 'resume':
--]]
co = coroutine.create(function()
  return 6,7
end)

print(coroutine.resume(co));print()

--[[
We seldom use all of these facilities in the same coroutine, but all of them have
their uses. 

For those that already know something about coroutines, its important to clarify
some concepts before we move on. 

Lua offers what the creator calls 'asymmetric coroutines'. This means that it has
a function to suspend the execution of a coroutine and a different function to 
resume a suspended coroutine. Some other languages offer 'symmetric coroutines',
where there is only one function to transfer control from any coroutine to
another.

Some people call asymmetic coroutines 'semi-coroutines' (being not symmetrical,
they are not REALLY co). However, other people use the same term, 'semi-coroutine'
to denote a restricted implementation of coroutines, where a coroutine can suspend
its execution only when its not calling any function, that is, when it has no
pending calls in its control stack. In other words, only the main body of such
semi-coroutines can yield. A 'generator' in Python is an example of this meaning
of semi-coroutines.

Unlike the difference between symmetric and asymmetric coroutines, the difference
between coroutines and generators (as presented in Python) is a deep one; generators
are simply not powerful enough to implement several interesting constructions
that we can write with full coroutines. Lua offers full, asymmetric coroutines. Those
that prefer symmetric coroutines can implement them on top of the asymmetric facilities
of lua. It is an easy task. (Basically, each transfer does a yield followed by a
resume.)
--]]



