--[[
13.1 - ARITHMETIC METAMETHODS

In this section, we're going to introduce a simple example to explain how to use
metatables. Now let's suppose we are using tables to represent sets, with functions
to compute the union of two sets, intersection, and the like. To keep our namespace
clean, we store all these functions iside a table called 'Set':
]]

Set = {}
local mt = {}

-- let's create a new set with the values of the given list (table)
function Set.new(l)
  local set = {}
  setmetatable(set,mt)
  for _,v in ipairs(l) do set[v]=true end
  return set
end

-- similar process for other Set.functions
function Set.union(a,b)
  -- added a check on operand types
  if getmetatable(a) ~= mt or getmetatable(b) ~= mt then
    error("attempt to 'add' a set with a non-set value",2)
  end
  local res = Set.new{} -- remember this is just Set.new({}) an empty {} is the arg
  -- adding all the keys from both a & b into res, and since there can only be unique
  -- keys, any repeats are simply shadowed and the result is a union of both sets
  for k in pairs(a) do res[k] = true end
  for k in pairs(b) do res[k] = true end
  return res
end

function Set.intersection(a,b)
  local res = Set.new{}
  -- here we are comparing both sets but using the keys from a to pull the keys from b
  -- and add them to res. So the only keys from b moved to res are the ones that are
  -- also in a. o sea, the intersection 🤯🤓
  for k in pairs(a) do
    res[k] = b[k]
  end
  return res
end

