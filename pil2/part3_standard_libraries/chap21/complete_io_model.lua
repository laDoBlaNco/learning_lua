--[[
21.2 - THE COMPLETE IO MODEL

For more control over IO, we can use the complete model instead of the simple one.
A central concept in this model is the file handle, which is equivalent to streams
(FILE*) in C: it represents an open file with a current position.

To open a file, we use the io.open function, which mimics the fopen function in C.
It takes as args the  name of the file to open plus a mode string. This mode string
may contain an 'r' for reading, a 'w' for writing (which also erases an previous
content of the file), or an 'a' for appending, plus an option 'b' to open 
binary files. The 'open' function returns a new handle for the file. In case
of error, open returns nil, plus an error message and an error number. 
]]
print(io.open('non-existent-file','r'))
print(io.open('/etc/passwd','w'))
print()

-- the interpretation of the error numbers is system dependent. A typical
-- idiom to check for error is: local f = assert(io.open(filename,mode))

--[[
If the open fails, the error message goes as the second argument, which 
then shows the message.

After we open the file, we can read from it or write to it with the methods
read/write. They are similar to the read/write functions, but we call them
as methods on the file handle, using the colon syntax. For instance, to open
a file and read it all, we can use a chunk like this:
]]
--[[
local filename = ''
local f = assert(io.open(filename,'r'))
local t = f:read('*all')
f:close()
--]]

--[[
The IO library offers handles for the three predefined C streams: io.stdin, io.stdout,
and io.stderr. So, we can send a message directly to the error stream with a code 
like this:
]]
--[[
local message = ''
io.stderr:write(message)
--]]

--[[
We can mix it up as well using the complete model and the simple model. We get the
current input file handle by calling io.input(), without arguments. We set this 
handle with the call io.input(hanle). (Similar calls are also valid for io.output).
For example, if we want to change the current input file temporarily, we can write
something like:
]]
--[[
local temp = io.input()
io.input('newinput')
-- do something with the newi input
io.input():close()
io.input(temp)
--]]



