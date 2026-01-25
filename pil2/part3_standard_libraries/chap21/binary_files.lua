--[[
The simple-model functions io.input and io.output always opan a file in text
mode (the default). In Unix, there is no difference between binary files and
text files. But in some systems, notably Windows, binary files must be opened
with a special flag. To handle such binary files, we must use io.open with the 
letter 'b' in the mode string.

Binary data in lua are hanlded similarly to text. A string in lua may contain
any bytes, and almost all functions in the libraries can handle arbitrary bytes.
We can even do pattern matching over binary data, as long as the pattern does
not contain a zero byte. If we want to match a zero byte in the subject, we 
can use the class %z instead. 

Typically, we read binary data either with the *all pattern, that reads the
whole file, or with the pattern n, that reads n bytes. As a simple example,
the following code converts a text from from DOS to unix (that is, the standard
IO files (stdin-stdout), because these files are open in text mode. Instead, it
assumes that the names of the input fiel and the output file are given as 
args to the program:
]]

--[[
local inp = assert(io.open(arg[1],'rb'))
local out = assert(io.open(arg[2],'wb'))

local data = inp:read('*all')
data = data:gsub('\r\n','\n')
out:write(data)

assert(out:close())
--]]

--[[
Another example is print all strings found in a binary file:
]]
--[[
local f = assert(io.open(arg[1],'rb'))
local data = f:read('*all')
local validChars = '[%w%p%s]'
local pattern = validChars:rep(6)..'+%z'
for w in data:gmatch(pattern) do
  print(w)
end
--]]

--[[
The code above assumes that a string is any zero-terminated sequence of sex or
more valid characters, where a valid character is any character accepted by the
pattern validChars. In our example, this pattern comparises the alphanumeric, the
punctuation, and the space character. We use :rep and .. to create a pattern that 
captures all sequences of six or more validChars. (great example of using lua code
to create a pattern rather than typing it all out by hand). The %z at the end of
the pattern matches the byte zero at the end of a string in C. 

As a lost example, the following program makes a dump of a binary file:
]]
---[[
local f = assert(io.open(arg[1],'rb'))
local block = 16
while true do
  local bytes = f:read(block)
  if not bytes then break end -- I love these short idioms in lua
  for _,b in pairs{bytes:byte(1,-1)} do -- remember that :byte & :char take an optional
  -- 3rd arg which completes a range, o sea, an ending inclusive index of the chars to
  -- convert to bytes, so we are basically saying give me all the bytes from index 1
  -- to -1 (the end)
    io.write(('%02x '):format(b))
  end
  io.write(('   '):rep(block-bytes:len()))
  io.write(' ',bytes:gsub('%c','.'),'\n') -- %c - control characters
end
--]]
--[[
Again, the first code arg is the input file name; the output goes to the
standard output (whatever its set as currently). The code reads the file
in chunks of 16 bytes. For each chunk, it writes the hexadecimal representation of
each byte, and then it writes the chunk as text, changing control characters to dots.
(Note teh use of the idiom {string.byte(bytes,1,-1)} or as I use {bytes:byte(1,-1)} as
I explained above, to create a table with all bytes of the string 'bytes').

We can run this file as lua binary_files.lua binary_files.lua and get a result. 
]]



