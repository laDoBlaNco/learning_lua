--[[
15.1 - THE REQUIRE FUNCTION

Lua offers a high-level function to load modules, called 'require'. this function
tries to keep to a minimum its assumptions about what a module is. For 'require',
a module us just any chunk of code that defines some values (such as functions or
tables containing functions).

To load a module, we simply call require 'modname'. Typically, this call returns
a table comprising the module functions, and it also defines a global variable
containing this table. However, these actions are done by the module, not by
require, so some modules may choose to return other values or to have different
side effects.

It is a good programming practice always to require the modules we need, even if
we know that they would already be  loaded. We may exclude the standard libraries
from this rule, because they are pre-loaded in lua. Nevertheless, some people
prefer to use an explcit require even for them
]]
local m = require 'io'
m.write('hello world\n');print()

--[[
In the following example we'll see the behavior of 'require'. Its first step is to
check in the table 'package.loaded' whether the module is already loaded or not. If
so, 'require' returns its corresponding value. Therefore, once a module is loaded, 
other  calls to require simply return the same value, without loading the  module
again.

If the module isn't loaded yet, 'require' tries to find a loader for this module.
(This step is illustrated by the abstract function 'findloader' below). Its first
attempt is to query the given library name in table 'package.preload'. If it finds
a function there, it uses this function as the module loader. This 'preload' table
provides a generic method to handle some non-conventional situations (e.g., C libraries
statically linked to lua). Usually, this table doesn't have an entry for the module,
so require will search first for a lua file and then for a C library to load the 
module from.

If 'require' finds a lua file for the given module, ti loads it with loadfile;
otherwise, if it finds a C library, it loads it with loadlib. Remember that both
loadfile and loadlib only load some code, without running it. To run the code,
'require' calls it with a single argument, the module name. If the loader 
returns any value, require returns this value and stores it in a table package.loaded
to return the same value in future calls for this same library. If the loader returns no
value, require returns whatever value is in table package.loaded. As we will see later in
this chapter, a module can put the value to be returned by 'require' directly into
package.loaded.
]]

-- our rendition what 'require' does, in lua speak

function require(name)
  if not package.loaded[name] then  -- module not loaded yet?
    local loader = findloader(name)
    if loader == nil then
      error('unable to load module ' .. name)
    end
    package.loaded[name] = true   -- mark module as loaded
    local res = loader(name)      -- initialize module
    if res ~= nil then
      package.loaded[name] = res
    end
  end
  return package.loaded[name]
end

function findloader(name) end -- just a dummy function to flesh out the example

--[[
An important detail about that previous code is that, before calling the loader,
'require' marks t he module as already loaded, assigning 'true' to the respective
field in package.loaded. Therefore, if the module requires another module and 
that in turn recursively requires the original module, this last call to 'require'
returns immediately, avoiding an infinite loop 🤯🤯🤯

To force require into loading the same library twice, we simply erase the 
library entry from package.loaded. For instance after a successful

  require 'foo'
  package.loaded['foo'] -- will not be nil. 
  
The following code will load the library again

  package.loaded['foo'] = nil
  require 'foo'

When searching for a file, require uses a path that is a little different from 
typical paths as well. The path used by most programs is a list of directories
wherein to search for a given file. However, ansi C (the abstract platform where
lua runs) doesn't ahve the concept of directories. Therefore, the path used by
'require' is a list of PATTERNS, each of them specifying an alternative way to 
transform a module name (the argument to 'require') into  a file name. More
specifically, each component in the path is a file name containing optional
question marks. For each component, 'require' replaces the module name for 
each '?' and checks whether there is a file with the resulting name; if not,
it g oes to the next component. The components in a path are separated by
semicolons (a character seldom used for file names in most OSs). For example, if
the path is:

  ?;?.lua;c:\windows\?;/usr/local/lua/?/?.lua

then the call require 'sql' will try to open the following files:

  sql
  sql.lua
  c:\window\sql
  /usr/local/lua/sql/sql.lua

WOW 🤯🤯🤯 THAT'S GENIUS

The require function assumes only the semicolon (as the component separator) and
the question mark; everything else, such as directory separators or file extensions,
is defined by the path itself.

The path that require uses to search for lua files is always the current value
of the variable package.path. When loa starts it initializes this variable with
the value of the environment variable LUA_PATH or with a compiled-defined default
path, if tis environment variable isn't defined. When using LUA_PATH, lua substitutes
teh default path for any substring ';;'. For example, if we set LUA_PATH to 
'mydir/?.lua;;', the final path will be the component 'mydir/?.lua' followed
by the default path.

if require can't find a lua file compatible with the module name, it looks for a C
library. For this search it gets the path variable package.cpath (instead of package.path).
This variable gets it initial value from the environment variable LUA_CPATH (instead of
LUA_PATH). A typical value for this variable in unix is:

  ./?.so;/usr/local/lib/lua/5.1/?.so

Note that the file extension is defined by the path. So in unix its .so and in windows
it would more than likely be .dll

Once it finds a C library 'require' loads it with package.loadlib, which we've already
discussed previously. Unlike lua chunks, C libraries do not define one single main
function. Instead the can export several C functions. Well-behaved C libraries should
export one function called 'luaopen_modname', which is the function that 'require'
tries to call for link the library. We'll discuss that when we get to writing C
librariies

Usually we use moduels with their original names, but sometiems we must rename a 
module to avoid name clashes. A typical situation is when we need to load 
different versions of the same module, for instance for testing. For a lua module,
either it does not have its name fixed internally (as we'll see later) or we can
easily edit it to change its name. But we can't edit a binary module to correct
the name of its luaopen_* function. To allow for such renamings, 'require' uses
a small trick: if the module name contains a hyphen, 'require' strips from the 
name its prefix up to the hyphen when creating the luaopen_* function name. For
instance, if a module is named a-b, require expects its open functiont o be named
luaopen_b, instead of luaopen_a-b (which would not be a valid C name anyway).
So if we need to sue two modules named mod, we can rename one of them to v1-mod 
(or -mod, or anything like that). When we call m1 = require 'v1-mod', require will
find both the renamed file v1-mod and, inside this file, the function with the 
original name luaopen_mod.

]]

