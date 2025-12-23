--[[
8.2 - C CODE

Unlike code written in Lua, C code needs to be linked with an application before
use. In most popular systems, the easiest way to do this link is with a dynamic
linking facility, is not part of the ansi c specification; that is, there is no
portable way to implement it.

Normally, lua does not include any facility that can't be implemented in ansi c.
However, dynamic linking is different. We can view it as a mother of all facilities:
once we have it, we can dynamically load any other facility that is not in lua. 
Therefore, in this particular case, lua breaks its portabiltiy rules and implements
a dynamic linking facility for several platforms. The standard implementation offers
this support for Windows, Mac OS X, linux, FreeBSD, Solaris, and some other Unix
implementations. It should not be difficult to extend thsi facility to other 
platforms; check your distribution. (To check it, run print (package.loadlib('a','b'))
from the lua prompt and see the result. If it complains about a non-existent file, then
you have a dynamic linking facility. Otherwise, the error message indicates that this 
facility is not supported or not installed.)

Lua provides all the functionality of dynamic linking in a single function, called
package.loadlib. It has two string arguments:

  - the complete path of the library
  - the name of a function
  
So a typical call to it looks like the next fragment:

  local path = '/usr/local/lib/lua/5.1/socket.so'
  local f = package.loadlib(path, 'luaopen_socket')

The loadlib function loads the given library and link lua to it. However, it doesn't
call the function. Instead, ti returns the C function as a lua function. If there
is any error loading the library or finding the initialization function, loadlib
returns nil plus an error message. 

The loadlib function is a very low level function. We must provide the full path of
the library and the correct name for the function (including occasional leading 
underscore included by the compiler). Usually, we load C libraries using 'require'. 
This function searches for the library and uses loadlib to load an initialization
function for the library. Once called, this initialization function registers in
lua the functions from that library, much as a typical lua chunk defines other
functions. We will discuss 'require' in section 15.1 and more details about C
libraries in section 26.2.

--]]

