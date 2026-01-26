--[[

I/O Library (these are the princple tools I'll use)
▫️ io.input(filename)
▫️ io.output(filename)
▫️ io.open(filename,mode) - has 4 modes available to us
    ▫️ r - read - create text files
    ▫️ w - write - create text files
    ▫️ rb - read binary - working with any file that has binary on it, we need to use 'b' 
    ▫️ wb - write binary
▫️ io.close(filename)

▫️ io.read(arguments)
    ▫️ read has several parameters (arguments)
    ▫️ '*all' - reads the whole file
    ▫️ '*line' - reads the next line
    ▫️ '*number' - reads a number
    ▫️ n - reads a string with up to n characters
▫️ io.write(arguments)
    ▫️ this will automatically look for the last filename set in io.output, so in the example below 
      we io.output(filename) and then io.write automatically looks for that filename to write to

]]

-- NOTE I'm not importing anything to use this library
io.write('How are you are? ') -- most times I won't use io.write but just 'print'. io.write and io.read are more for files 
local answer = io.read()

if tonumber(answer) > 48 then
    io.write("You're  old!")
elseif tonumber(answer) < 48 then
    io.write("You're young!")
else
    io.write("You're not old, you are only 48!")
end
print() print()
-- here's an example using files
io.output('tempfile')
io.write('42')
io.close()
io.input('tempfile')
local info = io.read("*all")
print(info)

print() print()

local file = io.open('tempfile','w')
if file ~= nil then
    file:write('Hello world!') -- my first time using a 'method'
    file:close() -- this also shows that I can have more than 1 file open at a time, so I need to make sure I'm closing
end

file = io.open('tempfile','r')
if file ~= nil then  -- this is kinda Go like, but simple and quick 
    local temp = file:read('*line')
    file:close()
    print(temp)
end