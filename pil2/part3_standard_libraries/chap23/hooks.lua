--[[
#23.2 Hooks

The hook mechanism of the debug library allows us to register a function
that will be called at specific events as a program runs. There are 4 kinds
of events that can trigger a hook:
  
  • _call_ events happen every time Lua calls a function;
  • _return_ events happen every time a function returns;
  • _line_ events happen every time lua starts executing a new line of code;
  • _count_ events happen after a given number of instructions.
  
Lua calls hooks with a single argument, a string describing the event that generated
the call: _call_, _return_, _line_, or _count_. For line events, it also passes a second argument,
the new line number. To get more information inside a hook we must call `debug.getinfo`.

To register a hook, we call `debug.sethook` wit two or three arguments:

  • the first argument is the hook function;
  • the second argument is a string that describes the events we want to monitor;
  • and an optional third argument is a number that describes the frequency we want
    to get count events.
    
To monitor the call, return, and line events, we add their first letters ('c','r', or 'l') 
in the mask string. To monitor the count event, we simply supply a counter as the third
argument. To turn off hooks, we call `sethook` with no arguments.

As a simple example, the following code installs a primitive tracer, which prints each
line the interpreter executes:
--]]
function trace(evt,ln)
  local s = debug.getinfo(2).short_src
  print(s..':'..ln)
end

debug.sethook(trace,'l')
