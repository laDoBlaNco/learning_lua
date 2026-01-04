--[[
16.2 - INHERITANCE

Since classes are objects, they can get methods from other classes as well. This
behavior makes inheritance (in the usual OO meaning of course) quite easy to
implement in lua.

Let's assume we have a base class (table) like Account
]]
Account = {balance=0}
function Account:new(o) -- colon same as doing 'Account.new(self,o)'
  o=o or {}
  setmetatable(o,self)
  self.__index=self
  return o
end

function Account.deposit(self,v)
  self.balance=self.balance+v
end

function Account:withdraw(v)
  if v > self.balance then error"insufficient funds" end
  self.balance=self.balance-v
end

--[[
From this class, we want to drive a subclass SpecialAccount that allows the
customer to withdraw more than their balance. We start with an empty class 
that simply inherits all its operations from its base class:
]]
SpecialAccount=Account:new()

-- up to now, SpecialAccount is just an instance of Account. The nice thing 
-- happens now:
s = SpecialAccount:new{limit=1000}

--[[
SpecialAccount inherits 'new' from Account as expected. This time though, when we
execute it, its 'self' will refer to SpecialAccount. So, the metatable of s will
be SpecialAccount, whose value at field __index is also SpecialAccount. So 's'
inherits from SpecialAccount, which inherits from Account. So that means when
we do:
]]
s:deposit(100)

--[[
Lua can't find .deposit in 's', so it looks in SpecialAccount; it can't find it
there either so it looks into Account and there's where it finds it.

What makes SpecialAccount special is that we can redefine any method inherited 
from the superclass. All we have to do is to write the new method and then when
lua goes looking for fields, they'll be found in SpecialAccount. 
]]
function SpecialAccount:withdraw(v)
  if v-self.balance >= self:getlimit() then
    error"insufficient funds"
  end
  self.balance=self.balance-v
end
function SpecialAccount:getlimit()
  return self.limit or 0
end

--[[
Now, when we call s:withdraw(200), lua doesn't need to go to Account, since it finds
it in SpecialAccount first. Because s.limit is 1000 (as we set it when we created it),
the program does the withdrawal, leaving s with a negative balance
]]
s:withdraw(200)
print(s.balance)

--[[
An interesting aspeci of objects in lua is that we don't need to create a new class
to specify a new behavior. If only a single object needs a specific behavior, then
we can implement that behavior directly in the object. For example, if the account
's' represents some special client whose limit is always 10% of their balance,
we can modify only this single account:
]]
function s:getlimit()
  return self.balance*0.10
end

--[[
After this declaration, teh call s:withdraw(200.00) we run the withdraw from
SpecialAccount, but teh self:getlimit will run this last definition we created
since getlimit is found in 's'
]]



