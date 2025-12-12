--[[
besides global variables, lua supports local variables. I create local vars with the
'local' statement:
]]

-- j = 10 -- global var
-- local i = 1 -- local variable

--[[
Unlike global variables, local variables have their scope limited to the block where they
are declared. A 'block' is the body of control structure , the body of a function, or a
chunk (the file or string where the variable is declared):
]]

x = 10
local i = 1 -- local to the chunk (file)

while i <= x do
  local x = i * 2 -- local to the while body
  print(x)      --> 2,4,6,8,...
  i = i + 1
end
print()

if i >= 20 then
  local x -- local to the 'then' body
  x = 20
  print(x+2)
else
  print(x)  --> the global one
end

print(x) --> 10 (the global one)
print()

--[[
Beware that this example will not work as expected if I enter it into the interactive console
In interactive mode, each line is a chunk by itself (unless it is not a complete command). As
soon as I enter the second line of the example (local i=1), lua runs it and starts a new
chunk in the next line. By then, the local declaration is already out of scope. To solve this
problem, I can delimit the whole block explicitly, bracketing it with the keywords do-end.
One I enter the 'do', the command completes only at the corresponding 'end', so lua does
not execute each line by itself

These do blocks are useful also when I need finer control over the scope of some local variables:
]]

--[[
do
  local a2 = 2*a
  local d = (b^2 - 4*a*c)^(1/2)
  x1 = (-b + d)/a2
  x2 = (-b - d)/a2
end   -- scope of 'a2' and 'd' ends here
print(x1,x2)
--]]

--[[
It is good programming style to sue local variables whenever possible. Local variables 
help me avoid cluttering the global environment with unnecessary names. Moreover, the
access to local variables is faster than to global ones. Finally, a local variable usually
vanishes as soon as its scope ends, allowing its value to be freed by the garbage collector

Lua handles local-variable declarations as statements. As such, I can write local declarations
anywhere I can write a statement. The scope of the declared variables begins after the 
declaration and goes until the end of the block. Each declaration may include an initial
assignment, which works the same way as a conventional assignment: extra values are thrown
away; extra variables get nil. If a declaration has no initial assignment, it initializes
all its variables with nil:
]]

local a,b=1,10
if a < b then
  print(a) --> 1
  local a -- '= nil' is implicit
  print(a) --> nil
end  -- ends the block started at 'then'

print(a,b) --> 1  10


--[[
A common idiom in lua is

  local foo = foo

This code creates a local variable, foo, and intializes it with the value of the global 
variable foo. (local foo becomes visible only after its declaration.) This idiom is useful
when the chunk needs to preserve the original value of 'foo' even if later some other function
changes the value of the global foo; it also speeds up the access to foo since its now local

Because many langauges for us to declare all local variables at the beginning of a block or
(proc), some people think it is a bad practice to use declarations in the middle of a block. 
Quite the opposite: by declaring a variable only when I need it, I seldom need to declare
it without an initial value (and therefor I seldom forget to initialize it). Moreover I shorten
the scope of the variable, which increases readability.

]]