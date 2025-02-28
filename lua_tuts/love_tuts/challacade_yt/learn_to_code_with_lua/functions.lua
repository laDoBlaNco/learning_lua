-- functions - if we find ourselves copying code to different places, we probably need a function
local message = 0
local chicken
local monkey = 100

local function increaseMessage(foo)
  foo = foo * 2
  return foo
end



message = increaseMessage(99)
chicken = increaseMessage(monkey)

print(message)
print(chicken)