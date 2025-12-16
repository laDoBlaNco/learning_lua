--[[
5.2 - Variable Number of Arguments

The ... in the parameter list indicate that the function accepts a variable
number of args. When called, its args are collected INTERNALLY; we call these 
args the VARARGS (variable arguments) of the function. A function accesses its 
varargs using ... again, but now as an expression. such as {...} putting all the
args in a table as an array
]]
function add(...)
  local s = 0
  for _,v in ipairs{...} do -- note since we use {...} ipairs doesn't have ()s
    s=s+v
  end
  return s
end
print(add(3,4,10,25,12))
print()

-- ... acts just as a multiple return. So local a,b = ... would only give us 2 results

-- lua also allows for adding fixed parameter lists before variadic lists (...). 
-- the first args will be assigned to the fixed and what's left over to varargs

--[[
IMPORTANT TO NOTE: To iterate over its variable arguments, a function may use the 
same expression used before {...} to collect them all in a table, simple. In the
rare occassion when the vararg list may contain nils, I can use 'select'

From what I understand 'select' has two purposes. 
  1. select('#',...) --> when first arg is '#' it returns the count of elements in ...
  2. select(i,...) --> when first arg is an index it returns the value at that index from ...

That's why the following works and it has both actions in the same function which is
what you would do if your ... possibly has nils

A call to select has always one fixed argument, the 'selector', plus a variable number
of extra args. 

for i=1,select('#',...) do -- count of args
  local arg = select(i,...) -- get the i-th arg
  <the other pieces of my loop>
end

The key is that select('#',...) returns the exact number  of args INCLUDING the nils
]]




