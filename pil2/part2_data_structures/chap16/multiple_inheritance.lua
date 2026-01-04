--[[
16.3 - MULTIPLE INHERITANCE

Because objects are not primitive in lua, there are several ways to do
OO programming in lua. The approach  that we have seen, using the index metamethod
is probably the best combination of simplicity, performance, and flexibiltiy.
Nevertheless, there are other implementations, which may be mroe appropriate for
certain cases. Here we will see an alternative implementation that allows multiple
inheritance in lua.

The key to this implementation is that use of a function for the metafield __index.
Remember that, when a table's metatable has a function in the __index field, lua
will call this function whenever it can't find a key in the original table. Then
__index can look up for the missing key in how many parents it wants.

Multiple inheritance means that a class may have more than one superclass. Therefore,
we can't use a class method to create subclasses. Instead, we will define a specific
function for this purpose, create_class, which has as arguments the superclasses of
the new class. This function creates a table to represent the new class, and sets its
metatable with an __index metamethod that does the multuple inheritance. Despite the
multiple inheritance, each objet instance still belongs to one single class, where it
looks for all its methods. Therefore, the relationship between classes and superclasses
is different from the relationship between classes and instances. Particularly, a class
can't be the metatable for its instances and for its subclasses at the same time. 
Here we keep the class as a metatable for its instances, and create another table
to beh the class' metatable.
]]

-- look up for 'k' in list of tables 'plist'
local function search(k,plist)
  for i=1,#plist do
    local v = plist[i][k]   -- try 'i'-th superclass
    if v then return v end  -- if we find it return it
  end
end

function create_class(...)
  local c = {}
  local parents = {...}

  -- class will search for each method in the list of its parents
  setmetatable(c,{__index=function(t,k)
    return search(k,parents)
  end})

  -- prepare 'c' to be the metatable of its instances
  c.__index=c
  
  -- define a new constructor for this new class
  function c:new(o)
    o=o or {}
    setmetatable(o,c)
    return o
  end

  return c  -- return new class
end

--[[
Now let's illustrate the use of create_class with a small example. Assume our 
previous class Account and another class, Named, with only two methods, setname
and getname:
]]
Account={balance=0}
function Account:new(o)
  o=o or {}
  setmetatable(o,self)
  self.__index=self
  return o
end
function Account:depost(v)
  self.balance=self.balance+v
end
function Account:withdraw(v)
  if v>self.balance then error"insufficient funds" end
  self.balance=self.balance-v
end

Named = {}
function Named:getname()
  return self.name
end
function Named:setname(n)
  self.name = n
end

-- to create a new class NamedAccount tha tis a subclass of BOTH Account and 
-- Named, we simply call create_class:
NamedAccount = create_class(Account,Named)

-- to create and to use instances, we do as usual:
account = NamedAccount:new{name='LadoBlanco'}
print(account:getname())

--[[
Now let's follow this last statement to see how it works. Lua can't find the field 
'getname' in account; so it looks for the field __index of account's metatable,
which is NamedAccount. But NamedAccount also can't provide a 'getname' field, so 
lua looks for the field __index of NamedAccount's metatable. since this field 
contains a function, lua calls it. This function then looks for 'getname' first in
Account, without success, and then in Named, where it finds a non-nil value, which
is the final result of the search.

Of course, due to the underlying complexity of this search, the performance
of multiple inheritance is not the same as single inheritance. A simple way
to improve this performance is to copy inherited methods into the subclasses.
Using this technique, the index metamethod for classes would be like this:

  setmetatable(c,{__index=function(t,k)
    local v = search(k,parents)
    t[k] = v   -- save for next access
    return v
  end})

With this trick, accesses to inherited methods are as fast as to local methods
(except for the first access). The drawback is that it is difficult to change
method definitions after the system is running, since tehse changes do not propogate
down the hierarchy chain.
]]


