-- when we create variables without the 'local' keyword, then they are 'global' meaning 
-- they can be accessed anywhere in the program, even from other files. 
-- local on the other hand can only be accessed in the file or the 'scope' they are created in  
local message = 0
local chicken = 0
local monkey = 100

-- Doubles a value and returns it
local function increaseMessage(foo)
  local var = foo
  var = var/2
  return var
end


---[[
message = increaseMessage(99)
-- chicken = increaseMessage(monkey)
--]]
print(message)
print(chicken)
