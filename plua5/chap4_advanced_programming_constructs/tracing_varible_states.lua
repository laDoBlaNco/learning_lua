--[[
Debugging Advanced Lua Constructs

When workign with such constructs, the control flow and variable states can become intricate,
making it essential to have effective debugging stategies. Here I will see how to trace var
states and control flows, identify logical errors, and understand how different parts of the
program interact. These techniques will help me quicly locate and fix issues, ensuring that my
advanced lua programs run as expected.

Tracing Variable States

A fundamental aspect of debugging is monitoring the values of variables during execution. When
dealing with closures or functions that capture state, it can be cahallenging to know when and how
these variables change. One common approach is to insert print statement strategically in our program
code.

]]

function createAccumulator()
  local total = 0
  return function(amount)
    total = total + amount
    print("Accumulator state:",total) -- trace variable state
    return total
  end
end

local accumulate = createAccumulator()
print()
accumulate(5)
accumulate(10)

-- this method is useful in complex loops or recursive functions, where detailed trace of state is 
-- much needed. Then I imagine that I can just comment out these print statements when not in debugging
-- since it doesn't change how the code will work or impact the result.

