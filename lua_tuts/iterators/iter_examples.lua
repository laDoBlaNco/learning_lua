--[[
II - ITERATOR EXAMPLES

Now that we know how to properly write iterators, and what they must return, we 
can write even more iterators!

I'll start by trying to make a replica of 'pairs'. But didn't we already that
with xpairs? well, there are some key features that 'pairs', or I should actually
note, 'next', that i didn't do. For example, with 'next', I I have a table like

  {1,2,nil,3}

it would actually traverse through the whole table ignoring nil at index 3 and
carrying on to the 4th (which is 3) and stop. My 'iterator' function in xpairs,
would stop as soon as we return 'nil' as the 'v' value, even though there is 
more ahead. How would I fix that? Well since #{1,2,nil,3} is actually 4 and not
3, we can simply check if the current value is nil and we still havent' hit the
length of that table yet (e.g. idx ~= #t), if so, we increment idx yet again and 
keep going until there is no nil and we hit the table's length
]]

local function xpairs(t) -- I called the factory xpairs
  local idx = 0
  local function iterator()
    idx = idx+1
    while t[idx] == nil and idx<= #t do -- as long as the value is nil and we're not done
      idx = idx+1 -- keep adding one, this while loop will stop as soon as we hit a non-nil value
    end
    return t[idx]
  end
  return iterator
end

-- Now I can see that it works as pairs does. 

for v in pairs({1,2,nil,3}) do
  print(v)
end
print()

for v in xpairs({1,2,nil,nil,3}) do
  print(v)
end
print()

--[[
But wait, what about the keys. When I return 'v' pairs gives me the index not the value,
and my xpairs gives me the values. So still not the same. 'next' can traverse the 
dictionary part of a table, which is what pairs does. So hwo do we do that? Well,
unfortunately, we can't. there isn't really a way to get back the keys of a table
in plain lua (i.e. with using the actual 'for' loop or 'next' function). So how does
'next' do it, I may ask? I need to remember that any global lua function (e.g. 'print',
unpack, pairs, ...) is written in the C-side of lua, meaning 'next' is written in C, 
which means they might have stuff that  I don't have access to directly in lua. 🤔 but
using that reasoning, I could take it all the way back to machine language and say
that C can't do it either. The c-side of lua is still lua, so in practice I would just
use 'for' or 'next'. but for this argument, it get the point. 

What if I wanted to implement ipairs? Well funny enough our first xpairs that I 
wrote does exactly what ipairs does! ipairs will iterate through only the array
part of the table (meaning the values with numerical indices) and ignore the 
dictionary portion (or the keys), which is what we're doing now. Also ipairs stops
as soon as it hits nil, even if there is more ahead, which is what our 'xpairs' did
(in the first version) as well. ipairs doesn't return 'next', it returns a different
iterator, which is obvious since as I can see it has a different behavior. We don't
really know the name of the iterator it returns as its probably just an anony func
of some sort.

NOTE: i also found a but in our xpairs. that rudimentary while loop continues to run
when it hits the end and continues to get nil, it goes into a indefinite loop. So in the
end the example doesn't get me any close to 'pairs'. So I'm going to comment that out 
and use as the first version we created.  -- I FIGURED OUT A FIX. RATHER THAN USING
  idx ~= #t, which it will only = once in the loop. I'll use
  idx <= #t which will stop when it should
]]

-- first here is our xpairs witih ipairs
for v in ipairs({1,2,nil,3}) do
  print(v)
end
print()

for v in xpairs({1,2,nil,nil,3}) do
  print(v)
end
print()

-- let's try something else. Let's make an iterator that iterates through every
-- character in a string
local function spairs(str)
  local idx = 0
  local function iterator()
    idx = idx + 1
    if idx <= #str then -- as long as we didn't hti the string's length, if we did then
                        -- return nothing, in other words return nil and the loop stops
      return idx,string.sub(str,idx,idx) -- this is a way to return a certain character
                                         -- of a string. idx,idx is the start and stop 
    end
  end
  return iterator
end

for i,char in spairs('starmaq101') do
  print(i,char)
end
print()
--[[
string.gmatch is a factory function, and it returns an iterator which iterates
through every matching string with the pattern given. 
]]
for match in string.gmatch('hi hiya hiyo','hi') do
  print(match)
end
print()

--[[
How would we create that one? Well, pretty simple actually. Utilizing the 3rd argument
of string.match, which is from where to start search for matches, I can keep a state
variable just like idx. I can check the first time for any matches with the given
pattern, if one exists then I keep track of where that match ends, and return it, and
then keep on searching depending on the state variable. 
]]

local function gmatch(str,pattern) -- I can pass more than a table
  local last = 1 -- this is our state, from where we should search
  local function iterator()
    local match = string.match(str,pattern,last) -- this is the current match
    if match then -- if a match exists, then we'll return it
      last = select(2,string.find(str,match,last))+1 -- this is how I determine the next position
      -- to search from, string finding where the current  match using the previoius last as the 
      -- third argument, string.find returns two things, the start and end position of the found
      -- match as the second returned value. 'select' returns the value that we want, which is
      -- that second, hence the + 1 then gives us a new place to start searching.
      return match
    end
  end
  return iterator
end

for match in gmatch('ghi, hi','%l+') do -- %l+ is a string pattern, its basically saying grab
-- each set of letters, which are ghi and hi
  print(match)
end
print()

--[[
And I can get even more creative with this. What if I wanted to make an iterator which
only goes through string values of a table?
]]
local function onlyStrings(t)
  local i = 0
  return function()
    i = i + 1
    -- this while loop he uses is buggy at most. It creates a infinite loop at the end
    -- but I fixed it. So I can go up and do the same above
    while type(t[i]) ~= 'string' and i <= #t do
      i = i + 1 -- skipping anything that's not a string
    end
    return t[i]
  end
end
-- NOTE: I'm changing up the example in the tut a bit and just returning the anony func
-- rather than all that local function iterator () then return iterator boilerplate
for v in onlyStrings({2,'hi',true,'hgf','kno'}) do
  print(v)
end
print()

-- what about an interesting iterator?
local function get_properties(obj)
  local properties = {'Name','Anchored','Transparency'} -- keep a list of the properties you
  -- wanna include when looping 
  local i = 0

  return function()
    i=i+1
    local property = properties[i] -- the current property
    return property,obj[property] -- return the property's name and the property's value
    -- obj[property] is basically the same as obj.property (e.g. obj.Transparency == obj['Transparency'])
  end
end

for prop,val in get_properties({a_prop='a value',another_prop='another value',Name='Ladoblanco',Anchored=true,a_third_prop='a third value',Transparency=0.5}) do
  print(prop,val)
end
print()

-- stateful iterators 🤯🤯🤯
local test = get_properties({a_prop='a value',another_prop='another value',Name='Ladoblanco',Anchored=true,a_third_prop='a third value',Transparency=0.5})
print(test())
print(test())
print(test())



