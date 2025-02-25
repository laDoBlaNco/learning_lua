--[[
Making a prioritized queue

A prioty queue extends basic queuing with the entry sorting feature. Upon entry insertion,
I can set what will be the 'priority' of the entry. This data structure is often used in 
job queuing where the most important (highest priority) jobs must be processed before 
the jobs with lower priority. Priority queues are often used in AI as well.

This version of a pqueue will allow me to obtain entries with minimal or maximal priority
at constant time. Element priority can be udpated. However, priority queue insertion, update,
and removal might use linear time complexity in worst case scenarios.

There are 2 rules to note:
  ▫️ Each entry of this queu should be unique
  ▫️ The order of retrieving elements with teh same priority is not defined
]]

local ti = table.insert
local tr = table.remove

-- removes element from table by its value
local tr2 = function(t,v)
  for i=1,#t do
    if t[i]==v then
      tr(t,i)
      break
    end
  end
end

-- I'll need to come back to this one. Not sure sure exactly how this is to work with
-- everything else. Maybe after I go over creating modules.w