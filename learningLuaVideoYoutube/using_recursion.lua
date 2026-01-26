--[[
    Using Recursion in Lua
▫️ When a function calls itself
▫️ Extremely powerful when used properly
▫️ Can be used to find solutions to mathematical and programming problems
  (Greatest Common Divisor, Compute Factorial, Binary Search)
▫️ Used to solve complex problems (Towers of Hanoi,
  Fibonacci sequence, fractals)

▫️ Must have an exit condition built intot he function or it will be an infinite loop
]]

local function recursive(counter,limit)
    counter = counter + 1
    print("In recursive loop: " .. counter)
    if counter < limit then
        recursive(counter,limit)
    end
    print("Exiting recursive loop. Step: " .. counter)
end

recursive(0,10)
