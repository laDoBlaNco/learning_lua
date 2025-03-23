--[[
Tracking Control Flow

When working with coroutines or nested functions, it's beneficial to trace control flow to see
when certain functions are called or resumed. So with this, I can accomplish it by adding log
messages at key points. So again its using print statements

]]
local function worker()
  print('Coroutine started.')
  for i = 1,3 do
    print('Processing step:',i)
    coroutine.yield() -- yield control back to the main program
    print('Resuming at step',i)
  end
  print('Coroutine finsihed')
end

local co = coroutine.create(worker)
print()
print('Resuming coroutine first time:')
coroutine.resume(co)
print('Resuming coroutine second time:')
coroutine.resume(co)
print('Resuming coroutine third time:')
coroutine.resume(co)
print('Resuming coroutine final time:')
coroutine.resume(co)

-- The added print statements clarify the sequence of execution, revealing, where the coroutine
-- yields and resumes. This information is invaluable when tracking down issues in concurrent
-- or iterative processes



