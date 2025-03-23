--[[
Managing Concurrent Tasks - 

We can use coroutines to handle multiple tasks at the same time. If I create a bunch of coroutines
for example and then run them in a round-robin fashion, I can make ti seem like they are running
at the same time.
]]

-- define five coroutine functions
local function task1()
  for i=1,5 do
    print('Task 1, iteration',i)
    coroutine.yield()
  end
end

local function task2()
  for i=1,5 do
    print('Task 2, iteration',i)
    coroutine.yield()
  end
end

local function task3()
  for i=1,5 do
    print('Task 3, iteration',i)
    coroutine.yield()
  end
end

local function task4()
  for i=1,5 do
    print('Task 4, iteration',i)
    coroutine.yield()
  end
end

local function task5()
  for i=1,5 do
    print('Task 5, iteration',i)
    coroutine.yield()
  end
end

-- now we create coroutines for each task (NOTE that the tasks are designed to be coroutines, o sea
-- they have the coroutine calls in them already)
local co1=coroutine.create(task1)
local co2=coroutine.create(task2)
local co3=coroutine.create(task3)
local co4=coroutine.create(task4)
local co5=coroutine.create(task5)

-- now let's create a table 'tasks' so we can schedule our coroutines in a round-robin manner
local tasks = {co1,co2,co3,co4,co5}
local active = true

print()
while active do
  active = false
  for _,co in ipairs(tasks) do
    if coroutine.status(co) ~= 'dead' then -- this is new coroutine syntax para mi
      coroutine.resume(co)
      active = true
    end
  end
  print()
end
print('All tasks completed')

-- here I created 5 coroutines and put them in a table. A loop iterated over the table resuming
-- each coroutine in turn. The loop continues until all coroutines have completed their execution
-- (i.e., their status becomes 'dead') This scheduling stategy demonstrates how I can simulate
-- concurrent operations without complex thread management

-- while coroutines are powerful, I still need to be mindful of their cooperative nature. Since
-- coroutines yield control explicitly, long-running operations within a coroutine that do not
-- yield will block other tasks. Therefore I need to make sure I design the coroutine function 
-- to yield frequently, with that in mind, especially when performing time-consuming computations.