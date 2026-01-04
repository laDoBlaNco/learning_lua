--[[
16.1 - CLASSES

A class works as a mold for the creation of objects. Several OO languages offer
the concept of a class. In such languages, each object is an instance of a 
specific class. LUA DOES NOT HAVE THIS CONCEPT OF CLASS; REPEATING CUZ THIS IS
IMPORTANT, LUA DOES NOT HAVE THIS CONCEPT OF A CLASS. IN LUA, EACH OBJECT 
DEFINES ITS OWN BEHAVIOR AND HAS A SHAPE OF ITS OWN. Nevertheless, it isn't 
difficult to emulate classes in lua, following the lead from other prototype-based
languages like Self or NewtonScript or even JS. In these languages, objects have
no classes. Instead, each object may have a prototype, which is a regular object
where the first object looks up any operation that it doesn't know about. (Sounds
like metatables to me 🤔). To represent a class in such languages, we simply
create an object to be used exclusively as a prototype for other objects (its
"instances"). Both classes and prototypes work as a place to put behavior to be
shared by several objects.

In Lua, it is trivial to implement prototypes, using the idea of inheritance that
we learned in section 13.4. More specifically, if we have two objects a and b, all
we have to do to make b a prototype for a is set a metatable  with an index to b

  setmetatable(a,{__index=b})

After that, 'a' looks up in 'b' for any operation that it doesn't have itself. To
see 'b' as the class of object 'a' is not much mroe than a changing of terminology.

let's go back to our Account example. To create other accounts with behavior similar
to Account, we arrange for these new objects to inherit their operations from Account,
using the __index metamethod. A small optimization is that we don't need to create
an extra table to be the metatable of teh account objects; instead we use the Account
table itself for this purpose:
]]
Account = {
  balance=0,
  deposit = function(self,v)
    self.balance=self.balance+v
  end
}
function Account:new(o)
  o=o or {} -- create table if user doesn't provide one
  setmetatable(o,self)
  self.__index = self
  return o
end

--[[
When we call Account:new, self is equal to Account; so, we could have used Account
directly, insetad of self. However, the use of self will fit nicely when we
introduce class inheritance, in the next section). After this code, what happens
when we create a new account and call its method?
]]
a = Account:new{
  balance=0,
}
a:deposit(100.00)
print(a.balance);print()

--[[
When we create a new account, 'a' will have Account (the self in the call to 
Account:new) as its metatable. Then when we call a:deposit(100.00), we are actually
calling a.deposit(a,100.00); Remembering that the colon is only syntactic sugar.
However, lua can't find a 'deposit' entry in table 'a', so it looks into the
metatable's __index and finds it there in Account. So we are basically doing
the following now:
]]
getmetatable(a).__index.deposit(a,100.00)
print(a.balance);print()

--[[
The metatable of 'a' is Account and Account.__index is also Account (since the 
'new' method did self.__index=self). Therefore, the previous expression also 
reduces down to:
]]
Account.deposit(a,100.00)
print(a.balance);print()

--[[
That is, Lua calls the original 'deposit' function, but passing 'a' as the self parameter
So the new account 'a' inherited the 'deposit' function from Account. By the same
mechanism, it can inherit all fields from Account.

The inheritance works not only for methods, but also for other fields that are absent
in the new account. Therefore, a class can provide not only methods, but also default
values for its instance fields. Remember that, in our first definition of Account,
we provided a field 'balance' with the value 0. So, technically, if we create a
new accoutn with an initial balance, ti will inherit the default one:
]]
b=Account:new()
print(b.balance)

b:deposit(50)
print(b.balance)

--[[
When we call the 'deposit' method on b (again using ':' just means we don't have to 
use 'self', that's the only difference) will now create a balance field for b since
self is b in the index 'Account.deposit(b,50)' which does b.balance=b.balance+v
Subsequent calls to b.balance no longer go up the chain of the index metamethod
since 'b' now has its own 'balance' field established. So the 0 we first printed
with print(b.balance) waas actually Account's original balance field, not b's, cuz 
it didn't have now. 🤯🤯🤯
]]




