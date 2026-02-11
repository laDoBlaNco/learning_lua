--[[
#Accessing Non-Local Variables

The debug library also allows us to access the non-local variables used by a
lua function, with getupvalue. Unlike local variables, the non-local variables
referred by a function exist even when the function isn't active (this is what 
closures are about, after all). Therefore, the first argument for `getupvalues` 
is not a stack level, but a function (closure, more precisely). The second arg
is the variable index. lua numbers non-local variables in the order they are 
first referred in a function, but this order  isn't relevant, since a function
can't access two non-local variables with the same name

We can also update non-local variables, with `debug.setupvalue`. As we might
expect, it has three parameters: a closure, a variable index, and the new value.
Like setlocal, it returns the name of the variable, or nil if the variable index
is out of range

In our example we access the value of any given variable of a calling function
given the variable  name. First we try a local variable. If there is more than
one variable with the given name, we must get the one with the highest index
(which would be the last one created); so we must always go through the whole
loop. If we can't find any local variable with that name, then we try non-local
variables. First, we get the calling function, with debug.getinfo, and then we
traverse its non-local variables. Finally, if we can't find a non-local variable 
with that name, then we try non-local variables. First, we get the calling 
function, with `debug.getinfo`, and then we traverse its non-local variables.
Finally, if we can't find a non-local variable with that name, then we get a
global variable. Notice the use of the number 2 as the first argument in the
calls to  `debug.getlocal` and `debug.getinfo` to access the calling function
instead of the current function.
]]

function getVarValue(name)
  local value,found
  
  -- try local  variables
  for i=1,math.huge do
    local n,v=debug.getlocal(2,i)
    if not n then break end
    if n==name then
      value=v
      found=true
    end
  end
  if found then return value end
  print("...didn't find local, let's go non-local...")
  
  -- try non-local variables now
  local func = debug.getinfo(2,'f').func
  for i=1,math.huge do
    local n,v = debug.getupvalue(func,i)
    if not n then break end
    if n==name then return v end
  end
  print("...didn't find non-local, let's go global...")
  
  -- not found; get from the environment
  return getfenv(func)[name]
end
print(getVarValue('print'))
