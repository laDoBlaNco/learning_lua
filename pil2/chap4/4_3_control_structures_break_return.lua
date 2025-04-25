--[[
4.3 CONTROL STRUCTURES - break and return

The break and return statements allow us to jump out of a block.

I use the break statement to finish a loop. This statement breaks teh inner loop 
(for,repeat, or while) that contains it; it cannot be used outside of a loop. After
the break, the program continues running from the point immediately after the 
broken loop

A return statement returns occasional results from a function or simply finishes
a function. There is aan implicit return at the end of any function, so I don't
need to use one if the function just ends naturally, and I will see that a lot in
the wild.

For syntactic reasons, break or return can appear only as the last statement of a
block; in other words, as the last statement in your chunk or just before an 'end', an 'else'
or an 'until'. For instance, in the next example, 'break' is the last statement of the 
'then' block

local i = 1
while a[i] do
  if a[i] == v then break end
  i = i + 1
end

Usually these are the places where I use these statements, because any other statement
following them would be unreachable. Sometimes, however, it may be useful to write a
'return' or 'break' in the middle of a block; for instance, I may be debugging a function 
and want to avoid its execution. In such cases, I can use an explicit 'do' block around
the statement:

function foo()
  return --> SYNTAX ERROR
  -- 'return' is the last statement in the next block
  do return end --> this is OK
  <other statements>
end

]]