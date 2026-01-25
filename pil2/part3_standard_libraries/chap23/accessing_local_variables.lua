--[[
ACCESSING LOCAL VARIABLES

We can inspect the local variables of any active function with debug.getlocal.
This function has two parameters:
  • the stack level of the function we are querying and
  • a variable index

It returns two vqlues:
  • the name and
  • the current value of this variable

If the variable index is larget than the number of active variables, getlocal returns
nil. If the stack level is invalid, it raises an error. We can use debug.getinfo to
check the validity of the stack level in the process.

lua numbers local variables in the order that they appear in the function, counting 
only the variables that are active in the current scope of the function. For example:
]]
function foo(a,b)
  local x
  do local c = a-b end -- a separate subscope
  local a = 1
  while true do
    local name,value = debug.getlocal(1,a)
    if not name then break end
    print(name,value)
    a = a+1
  end
end
foo(10,20);print()

--[[
The variable with index 1 is 'a' (the first parameter), 2 is b, 3 is x, and 4 is the
other 'a'. At the point where getlocal is called, c is already out of scope, while
name and value are not yet in scope. (remember that local variables are only visible
AFTER their initialization code).

We can also change the values of local variables, with debug.setlocal. Its first 2
parameters are a stack level and a variable index, like in getlocal. Its third
parameter is the new value for this variable. It returns the variable name, or nil
if the variable index is out of scope.
]]