-- let's also create a printing function to help us check our example
function Set.tostring(set)
  local l = {}    -- list to put all elements from the set
  for e in pairs(set) do
    l[#l + 1] = e -- #l+1 (0+1) is 1, then 2, and then 3 sucesivamente
  end
  return '{'..table.concat(l,', ')..'}'
end

function Set.print(s)
  print(Set.tostring(s))
end

--[[
So now, we want to make the addition operator ('+') compute the union of two
sets. For that, we'll arrange for all tables representing sets to share a 
metatable, which will define how they react to the addition operator. Our first
setp is to create a regular table that we'll use as our metatable for sets:
]]
-- local mt = {}     -- metatable for sets

--[[
Now the next step is to modify the Set.new function, which creats sets. The new version 
has one extra line, which sets 'mt' as the metatable for the tables that IT creates (NOT
ALL TABLES THAT ARE CREATED BY LUA)
]]

function Set.new(l)  -- 2nd version
  local set = {}
  setmetatable(set,mt)
  for _,v in ipairs(l) do set[v] = true end
  return set
end

-- now after this, every set we create with Set.new will have that same table as its 
-- metatable
s1 = Set.new({10,20,30,50})
s2 = Set.new{30,1}  -- remember that this is the same as above 'Set.new({30,1})'
print(getmetatable(s1))
print(getmetatable(s2));print()

-- finally we just add to the METATABLE a METAMETHOD, a field __add that describes
-- how to perform the addition:
mt.__add = Set.union

--[[
After that, whenever lua tries to add two sets (our sets, not any table out there), it
will look for __add in mt and call Set.union, with the two operands as args. 
(I wonder if we can use self, or this as one of those operands 🤔🤔 something to investigate
later)

With the metamethod in place, we can use the addition operator to do set unions
with our newly created sets
]]
s3 = s1+s2 -- I tried to add to strings and got an error, but since lua found __add in mt
-- all good
Set.print(s3);print() -- 🤯🤯🤯🤓🤓🤓

-- Similarly, we can set the multiplication operator to perform set intersection
mt.__mul = Set.intersection
Set.print((s1+s2)*s1);print()
--[[
NOTE: Great learning lesson. I just spent 20 mins debugging a stupid error where I thought
it was the order of my functions, and confusing me about how lua reads my file, and in the
end it was cuz I for to 'return res' on Set.intersection 🤦🏾🤦🏾🤦🏾
]]

--[[
For each arithmetic operator there is a corresponding field name in a metatable. 
  • __add (addition)
  • __sub (subtraction)
  • __mul (multiplication)
  • __div (division)
  • __unm (negation)
  • __mod (modulo)
  • __pow (exponentiation)
  • __concat (concatenation)

When we add two sets, there is no question about what metatable to use. However, what
if we have a mix expression? Mixing two values with different metatables, or no 
metatable at all?
]]
print(getmetatable(8));print()
s = Set.new{1,2,3}
-- s = s + 8 -- error "bad argument #l to 'pairs' (table expected, got number)"

--[[
When looking for a metamethod, lua does the following steps:
  • if the first value has a metatable with an __add field, use it, independently of 
    the second value;
  • otherwise, if the second value has a metatable with an __add field, lua uses it
  • oterwise, lua raises an error

So technically lua doesn't care about mixed types and is using our metamethod as we
told it to, but our implementation is what cares about them. When we run s=s+8, the
error is inside of Set.union

If we want more lucid error messages, we need to check the type of the operands
explicitly before attempting to perform the operation. (added above)
]]

--[[
13.2 - RELATIONAL METAMETHODS

Metatables also allow us to give meaning to the relational operators, through 
the metamethods:
  • __eq (equal to)
  • __lt (less than)
  • __le (less than or equal to)

There are no separate metamethods for the other 3 relational operators 🤔, as
lua translates a~=b to not(a==b), a>b to b<a, and a>=b to b<=a 🤯 (wow)

Actually until lua 4.0, ALL order operators were translated to a single one,
by translating a<=b to 'not(b<a)'. However, this translation is incorrect when 
we have a partial order, that is, when not all elements in our type are properly
ordered. For example, floating-point numbers are not totally ordered in most 
machines, because of the value Not a Number (NaN). According to the IEEE 754
standard, currently adopted by virtually all floating-point hardware, NaN
represents undefined values, such as the result of 0/0. The standard specifies
that any comparison that involves NaN should result in false. This means that
NaN <= x is always false, but x<NaN is also false. It also implies that the
translation from a<=b to not(b<a) is not valid in this case. 🤓🤓

In our example with sets, we have a similar problem. An obvious (and useful)
meaning for <= in sets is set containment: a<=b means that a is a subset of b.
With this meaning, again, it is possible that both a<=b and b<a are false;
therefore, we need separate implementations for __le and __lt:
]]



mt.__le = function(a,b)  -- set containment
  for k in pairs(a) do
    if not b[k] then return false end
  end
  return true
end
mt.__lt = function(a,b)
  return a<=b and not (b<=a)
end

-- finally we can define set equality through set containment
mt.__eq = function(a,b)
  return a<=b and b<=a
end

s1 = Set.new{2,4}
s2 = Set.new{4,10,2}
print(s1 <= s2)
print(s1<s2)
print(s1>=s1)
print(s1>s1)
print(s1==s2*s1);print()

--[[
So unlike the arithmetic metamethods, relational metamethods can't be applied to mixed types.
Their behavior for mixed types mimics the common behavior of these operators in lua. 
If we try to compare a string with a number for order, lua raises an error. Similarly
if we try to compare two objects with different metamethods for order, lua raises an error.

an equality comparison never raises an error, but if two objects have different metamethods,
the equality operation results in false, without even calling any metamethod. Again this
behavior mimics the common behavior of lua, which always classifies strings as different
from numbers, regardless of their values. Lua calls an equality metamethod only when the
to objects being compared share that metamethod.
]]

--[[
13.3 - LIBRARY-DEFINED METAMETHODS

Its common practice for libraries to define their own fields in metatables. So far,
all of the metamethods we've see are for the lua core. It is the virtual machine that
is detecting that the values involved in an operation have metatables and that these
metatables define metamethods for tha operation. However, since metatables are regular
tables, they can be used by anyone.

The function 'tostring' provides a typical example for us. As we saw earlier, 'tostring'
represents tables in a rather simple format:
]]
print(s1)

--[[
(The function 'print' always calls 'tostring' (as in other languages) to format its
output). However, when formatting any value, 'tostring' first checks whether the value
has a '__tostring' metamethod. (very similar to other OOP languages so far). In this
case, 'tostring' calls the metamethod to do its job, passing the object as an 
argument. Whatever this metamethod returns is the result of 'tostring'.

In our example with sets, we've already defined a function to present a set as a
string. So we need only to set the __tostring field in the metatable:
]]
mt.__tostring = Set.tostring
-- after that, whenever we call 'print' with one of our sets as its arg, 'print' calls
-- 'tostring' that calls 'Set.tostring'
print(s1);print()

--[[
The functions 'setmetatable' and 'getmetatable' also use a metafield, in this 
case to protect metatables. (so why do we use the term 'metafield' instead of 
'metamethod' here? 🤔 - According to Google, the terms both refer to entries
within a metatable, but they describe the  TYPE of data stored at the specific
key and how lua uses it.

  • Metamethod: Specifically refers to a FUNCTION assigned to a metatable key (like
    __add or __index) that lua calls to handle a specific operation.
  • Metafield: A broader term for any ENTRY (key-value pair) in a metatable. While
    many metafields ARE metamethods (functions), some metafields can be other data
    types like tables or strings.

So this means that when we reference metafields here, its because we are going to
using something other than a function for this 'protection'.) Suppose that we want
to protect our sets, so that users can neither see nor change their metatables.
If we set a __metatable field in a metatable, 'getmetatable' will return the
value of this field, whereas 'setmetatable' will raise an error.
]]
mt.__metatable = 'not your business'
print(getmetatable(s1))
-- setmetatable(s1,{}) -- error "cannot change a protected metatable"



