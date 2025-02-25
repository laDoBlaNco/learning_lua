-- module3.lua
--[[
A module in the form of a Singleton Object

This is a special case of object module. There is only oen and the same object instance:
]]

local instance

local M = function()
  if not instance then -- this only happens if there isn't already an instance out there
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
  end
  return instance
end
return M
