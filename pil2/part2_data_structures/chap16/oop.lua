--[[
Chapter 16 - OBJECT-ORIENTED PROGRAMMING

A table in lua is an object in more than oen sense. Liek objects, tables have
a state. Like objects, tables have an identity (a self) that is independent of 
their values; specifically, two objects (tables) with teh s ame value are
different objects, whereas an object can have different valeus at different
times. Like objects, tables have a life cycle that is independent of who created
them or where they were created.

Objects have their own operations. Tables also can have operations:
]]
--[[
Account = {balance = 0}
function Account.withdraw(v)
  Account.balance = Account.balance-v
end
--]]
-- This definition creates a new function and stores it in a field 'withdraw' of
-- Account object. Then we can call it as
--[[
Account.withdraw(100.00)
print(Account.balance)
--]]
--[[
This kind of function is ALMOST what we would call a method. However, the use of
the global name Account inside the function is a bad programming practice. 
  • First, this function will work only for this particular object. 
  • Second, even for this particular object, the function will work only as long
    as the object is stored in that particular global variable. If we change the
    object's name, 'withdraw' doesn't work anymore
]]
a = Account; Account = nil
-- a.withdraw(100.00) -- error attempt to index global 'Account' (a nil value)
--[[
Such behavior violates the previous principle that objects have independent life
cycles.

A more flexible approach is to operate on the 'receiver' of the operation. For
that, our method would need an extra parameter with teh value of the receiver.
This parameter usually has the name 'self' or 'this':
]]
Account = {balance = 500.00}
function Account.withdraw(self,v)
  self.balance=self.balance-v
end
a1 = Account
a1.withdraw(a1,100.00)
print(a1.balance)

-- with the use of 'self', we can use teh same method for many objects

a2 = {balance=0,withdraw=Account.withdraw}
a2.withdraw(a2,260.00)
print(a2.balance)
print()

--[[
This use of a 'self' parameter is a central point in any object-oriented language. 
Most OO languages have this mechanism partly hidden from the programmer, so that
we don't have to declare it (although we can still use the name 'self' or 'this'
inside a method). Lua can also hide this parameter, using the 'colon operator'. We
can rewrite the previous method definition as so, with is nust syntactic sugar
]]
function Account:withdraw(v)
  self.balance=self.balance-v
end

-- and the call would also be with the colon ':'
a1:withdraw(100.00)
print(a1.balance);print()

--[[
The effect of the : is just to add an extra hidden parameter in a method definition
and to add an extra argument in a method call. The colon is only a syntactic sugar,
although a convenient one; there is nothing really new here. We can define a 
function with the dot syntax and call it with the colon syntax, or vice-versa,
as long as we handle the extra parameter correctly
]]
Account = {
  balance=0,
  withdraw=function(self,v)
    self.balance=self.balance-v
  end
}
function Account:deposit(v)
  self.balance=self.balance+v
end

Account.deposit(Account,200.00)
Account:withdraw(100.00)
print(Account.balance)

--[[
Our objects have an identity, a state, and operations over this state. They still lack
a class system, inheritance, and privacy though. Let's tackle the first problem:
How can we create several objects with similar behaviors? Specifically, how can
we create several accounts?
]]



