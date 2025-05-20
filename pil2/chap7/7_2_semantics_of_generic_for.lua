--[[
7.2 - THE SEMANTICS OF THE GENERIC FOR

One drawback of those previous iterators is that I need to create a new closure to intialize
each new loop. For most situations, this is not a real problem. For instance, in the 'allwords'
iterator, the cost of creating one signle closure is negiigible compared to the cost of reading
a whole file. However, in some situations this overhead can be inconvenient. In such cases, I can
use the generic 'for' itself to keep the iteration state. In this section I'll see the facilities
that the generic for offers to hold state.

I saw tha the generic for keeps the iterator function internally, during the loop. Actually, it
keeps 3 values: the ITERATOR FUNCTION, an INVARIANT STATE, and a CONTROL VARIABLE. 

The syntax for the generic for is as follows:

  for <var-list> in <exp-list> do
    <body>
  end

Here, <var-list> is a list of one or more variable names, separated by commas, and <exp-list> is a
list of one or more expressions, also separated by commas. More often than not, the expression 
list has only one element, a call to an iterator factory. For example:
]]

local t = {10,9,8,7,6,5,4,3,2,1}
for k,v in pairs(t) do print(k,v) end
print()

-- here the list of variables is k,v and the list of expressions has the single element pairs(t)
-- Often the list of variables has only one variable too, as in the next loop

--[[
for line in io.lines() do
  io.write(line,'\n')
end
--]]

--[[
Here I call the first variable in the list the CONTROL VARIABLE. Its value is never nil during
the loop, because when it becomes nil the loops ends.

The first thing the for does is to evaluate the expression after the 'in'. These expressions 
should result in the 3 values kept by the for: the iterator function, the invariant state, and the 
intital value for the control variable. Like in multiple assignment, only the last (or the only) 
element of the list can result inmore than one value; and the number of values is adjusted to 
three, extra values being discarded or nils added as needed. (When we use simple iterators, the
factory returns only the iterator function, so the invariant and the control variable  get nil)

After this initialization step, the 'for' calls for iterator function with two arguments: 
  ▪ The invariant state
  ▪ the control variable

(From the standpoint of the 'for' construct, the invariant state has no meaning at all. The 'for'
only passes the state value from the initialization step to the calls to the iterator function)
The the 'for' assigns the values returned by the iterator function to the variables declared by its
variable list. If the first value returned (the one assigned to the control variable) is nil, the
loop terminates. Otherwise, the 'for' executes its body and calls the iteration function again, 
repeating the process. 

More precisely, a construction like

  for var_1, ..., var_n in <explist> do <block> end

is equilvaent to the following:

  do
    local _f, _s, _var = <explist>
    while true do
      local var_1, ..., var_n = _f(_s, _var)
      _var = var_1
      if _var == nil then break end
      <block>
    end
  end

So as I can see if the iterator function is 'f', the invariant state is 's', and the intial value
for the control variable is 'a0', the control variable will loop over the values
  a1 = f(s,a0)
  a2 = f(s,a1)
  etc.

and so on, until ai is nil. If the 'for' has other variables, they simply get the extra  values
returned by each call to our iterator 'f'
]]

