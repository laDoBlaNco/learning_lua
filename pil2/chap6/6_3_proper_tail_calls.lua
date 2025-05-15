--[[
Another interesting feach of functions in lua is that lua does tail-call elimination. (This means
that lua is PROPERLY TAIL RECURSIVE, although the concept does not involve recursion directly)

A tail call is a goto dressed as a call. A tail call happens when a function calls another as its
last action, so it has nothing else to do. For instance, in the following code, the call to
g is a tail call:

  function f(x) return g(x) end

After f calls g, it has nothing else to do. In such situations, the program does not need to
return to the calling function whn the call function ends. Therefore, after the tail call, the
program has no reason so go back to f() and thus doesn't keep any information about the calling
function in the stack. I remember when learning how functions work when studying C with Teej,
that that returning to the calling function is information that is kept on the data portion of
the stack. Also when studying Forth, I learning that there are 2 stacks in reality. The one
used most for calculations and processse and then the "return stack". While I have a mental
model of how they work, I'm not 100% sure if the information about the calling function would
be in the return stack, which would make sense, or in some portion of the calculation stack. But
back to the matter at hand. In Lua this information isn't needed for tail calls. Some language
implementations such as lua, take advantage of this fact and actually do not use any extra
stack space when doing a tail call. Its said these implementations do TAIL-CALL ELIMINATION

Since tail calls use no stack space, there is no limit on the number of nested tail calls that
a program can make. For instance, I can call the following function passing any number as arg;
and it will never overflow the stack

  function foo(a)
    if n > 0 then return foo(n-1) end  🤔🤔🤔🤯🤯🤯 now that is interesting.
  end
But wouldn't the above need to know where to RETURN the value? o sea, it would still need
information about the calling function. 🤔🤔🤔

A subtle point when one assumes tail-call elimination is what is a tail call. Some apparently
obvious candidates fail the criterion that the calling function ha snothing else to do after
the call. For example, in the following code, the call to g is NOT a tail call

  function f(x) g(x) end

The problem here is that after calling 'g', 'f' still has to discard occasional results from g
before returning. Similarly, all the following calls fail the criterion:

  return g(x) + 1  -- still has to do the addition after the call to g
  return x or g(x) -- still must adjust to 1 result
  return (g(x)) -- still must adjust to 1 result

In Lua, only a call with the form 'return function(args)'' is a true tail call. So the difference  in the
So the difference is the first example 'foo' and the ones above is that we return foo(n-1) y ya
The ones above we are either just calling another function 'g(x)' or returning a call with an additional
step included 'return g(x) + 1'. However, both the return function and its argument can be complex
expressions because they are evaluated BEFORE THE ACTUAL CALL. For example, the following is
still a tail call:

  return x[i].foo(x[j] + a*b, i + j)  -- complex expression, but still a proper tail call

A stated earlier, a tail call is just a complex 'goto'. As such, a qite useful mechanism of
tail calls in lua is for programming state machines. Such applications can represent each
state by a function; to change state  is to 'goto' (or to call) a specific function. Which I've
seen throughout many of the tutorials being used. As an example, I'll consider a simple maze game
The maze has several rooms, each with up to four doors: north, south, easy, and west. At each
step, the user enters a movement direction. If there is a door in this direction, the user
goes to the corresponding room; otherwise, the program prints a warning.  The goal is to go
from an initial room to a final room.

This game is a tpical STATE MACHINE, where the current room is the state. I can implement this
maze with one function for each room. I use tail calls to 'goto' or move from one room to
another.

We start the game with a call to the initial room:

  room1()

Without tail-call elimination, each user move would create a new stack level. After some number
of moves, there would a stack overflow. With proper tail-call elimination, there is no limit to
the number of moves that a user can make, because each move actually performs a 'goto' to another
function, not a conventional call.

For this simple game, I may find that a data-driven program where I describe the rooms and
movements with tables, is a better design. However, if the game has several special situations
in each room, then this state-machine design is quite appropriate:
]]
function room1()
  local move = io.read()
  if move == 'south' then
    return room3()
  elseif move == 'east' then
    return room2()
  else
    print('invalid move')
    return room1() -- or just stay where you are
  end
end

function room2()
  local move = io.read()
  if move == 'south' then
    return room4()
  elseif move == 'west' then
    return room1()
  else
    print('invalid move')
    return room2()
  end
end

function room3()
  local move = io.read()
  if move == 'north' then
    return room1()
  elseif move == 'west' then
    return room4()
  else
    print('invalid move')
    return room3()
  end
end

function room4()
  print('CONGRATULATIONS. YOU MADE IT!!! 🥳🥳🥳')
end

room1()