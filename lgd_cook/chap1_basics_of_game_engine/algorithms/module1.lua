-- module1.lua

--[[
A module that returns a table as an interface

In this case, themodule uses locally defined vars and functions. Every function intended
for external use is put into one table. This common table is used as an interface with 
the outer world and is returned at the end of the module. This is what I did when creating 
some of the games with love2d
]]

local var1 = 'ipsum'
local function local_function1()
  return 'lorem'
end

local function local_function2(self)
  return var1 .. self.var2
end

-- returns module interface
return {
  lorem = local_function1,
  ipsum = local_function2,
  var2 = 'sit'
}
