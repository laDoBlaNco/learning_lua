--[[
Chapter 23 - THE DEBUG LIBRARY

The debug library doesn't give us a debugger for lua, but it offers all the
primitives that we need for writing our own. For performance reasons, the official
interface to these primitives is through the C API. The debug library in Lua is
a way to access them directly within Lua code.

Unlike the other libraries, we should use the debug library with parsimony (
sparingly or be cheap about it). First, some of its functionality is not exactly
famous for performance. Second, it breaks some sacred truths of the language, such
as that we can't access a local variable from outside the function that created it.
Frequently, we may not want to open this library in our final version of a product,
or else we may want to erase it, running debug=nil.

The debug library comprises of two kinds of functions:
  • introspective functions - which allow us to inspect several aspects of the 
    running program, such as its stack of active functions, current line of execution,
    and values and names of local variables.
  • hooks - allow us to trace the execution of the program

An important concept in the debug library is the 'stack level'. A stack level is a
number that refers to a particular function that is active at that moment, that is,
it has been called and has not returned yet. The function calling the debug library
is level 1, the function that called it is level 2, and so on. (This goes right along
with what we've learned about the error function and using levels to tell lua who to
'blame' for the error).

23.1 - INTROSPECTIVE FACILITIES

The main introspective function in the debug library is the 'debug.getinfo' function.
It's first parameter may be a function or a stack level. When we call debug.getinfo(foo)
for some function 'foo', we get a table with some data about this function. The table
may have the following fields:

  • source: where the function was defined. If the function was defined in a string
    (through 'loadstring'), 'source' is thsi string. If the function was defined in
    a file, 'source' is the file name prefixed with a '@'

  • short_src: a short version of 'source' (up to 60 characters), useful for error
    messages

  • linedefined: the first line of the source where the function was defined

  • lastlinedefined: the last line of the source where the function was defined

  • what: what this function in. Options are 'lua' if foo is a regular lua function,
    'C' if it is a C function, or 'main' if it is the main part of a lua chunk.

  • name: a reasonable name for the function (assuming 'reasonable' because it could be 
    anony and not technically have a name)

  • namewhat: what the previous field means. The field may be 'global', 'local','method',
    'field', or '' (empty string). The empty string means that lua didn't find a name
    for the function.

  • nups: number of upvalues of that function (remembering that an upvalue a variable or
    value that comes from the calling function or closure environment)
    
  • activelines: a table representing the set of active lines of the function. An 
    active line is a line with some code, as opposed to empty lines or lines containing
    only comments. (A typical use of this information is for setting breakpoints. Most
    debuggers don't allow us to set a breakpoint outside an active line, as it would
    be unreachable)

  • func: the function itself (we'll see this later)
  
When 'foo' is a C function, loa doesn't have much data about it. For such functions, 
only the fields 'what','name', and 'namewhat' are relevant.

When we call debug.getinfo(n) for some number n, we get data about the function active
at that stack level. For example, if n is 1, we get data about the function doing the 
call. (When n is 0, we get data about getinfo itself, a C function). If n is larger
than the number of active functions in the stack, debug.getinfo returns nil. When we
query an active function, calling debug.getinfo with a number, the result table has an
extra field, 'currentline', with teh line whree the function is at that very moment.
Moreover, 'func' has the function that is active at that level.

The field name is tricky. Remember that, since functions are first class values 
in lua, a function may not have a name, or may have several names 🤔. Lua tries
to find a 'reasonable' name for a function by looking into the code that called
the function, to see what it was called there. This method works only when we call
getinfo with a number, that is, we get information about a particular invocation.

The getinfo function is NOT efficient. Lua keeps debug information in a form that
doesn't impair program execution; efficient retrieval is a secondary goal here.
The acheive better performance, getinfo has an optional second parameter that
selects what information to get. With this parameter, the function doesn't waste
time collecting data that the user doesn't need. The format of this parameter
is a string, where each letter selects a group of fields, according to the 
following:

  • 'n' selects name and namewhat
  • 'f' selects func
  • 'S' selects source, short_src, what, linedefined, and lastlinedefined
  • 'l' selects currentline
  • 'L' selects activelines
  • 'u' selects nup

The following function illustrates the use of debug.getinfo. It prints a 
primitive traceback of the active stack:
]]
function traceback()
  for level=1,math.huge do
    local info = debug.getinfo(level,'Sl')
    if not info then break end
    if info.what == 'C' then  -- is a C function?
      print(level,'C function')
    else  -- a lua function
      print(('[%s]:%d'):format(info.short_src,info.currentline))
    end
  end
end

traceback();print()

--[[
It's not difficult to improve this function, by including more data from getinfo.
Actually, the debug library offers a much improved version of our traceback
function. Unlike our version, debug.traceback doesn't print its results; instead,
it returns a (usually long) string with the traceback.
]]
print(debug.traceback(1))

