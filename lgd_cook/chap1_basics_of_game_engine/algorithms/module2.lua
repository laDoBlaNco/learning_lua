-- module2.lua
--[[
A module in the form of an object

This module type doesn't manipulate the global namespace. Every object I create uses
its own local namespace
]]

local M = function()
  local instance
  local var1 = 'ipsum'

  instance = {
    var2 = 'sit',
    lorem = function()
      return 'lorem'
    end,
    ipsum = function(self)
      return var1 .. self.var2
    end,
  }
  return instance
end

return M -- so M is basically a constructor. Not sure though why we aren't using the ':' syntax
-- maybe I see the connection in the examples. 🤔