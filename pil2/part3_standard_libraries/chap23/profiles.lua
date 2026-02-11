--[[
#23.3 Profiles

Despite its name, the debug library is also useful for tasks other than debugging
A common such task is _profiling_. For a profile with timing, it is better to use the
C interface: the overhead of a Lua call for each hook is too high and could invalidate
any measure. However, for counting profiles, Lua code does a decent job. In this section
we'll develop a rudimentary profiler that lists the number of times each function 
in a program is called in a run.

The main data structure of our program are two tables: one that associates functions 
to their call counters, another that associates functions to their names. The 
indices to both tables are the functions themselves.
--]]
local counters = {}
local names = {}

--[[
We could retrieve the name data after the profiling, but we need to remember that we get
better results if we get the name of the function while it is active, since then Lua can
look at the code that is calling the function to find its name.

Now we can define the hook function. Its job will be to get the function being called and
increment the corresponding counter; it also collects the function name:
--]]
local function hook()
  local f = debug.getinfo(2,'f').func
  if counters[f]==nil then    -- first time 'f' is called?
    counters[f]=1
    names[f]=debug.getinfo(2,'Sn')
  else    -- only increment the counter as the function is already there
    counters[f]=counters[f]+1
  end
end

--[[
The next step would then be to run the program with this hook. We can assume that the main
chunk of the program is in a file and that the user gives this file name as an argument
to the profiler. 
  `% lua profiles markov_algorithm`
That way the profiler can get the name in arg[1], turn on the hook, and run 
the file:
--]]
local f = assert(loadfile(arg[1]))
debug.sethook(hook,'c')   -- turn on the hook for calls
f()                       -- run the main program
debug.sethook()           -- turn off the hook; () is empty o sea no args on the call

--[[
The last step is to show the results. The next function produces a name for a function
Because function names in Lua are so uncertain, we add to each function its location
given as a pair file:line. If a function has no name, then we use only its location. 
If a function is a C function, we use only its name (as it has no location)
--]]
function getname(func)
  local n=names[func]
  if n.what=='C' then
    return n.name
  end
  local lc=('[%s]:%s'):format(n.short_src,n.linedefined)
  if n.namewhat ~= '' then
    return ('%s (%s)'):format(lc,n.name)
  else
    return lc
  end
end

-- Now to test we apply this to our Markov example from chapter 10 and see what we get.
-- well it didn't work exactly since I don't remember what i ran the markov_algo on :(
-- Nevertheless, this basic profiler could be useful and again its using the debug library.