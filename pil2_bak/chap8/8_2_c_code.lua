--[[
8.2 C Code

So C code needs to be linked with an application before use. This is done with some sort of dynamic
link facility which ansi C doesn't have naturally. Normally lua doesn't have anything that ansi
C doesn't have, but in the case of the dynamic linking its different. Here lua breaks its 
portability rules and implements a dynamic linking facility for several platforms. The standard
implementation offers support for:
  ▪ windows
  ▪ mac os x
  ▪ linux
  ▪ freebsd
  ▪ solaris
  ▪ and some other unix platforms




]]
print(package.loadlib('a','b'))  -- if the result of this is a complaint about a file not existing
-- then I have linking facility, otherwise an error message will say that the facility is not 
-- supported or not installed. 

--[[
As seen above the functionality of dynamic linking is in a single function call 'package.loadlib'. It
has two string args: 
  ▪ the complete path of the library
  ▪ the name of the function
  
So as an example I would have something like:
    local path = '/usr/local/lib/lua/5.1/socket.so' 
    local f = package:loadlib(path,'luaopen_socket') 

This loads the given library and links lua to it. it doesn't though call the function. Instead
it returns a C function as a lua function. If there is any error loading the library or 
finding the intialization function, loadlib returns nil plus an error message. 

The loadlib function is very very low level. So I need to provide the full path of the library
and the correct name for the function (including occasional leading underscores included by the
compiler) Usually C libraries are loaded using 'require'.

This function searches for the library and uses loadlib to load an initialization function for 
the library. Once called, this initialization function registers in lua the functions from that 
library, much as a typical lua chunk defines other functions. 

I'll see more about that later. 
]]