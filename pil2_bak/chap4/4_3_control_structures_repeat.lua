--[[
4.3 CONTROL STRUCTURES: repeat

As the name implies, repeat-until statement repeats its body 'until' its condition is
true. The test is done after the body, sot he body will always execute at minmum once.
]]


-- print the first non-empty input line
repeat
  line = io.read()
until line ~= ''
print(line)

-- unlike in most other languages, in lua the scope of the local var declared inside
-- a loop includes the condtition 🤔 Not sure what that means
--[[ Ok I get it now. Even though I do a 'local' var in the loop, its still availabile outide
the loop for the condition. THE CODE BELOW DOESN'T WORK SINCE i DON'T HAVE A 'x' VAR SET
local sqr = x/2
repeat
  sqr = (sqr + x/sqr)/2
  local error = math.abs(sqr^2-x) 
until error < x/10000     -- 'error' still visible here, outside loop but part of condition
]]