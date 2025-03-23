--[[
Coroutines (which remind me a goroutines) allow me to suspend and resume functions at specific points
in their execution, making it possible to manage concurrent tasks without the overhead of operating
system threads. Coroutines in lua are similar to functions but can pause execution using the
coroutine.yield function and then resume later using coroutine.resume. So not exactly the same as
goroutines at all. 🤔🤔🤔

This allows me to implement non-blocking operations in a cooperative manner. Unlike preemptive
multitasking, where the operating system manages context switching, coroutines give me full 
control over when a task pauses and resumes, making it easier to debug and reason about my code. 

Let's see ow coroutines enable us to perform long-running ops such as processing large dattasets
or waiting for i/o events, without freezing the main program flow.

]]

-- coroutine.create wraps a function to become a coroutine. The coroutine DOES NOT START executing
-- immediately; instead I have to initiate it with coroutine.resume

-- define a coroutine function
local function worker()
  print('Coroutine started.')
  for i=1,3 do
    print('Processing step',i)
    coroutine.yield() -- pause execution after each step
  end
  print('Coroutine finished.')
end

-- now we create our coroutine from that function
local co = coroutine.create(worker)

-- now we can start and stop the coroutine multiple times to see its behavior
print()
print('Main program resumes coroutines:')
coroutine.resume(co) -- starts and runs until the first yield
coroutine.resume(co) -- Resumes from the previous yield
coroutine.resume(co) -- Continues execution
coroutine.resume(co) -- completes the coroutine execution

