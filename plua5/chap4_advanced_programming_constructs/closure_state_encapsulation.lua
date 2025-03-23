--[[
Closures and State Encapsulation

Closures in Lua are functions that capture variables from their surrounding environment or context.
When a fucntion is defined inside another function, the inner function retains access to the outer
function's local variabls even after the outer function has finished executing. This property allows
you to encapsulate state, effectively creating a private variable that aren't accessible from any 
other scope.

Here's the typical example: a counter function that maintains its own state
]]


-- define a function that returns a counter closure function

function createCounter()
  local count = 0 -- 'count' is encapsulated within the closure. Its local for anything outside
  -- of this function, but global for anything iside the context of this function
  return function() -- NOTE that we don't have to pass the variable to the returned function
    count = count+1
    return count
  end
end

-- now we create a new counter instance from that function
local counter1 = createCounter()

print()
print("Counter1:",counter1())
print("Counter1:",counter1())
print("Counter1:",counter1())
print()
-- create a separate counter instance
local counter2 = createCounter()
print("Counter2:",counter2())
print("Counter2:",counter2())
print("Counter1:",counter1())
print()

-- Note  our the two countes hold their own state (count variable). The inner function can access
-- and update this state, demonstrating how closures facilitate encapsulation