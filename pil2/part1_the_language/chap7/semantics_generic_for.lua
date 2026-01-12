--[[
7.2 - THE SEMANTICS FOR GENERIC FOR

So one drawback of the previous iterations that we created is that we need to
create a new closure to initialize each new loop. For most situations, this is
not a real problem. For instance, in the allwords iterator from before, the cost
of creating a single closure is negligible compared to the cost of reading a whole
file. However, in some situations, this overhead can be inconvenient. In such cases
we can use the generic for itself to keep the iteration state. In this section, we
are going to see how generic for  facilitates this. 

We saw that the generic for keeps the iterator function internally, during the
loop. Actually, it keeps 3 values:

  -- the iterator function
  -- an invariant state
  -- a control variable

The syntax for the generic for is 

  for <var-list> in <exp-list> do
    <body>
  end

Here, var-list is a list of one or more variable names, separated by commas, and exp-list
is a list of one or more expressions, also separated by commas. More often than not,
the expression list has only one element, a call to an iterator FACTORY. For example:

  for k,v in pairs(t) do print(k,v) end 

Here the <var-list> is k,v and the <exp-list> is the single element pairs(t) (which is 
our iterator factory since it creates our iterator). But this could also be:

  for k,v in next,t do print(k,v) end 

Above we our <exp-list> has 2 elements (iterator and invariant state)

Often the list of variables has only one variable too, as in the next example:

  for line in io.lines() do
    io.write(line,'\n')
  end

We call the first variable in the <var-list> the CONTROL VARIABLE. Its value is never
nil during the loop, because when it is nil, the loop is done.

The first thing the for does is to evaluate the expressions after the 'in' in our <exp-list>.
These expressions should result in the three values kept by for:
  -- the iterator (since the expression is the factory)
  -- the invariant state (still not sure what this is 🤔). YEAH NOW I KNOW ITS PART
     OF THE OVERALL STATE. STATE IS TWO THINGS. CONTEXT (INVARIANT PART) AND CONTROL
     VARIABLE (VARIANT PART)
  -- the initial value for that control variable.

like in a multiple assignment, only the last (or the only) element of the list can
result in more than one value; and the number of values is adjusted to three, extra
values being discarded or nils added as needed. (When we use simple iterators, the 
factory returns only the iterator function, so the invariant state and the control
variable are nil)

After this initialization step, the for calls the iterator function with two args:

  -- the invariant state
  -- the control variable

(from the standpoint of the for construct, the invariant state has no meaning at all. 
The for only passes the state value from the initialization step to the calls to the
iterator funtion). Then the for assigns the values returned by the iterator function
to the variables declared by its variable list. If the first value returned (the one
assigned to the control variable) is nil, the loop terminates. Otherwise, the for
executes its body and calls the iteration function again, repeating the process. 

More precisely, a construction like

  for var_1, ..., var_n in <exp_list> do <block> end

is equivalent to:

  do
    local _f,_s,_var = <exp-list> -- _f is iterator, _s is invariant, _var is control var
    while true do
      local var_1, ..., var_n = _f(_s,_var)
      _var = var_1
      if _var == nil then break end
      <block>
    end
  end

So, if our iterator function is f, the invariant state is s and the intiial value 
for the control variable is a, the control variable will loop over the values changing
a as it goes, until a is nil. If the for has other variables, they simply get the 
extra values returned by each call to f.
]]

--[[ FROM MY DEEP DIVE INTO ITERATORS, PLUGGING THIS ON THE END OF EACH OF THESE FILES
This helped to concrete the idea of lua iterators in my head with two main points:

  1. when talking about state, we are referring to BOTH the invariant state and the 
     control variable. Both are state. They need each other to represent the state
     of our table, for example. tbl is invariant, it doesn't change and doesn't mean 
     much alone. An index 2 does change when incremented, but again doesn't mean much
     alone. But tbl[2] now means something.

  2. The difference between iterators is subtle but powerful:
    • First, how my iterator gets the info needed (stateful vs stateless) 
      • STATEFUL being that our factory just returns a function that tracks its own state
        typical in its own universe in closures. Our loop just runs that function and 
        doesn't worry about anything else as the other expected args (invarint and variant
        state) are nil
      • STATELESS being that our factory returns an iterator function that expects its
        state  as args. Meaning the function doesn't control its  own state, its waiting
        for someone else to track it and give it, typically our for loop. 
    • Second, if I need more data variables than the normal 1 or 2 (v or i,v), then we use
      a complex iterator, which is just packing more info in a table and using that to provide
      all that data that we need including state.
]]
