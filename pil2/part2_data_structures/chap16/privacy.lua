--[[
16.4 - PRIVACY

Many people consider privacy to be an integral part of an OO language; the 
state of each object should be its own internal affair. In some OO languages
(such as c++ and Java) you can control whether an object field (also called
an instance variable) or a method is visible outside the object. Other languages,
like Smalltalk, make all variables private and all methods public. The first
OO language, Simula, didnt' offer any privacy or protection at all.

The main design for objects in Lua, which we have shown previoulsy, doesn't
offer privacy mechanisms. Partly, this is a consequence of our use of a general
structure (tables) to represent objects. But this also reflects some basic
deisng decisions made behind lua. Lua is not intended for building huge robust
programs, where many programmers are involved for long periods. Quite the opposite
actually, Lua aims at small to medium programs, usually part of larger systems,
typically developed by one or a few programmers at most, or even by non-programmers.
Therefore lua avoids too much redundancy an artificial restrictions. If we don't
want to access something inside of an object, we just don't do it.

Nevertheless, another amim of Lua is to be flexible, offering to the programmer
meta-mechanisms that enable them to emulate many different mechanisms. Although
the basic design for objects in lua doesn't offer  privacy mechanisms, we can
implement objects in a different way, so that we have access control. Although
this implementation is not used  frequently, it is instructive to know about it,
just in case we see it in the Lua wild. It explores some insteresting corners of
lua and it can be a good solution for other problems that we might encounter.

The basic idea if this alternative design is to represent each object through
TWO tables: 
  • one for its state;
  • another for its operations, or its INTERFACE

The object itself is accessed through the interace, that is, through the second
table. To avoid unauthorized access, the table that represents the state of
an object is not kept ina  field of the other table, instead it is kept only in
the closure of the methods 🤯🤓. For instance, to represent our bank again
with this design, we would create new objects running the following factory functions
instead of a simple :new method
]]

--[[
function new_account(initial_balance)
  local self = {balance=initial_balance}
  local withdraw = function(v)
    self.balance=self.balance-v
  end
  local deposit = function(v)
    self.balance=self.balance+v
  end
  local get_balance = function() return self.balance end

  return{
    -- wouldn't we return self instead at some point 🤔 -- NOW I GET IT. SINCE
    -- WE ARE RETURNING THESE FUNCTIONS IN A TABLE, THEY ARE NOW ALL CLOSURES
    -- AND THEY ACCESS THE LOCAL SELF TABLE DIRECTLY INSIDE THEIR OWN CLOSURE UNIVERSE
    withdraw=withdraw,
    deposit=deposit,
    get_balance=get_balance
  }
end
--]]

--[[
First, the function creates a table to keep the internal object STATE and
stores it in a local variable  'self'. Then the function creates the methods
of the object. Finally, the function creates and returns the external object,
which maps method names to the actual method implementations. The key point
here is taht these mthods do NOT GET SELF as an extra parameter; instead,they
access 'self' directly. Because there is no extra argument, we don't use the
: syntax to manipulate such objects. The methods are called just like regular
functions
]]

--[[
acc1 = new_account(100)
acc1.withdraw(40)
print(acc1.get_balance())
--]]

--[[
This design gives us full privacy to anything stored in the 'self' table. After
new_account returns, there is no way to gain direct access to this table. We can
access it ONLY through the functions created inside new_account. Although our
example puts only one instance variable into the private table, we can store
all private parts of an object in this table as well. We can also define private
methods: they are just like public methods in 'new_account', but we don't put them
into the INTERFACE table that is returned, so again they are just used by the 
functions we return in the interface but don't have any other access to them. For
instance, our accounts may give an extra credit of 10% for users with balances
above a certain limit, but we don't want the users to have access to the details
of that computation. We can implement this functionality as follows:
]]
---[[
function new_account(initial_balance)
  local self = {
    balance=initial_balance,
    LIM = 1000.00,
  }

  local extra = function()
    if self.balance>self.LIM then
      return self.balance*.10
    else
      return 0
    end
  end

  local get_balance = function()
    return self.balance+extra()
  end

    local withdraw = function(v)
    self.balance=self.balance-v
  end
  local deposit = function(v)
    self.balance=self.balance+v
  end
  return{
    withdraw=withdraw,
    deposit=deposit,
    get_balance=get_balance
  }

end
--]]

-- again, there is no way for any user to access the 'extra' function direclty

acc2 = new_account(100)
acc2.withdraw(40)
print(acc2.get_balance())
print()
acc2.deposit(1500)
print(acc2.get_balance()) --> 1716 (10% increase) instead of expected 1560


