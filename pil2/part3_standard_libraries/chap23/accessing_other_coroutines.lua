  --[[
#Accessing other coroutines

All introspective functions from the debug library accept an optional coroutine
as there first argument, so that we can inspect the coroutine from outside. For
instance, consider the next example:
--]]
co = coroutine.create(function()
  local x = 10
  coroutine.yield()
  error('some error')
end)

coroutine.resume(co)
print(debug.traceback(co))

--[[
The trace doesn't go through the call to `resume`, because the coroutine and the 
main program run in different stacks.

If a coroutine raises an error, it doesn't unwind its stack. This means that 
we can inspect it after the error. Continuing our example, if we resume the
coroutine again it hits the error:
--]]

print(coroutine.resume(co))

-- we can also inspect local variables from a coroutine, even after an error
print(debug.getlocal(co,1,1))
