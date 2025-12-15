--[[
4.4 - Break and Return

Break and return work as I would expect them to in any other language. Break is used
to get out of the inner loop (for, repeat, or while). It can only be used in a loop.

Return returns occasional results from function or simply finishes the function. 
There is an implicit return at the end of any function, so I don't need to use
one if my function ends naturally, without returning any value.

break or return CAN ONLY APPEAR AT END OF ITS BLOCK. As the last statement of a chunk,
or just before an 'end', an 'else', or an 'until'. 

For example here its at the end of a 'then' block

  if a[i] == v then break end

If you do want to return early maybe for debugging purposes and its not at the end
of a block, wrapping the return or break in do-end will work

for example:

function foo()
  return  -- this will be an error

  -- 'return' is the last statement though in the next block
  do return end -- this is ok
  <other statements
end
]]

