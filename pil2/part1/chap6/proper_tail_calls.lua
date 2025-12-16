--[[
6.3 - PROPER TAIL CALLS
Something else I hear a lot about in lua is that it does tail-call elimination.
This means that lua properly implements tail recursion, although the concept
doesn't directly involve recursion.

A tail call is a 'goto' dressed as a call. A tail call happens when a function 
calls another as its last  action, so it has nothing else to do. for instance
in the following code, the call to g is a tail call

  function f(x) return g(x) end

After f calls g it has nothing else to do. In such situations, the program does
not need to return to the calling function when the called function ends. Therefore,
after the tail call, the program does not need to keep any information about the 
calling function in the stack. When g returns, control can return direclty to the
point where f was called. Some language implementations, such as lua, take advantage
of this fact and actually do not use any extra stack space when doing a tail call. 
We say that these implementations do tail-call elimination.

Since tail calls use no stack space, there is no limit on the number of nested 
tail calls that a program can make. For instance, we can call the following 
function passing any number as argument; it will never overlow the stack

  function foo (n)
    if n > 0 then return foo(n-1) end
  end

A subtle note is when we assume tail-call elemination on what is a tail call. Some
apparently obvious candidates fail the criterion that the calling function has 
nothing else to do after the call. For example, in the following code, g is not
a tail call:

  function f(x) g(x) end

The problem here is that after calling g, f still has to discard occasional results
from g before returning. Similarly, all the following calls fail the criterion:

  return g(x) + 1 -- must do the addition after the call
  return x or g(x) -- must adjust to the 1 result, comparison after the evaluation
                    -- o sea its part of an expression so only returns 1 result
  return (g(x)) -- must adjust to 1 result since its in ()s

So in lua, only a call with the form 'return func(args)' is a tail call. However,
both func and its arguments can be complex expressions, since lua evaluates them
before the call. That means the next is actually a tail call

  return x[i].foo(x[j] + a*b,i+j)

As mentioned earlier a tail call is just a goto. As such,a  quite useful application
of tail calls in lua is for programming state machines. Such applications can 
represent each state by a function; to change state is to go to (or to call) a specific
function. As an example, I'll look at a simple maze game. The maze has several rooms,
each with up to four doors: north, south, east, and west. At each step, the user enters
a movement direction. If there is a door in that direction, then user goes to the
corresponding room; otherwise, the program prints a warning. The goal is to go 
from an initial room to a final room.

This game represents a typical state machine, where the current room is the state.
I can implement this maze with one function for each room. I then use tail calls
to move from one room to another.

I'll start with a call to the initial room:

  room1()

Without tail call elimination, each user move would create a new stack level.
After some number of moves, there would be a stack overflow. Withe tail-call
elimination, there is no limit to the number of moves that a user can make,
since each move actually performs a goto to another function, not a conventional
call. 

For this simple game, it might be that a data-driven program, where I describe the
rooms and movements with tables, is a better design. However, if the game has several
special situations in each room, then this state-machine design is quite appropriate. 
]]

function room1()
  local move = io.read()
  if move == 'south' then
    return room3()
  elseif move=='east' then
    return room2()
  else
    print('invalid move')
    return room1() -- stay in the same room
  end
end

function room2()
  local move io.read()
  if move == 'south' then
    return room4()
  elseif move == 'west' then
    return room1()
  else
    print('invaid move')
    return room2()
  end
end

function room3()
  local move = io.read()
  if move == 'north' then
    return room1()
  elseif move == 'east' then
    return room4()
  else
    print('invalid move')
    return room3()
  end
end

function room4()
  print('CONGRATULATIONS!!! 🥳🥳')
end

room1()
