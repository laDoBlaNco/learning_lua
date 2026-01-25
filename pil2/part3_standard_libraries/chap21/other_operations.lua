--[[
21.3 - OTHER OPERATIONS ON FILES

The 'tmpfile' function returns a handle for a temporary file, open in read/write
mode. This file is automatically removed (deleted) when the program ends. 🤓🤯
(We could do some interesting stuff with that.)

The 'flush' function executes all pending writes to a file. like the 'write'
function, we can call it as a function, io.flush(), to flush out the current
output file; or as a method f:flush(), to flush a particular file f.

The 'seek' function can both .get and .set the current position of a file. Its
general form is f:seek(whence,offset). The 'whence' param is a string that 
specifies how to interpret the offset. its valid values are 'set', when offsets
are interpreted from the beginning of the file; 'cur' when offsets are interpreted
from the current position of the file, and 'end' when offsets are interpreted
from the end of the file. Independently of the value of 'whence', the call returns
the final current position of the file, measured in bytes from the beginning of the
file.

The default value for 'whence' is 'cur' and for 'offset' is zero. Therefore, 
  • the call file:seek() returns the current file position only, without changing it;
  • the call file:seek('set') resets the position to the beginning (0) of the file
    (and returns zero, as the current position of the file);
  • the call file:seek('end') sets the position to the end of the file and returns
    its size (or the current position of the file)

The following function gets the file size without changing its current position:
]]
function fSize(file)
  local current = file:seek() -- get the current position
  local size = file:seek('end') -- get file size
  file:seek('set',current) -- restore position
  return size
end
print(fSize(io.input(arg[1])))

-- all these functions return nil plus an error messagre in case of error

