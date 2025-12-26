---@diagnostic disable: duplicate-index
--[[
11.5 - SETS AND BAGS

Now what if we want to list all identfiers used in a program source; somehow we
need to filter the reserved words our of our listing. Some C programmers could
be tempted to represent the set of reserved words as an array of strings, and
then to search this array to know whether a given workd is in the set. To 
speed up the search, they could even use a binary tree to represent the set.

In lua though, an efficient and simple way to represent such sets is to put the
set elements as INDICES in a table. Then, instead of searching the table for a
given elements, we just index the table and test whether the result is nil
or not. 
--]]
--[[
reserved = { -- remember to use strings as keys we need to do ['']
  -- and later use reserved.while or rserved['while'] 
  ['while'] = true,
  ['end'] = true,
  ['function'] = true,
  ['local'] = true,
}
for w in allwords() do
  if not reserved[w] then 
    --<do someting with 'w' -- 'w' is not a reserved word
  end
end
--]]

--[[
Since these words are reserved in lua, we can't use them as identifiers; for example,
we can't write while=true. Instead we use the ['while'] = true notation, which as I've
tested is the same thing. in Lua its just different notation for the same result

  {['name'] = 'Kevin'} is the same as {name = 'Kevin'} in fact if I put both of those in
  the same constructor, the last will shadow the first.

We can have a clearer intiialization using an auxiliary function to build the set:
--]]
function Set(list)
  local set = {}
  for _,l in ipairs(list) do set[l] = true end
  return set
end
-- this works as a set since in lua two 'keys' can't be the same. One will shadow the other
test = {name = 'kevin',name = 'whiteside'} -- I get a warning for duplicate index in vscode I turned it off
print(test.name);print() --> whitside as the first key is shadowed

reserved = Set{'while','end','function','local',} -- note Set{} instead of Set() its really Set({})

--[[
Bags, also called multisets, differ from regular sets in that each element may appear
multiple times. (so is it really a set 🤔🤔🤔). an easy representation for bags in
lua is similar to the previous representation for sets, but where we associate a counter
with each key. To insert an element we increemnt its counter:
--]]
function insert(bag,element)
  bag[element] = (bag[element] or 0) + 1 -- Note the 'or' in ()s to set a default
end

-- to remove an element we decrement its counter
function remove(bag,element)
  local count = bag[element]
  bag[element] = (count and count>1) and count - 1 or nil -- 🤯🤯🥰 Lua so simple its complex
end

-- we only keep the counter if its already exists and it is still greater than zero
