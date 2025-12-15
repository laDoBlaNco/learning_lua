--[[
4.2 - Local Variables and Blocks

As the linter has been calling out, I should use 'local' as much as possible to
avoid global variables
]]

j = 10 -- global variable
local i = 1 -- local variable

print(j, i)
print()

-- in lua a block is the body of a control structure, the body of a function, or a
-- chunk (the file or string where the variable is declared)
x = 10
local i = 1 -- local to the chunk

while i <= x do
	local x = i * 2 -- local to the while body
	print(x) --> 2,4,6,8,...
	i = i + 1
end

if i > 20 then
	local x -- local to the 'then' body
	x = 20
	print(x + 2) -- (would print 22 if test succeeds)
else
	print(x) -- the global one
end

print(x) -- the global one

--[[
Its is good programming style to use local variables when possible. Local variables
help avoid cluttering the global env with names. Moreover, the access to local vars
is FASTER than to global ones. Finally, a local variable usually vanishes as soon
as its scope  ends, allowing its value to be freed by the garbage collector.

Lua handles local-variable declaration as statements. Asi que, I can write local
variable declarations anywhere I can put a statement. The scope of the declared
variables begins after the declaration and goes until the end of the block. Each
declaration may include an initial assignment, which works the same way as a 
conventional assignment; extra values are thrown away and extra variables are
nil. If a declaration has no initial assignment, it initializes with nil
]]

print()
local a, b = 1, 10
if a<b then
  print(a) -- a is 1
  local a -- '= nil' is implicit
  print(a) -- a is nil until end of block
end
print(a,b) -- a is 1 again
print()

--[[
Since most languages force you to declare all local variables at the beginning of 
a block, its thought of as bad practice to use declarations in the middle of a 
block. But in lua its quite the opposite; by declaring a var only when you need
it, you seldom need to declare it without its initial value (and therefore seldom
forget to initialize it). Also you shorten the scope of the variable, which increases
readability.
]]
