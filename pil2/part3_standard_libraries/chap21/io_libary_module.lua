--[[
Chapter 21 - THE I/O LIBRARY
The IO library offers two different models for file manipulation. The simple
model assumes a 'current input file' and a 'current output file', and its IO
operations operate on these files. The complete model uses explicit file 
handles; it adopts an object-oriented style that defines all aperations as methods
on file handles.

The simple model is conventient for simple things; we have been using it throughtout
the book until now. But it isn't enough for more advanced file manipulation, such as 
reading from several files simultaneously. For these manipulations, we need the
complete model

21.1 - THE SIMPLE I/O MODEL
The simple model does all of its operations on two current files. The library
initializes the current input file as the process standard input (stdin) and the
current output file as the process standard output (stdout). Therefore, when we 
execute something like io.read(), we read a line from the standard input.

We can change these current files (current meaning the default is stdin and stdout)
with the io.input and io.output functions. A call like io.input(filename) opens the
given file in read mode and sets it as the CURRENT input file. From this point on, all
input will come from this file, until another call to io.input; io.output does a 
similar job for output. In case of error, both functions raise the error. If we want
to handle errors directly, we must use io.open, from the complete model.

As .write is similar to .read, we will look at it first.The io.write function simply
gets an arbitrary number of string arguments and writes them to the current output
file. Numbers are converted to strings following the usual conversion rules; for
full control over this conversion, we  need to use the string.format function:
]]
io.write('sin (3) = ',math.sin(3),'\n');print()
io.write(string.format('sin (3) = %.4f\n',math.sin(3)));print()

--[[
Avoid code like io.write(a..b..c); the call io.write(a,b,c) accomplishes the same
effect with fewer resources, as it avoids the concatentation.

As a rule, we should use print for quick-and-dirty programs, or for debugging, and
.write when we need full control over our output:
]]
print('hello','Lua');print('Hi');print()

io.write('hello','Lua');io.write('Hi','\n');print()

--[[
Unlike print, .write adds no extra characters to the output, such as tabs or
newlines. Moreover, .write uses the current output file, whereas print ALWAYS
uses the standard output. Finally, print automatically applies tostring to its 
args, so it can also show tables, functions and nil

The io.read function reads strings from the current input file. Its arguments control
what is read:

  • '*all' - reads the whole file
  • '*line' - reads the next line
  • '*number' - reads a number
  • num - reads a string with up to num characters

So io.read('*all') will read the whole current input file, starting at its current
position. If we are at the end of the file, or if the file is empty, the call returns
an empty string.

Since Lua handles long strings efficiently, a simple technique for writing filters
in lua is to read the whole file into a string, do the processing to the string
(typically with gsub), and then write the string to the output:

  t = io.read('*all')     -- read a whole file
  t = t:gsub(...)         -- do the job we need ...
  io.write(t)             -- write to the output file

As an example, the following code is a complete program to code a file's content
using the MIME quoted-printable encoding. In this encoding, non-ascii characters
are coded as =xx, where xx is the numeric code of the character in hex. To keep 
the consistency of the encoding, the '=' char must be encoded as well

(note I'm putting all the code in comments since I don't have a file to work with
and don't want to spend too much time on those details)

  t = io.read('*all')
  t = t:gsub('([\128-\255=])',function(c)
    return string.format('=%02x',string.byte(c))
  end)
  io.write(t)

The pattern used in the gsub captures all characters wit codes from 128 to 255,
plus the equal sign.

the call to io.read('*line') returns the next line from teh current input file,
without the newline character. When we reach the end of file, the call returns
nil (as there is no next line to return). This pattern is the default for 'read'.
Usually, the author uses this pattern only when the algorithm naturally handles
the file line by line; otherwise, he favors reading the whole file at once, with
*all, or in blocks, as we'll see in a bit. 

As a simple example of the use of this pattern, the following program copies its
current input to the current output, number each line:
]]

--[[
for count=1,math.huge do
  local line = io.read() -- remember this is actually io.read('*line')
  if line == nil then break end
  io.write(string.format('%6d  ',count),line,'\n')
end
--]]

--[[
The call to io.read('*number') reads a number from the current input file. This is
the only case where read returns a number, instead of a string. When a program 
needs to read many numbers from a file, the abscence of the intermediate strings
improves performance. The *number option skips any spaces before the number and
accepts number formats like -3, +5.2, 1000, and -3.4e-23. If it can't find a 
number at the current file position (because of bad format or  eof), it returns
nil.

We can call read with multiple options as well; for each argument, the function
will rturn the respective result. Suppose we have a file with 3 numbers per line,
and we want to print the max value of each line. We can read all of the number
with a single call to read:
]]

--[[
while true do
  local n1,n2,n3 = io.read('*number','*number','*number')
  if not n1 then break end
  print(math.max(n1,n2,n3))
end
--]]

--[[
But we should also consider the alternative of reading the whole file with option
'*all' and the using gmatch to break it up.
]]

--[[
local pat = '(%S+)%s+(%S+)%s+(%S+)%s+'
for ni,n2,n3 in string.gmatch(io.read('*all'),pat) do
  print(math.max(tonumber(n1),tonumber(n2),tonumber(n3)))
end
--]]

--[[
Besides the basic read patterns, we can call read with a number n as an arg:
in this case, 'read' tries to read n characters from the input file. If it 
can't read any character (eof), 'read' returns nil; otherwise, it returns a
string with at most n characters. As an example of this read pattern, the
following code  is an efficient way (in lua) to copy a file stdin to stdout:
]]

--[[
while true do
  local block = io.read(2^13)      -- buffer size is 8k
  if not block then break end
  io.write(block)
end
--]]

--[[
As a special case, io.read(0) works as a test for the end of a file. it returns an
empty string if there is m ore to be read or nil otherwise.
]]




