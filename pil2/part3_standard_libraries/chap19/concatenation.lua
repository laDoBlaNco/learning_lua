--[[
19.3 - CONCATENTATION

So we've already seen table.cancat in section 11.6. It takes a list of strings and
returns the result of concatentating all of them. an optional second argument 
specifies a string separator to be inserted between the strings of the list. The
function also accepts two other optional arguments that specify the indices of the first
and the last string to concatenate. 

The following function is an interesting generalization of how table.concat works. It
accepts nested lists of strings
--]]
---[[
function rconcat(l)
  if type(l) ~= 'table' then return l end
  local res = {}
  for i=1,#l do
    res[i] = rconcat(l[i])
  end
  return table.concat(res)
end
--]]
--[[
For each list element, rconcat calls itself recursively to concatentate a possible nested
list. Then it calls the original table.concat to cancatenate all partial results
]]
print(rconcat{{'a',{'nice'}},' and',{{' long'},{' list'}}})


