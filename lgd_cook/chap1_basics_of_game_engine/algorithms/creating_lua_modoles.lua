--[[
The Lua language doesn't impose strict policies on what a module should look like. Instead
it encourages programmers to find their own style dpending on the solution.

In this recipe I'll create 3 versions of a module that contains one local variable, one
variable accessible from outside the module, one function that returns a simple value
and a function that uses a value from the current module.

I'll create these are separate files and then required them into this script for the examples

How to do it...

There are 3 types of modules that are most commonly used:
  ▫️ A module that returns a table as a module interface
  ▫️ A module in the form of an object
  ▫️ A module in the form of a singleton object

The first case is used mostly with modules that contain an interface to third-party libraries.
The second type of module is used less often, but it's useful if you need multiple instances
of the same object, for example, a network stack. The last one uses a similar approach as in
the previous case, but this time there's always only one instance of the object. Many games
use the singlton object for the resource management system.

]]

-- Below we'll require and use all the modules that were created

--[[
How it works...

Modules are used with the 'require' function that registers them in the global table 'modules.loaded'.
This table contains the compiled code of EVERY module usd and ensures that each module is loaded only
once. 👌🏾

Object modules return a local variable M, which contains an object interface. However, you can use
any other name for this variable. Choosing between tables or closure as object contained is mostly
a matter of application design.

Variable var1 is always hidden from the outside world and can be changed only by the exposed function.
Variable var2 is freely accessible and can be modified anytime.
]]

local module1 = require 'module1'
local module2 = require 'module2'
local module3 = require 'module3'

-- create two instances of module2
local module2_a = module2()
local module2_b = module2()

-- try to create an instance of module3 twice
local module3_a = module3()
local module3_b = module3()

-- usage of a module with interface table
print('Module 1 - Before:',module1:lorem() .. module1:ipsum())
module1.var2 = 'amet'
print('Module 1 - After:',module1:lorem() .. module1:ipsum())
print()print()

-- usage of a module in a form of an object
print('Module 2a - Before:',module2_a:lorem() .. module2_a:ipsum())
module2_a.var2 = 'amet'
print('Module 2a - After:',module2_a:lorem() .. module2_a:ipsum())
print('Module 2b - After:',module2_b:lorem() .. module2_b:ipsum())
print()print()

-- usage of a module in a form of a singleton object, meaning all 'instances' should be
-- pointing to the same singleton object 🤔
print('Module 3a - Before:',module3_a:lorem() .. module3_a:ipsum())
module3_a.var2 = 'amet'
print('Module 3a - After:',module3_a:lorem() .. module3_a:ipsum())
print('Module 3b - After:',module3_b:lorem() .. module3_b:ipsum())

--[[
Ok so in the then these are 3 examples of how I can organize my code as modules and interlace
them in a final main.lua file. All 3 have their purposes and benefits. But as mentioned, the 
first and third have more practical sense I think.
]]