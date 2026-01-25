---@diagnostic disable: undefined-field, need-check-nil
#! /usr/bin/lua

--[[
A SMALL PERFORMANCE TRICK

Usually, in lua, its faster to read a file as a whole than to read it line by line.
However, sometimes we must face a big file (say, tens or hundreds of mbs) for whhich
it is not reasonable to read it all at once. If we want to handle such big files 
with maximum performance, the fastest way is to read them in reasonably large
chunks (e.g., 8kbs each). To avoid the problem of breanking lines in the middle,
we simply ask to read a chunk plus a line:

  local lines,rest = f:read(BUFSIZE,'*line')

So the variable 'rest' will get the rest of any line broken by the chunk. We then
concatentate that chunk and the rest of the line.This way, the resulting chunk will
always break at line boundaries.

Here is an example using this technique to implement a character counting program
that counts chars, words, and lines in a file.
]]
local BUFSIZE = 2^13 -- 8k
local f = io.input(arg[1])  -- open input file
local cc,lc,wc=0,0,0
while true do
  local lines, rest = f:read(BUFSIZE,'*line')
  if not lines then break end
  if rest then lines = lines .. rest .. '\n' end
  cc = cc + #lines

  -- count words in the chunk
  local _,t = lines:gsub('%S+','')
  wc = wc + t

  -- count newlines in the chunk
  _,t = lines:gsub('\n','\n')
  lc = lc + t
end
print('Line Count:',lc)
print('Word Count:',wc)
print('Character Count:',cc);print()

--[[
A quick note about 'arg':
In Lua, 'arg' has two main contexts, one for command-line arguments and another 
(in older version of lua) for variable function arguments. The behavior of 'arg'
depends a lot on the specific version of lua being used. I'll focus on 5.1

Command-line Arguments:
When a lua script is executed from the commandline, the 'arg' variable is a global table
that stores the arguments passed to the script.

  • arg[0] typically contains the name of the script file itself
  • arg[1], arg[2], and so on contain the actual arguments provided by the user, AS STRINGS
  • In Lua 5.1 (my version), the table ALSO contains a field 'arg.n' with the total number
    of arguments.

Variable Function Arguments (Deprecated in Modern Lua)
In older versions of Lua (pre 5.1), when a function was defined to accept a variable
number of of arguments (indicated by ...), those arguments were collected into an implicit
local table called 'arg' within the function's scope. This table included a field 'n'
for the argument count.

The modern approach (5.1 and later) uses, instead of the hidden 'arg' table within the
function, the '...' acting as a multiple return value expression, which can be stored
in a local table using the {...} syntax or accessed with the 'select' function. So 
basically rather than ... in the function signaling the creation of a phantom table
to hold its args, now ... itself is put into a table and used in the function.. 

In summary, the specific meaning of 'arg' depends on whether its a global variable
in a standalone scipt or a (deprecated) local variable in a variadic function, and
which version of the lua interpreter we're using.
]]
function modernFunction(...)
  -- collect the variable arguments into a table
  local args = {...}

  -- print the first argument
  print(args[1])

  -- get the number of arguments
  print(select('#',...));print()

end
modernFunction('apple','banana','orange','cherry')