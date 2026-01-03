--[[
15.5 - SUBMODULES AND PACKAGES

Lua allows module names to be hierarchical, using a dot to separate name
levels. For example, a module named mod.sub is a submodule of mod. Accordingly,
we may assumet hat module mod.sub will define all its values inside a table
mod.sub, that is, inside a table stored with key 'sub' in table 'mod'. A package
is a complete tree of modules; it is the unit of distribution in lua.

When we 'require' a module called mod.sub, 'require' queries first the table
package.loaded and then the table package.preload using the original module
name 'mod.sub' as the key; the dot has no significance whatsoever int his 
search.

However, when searching for a file that defines that submodule, 'require' translates
the dot into anothr character, usually the system's directory separator (e.g., '/'
for unix and '\' for Windows). After the translation, 'require' searches for the 
resulting name like any other name, for instance, assuming the path is 

  ./?.lua;/usr/local/lua/?.lua;/usr/local/lua/?/init.lua

and '/' as the directory separator, the call require'a.b' will try to open the

  ./a/b.lua
  /usr/local/lua/a/b.lua
  /usr/local/lua/a/b/init.lua

This behavior allows all modules of a package to live in a single directory. For
instance, if a package has modules p, p.a and p.b, their respective files can be
named p/init.lua, p/a.lua, and p/b.lua, with the directory p within some appropriate
directory.

The directory separator used by lua is configured at compile time and can be any
string (remembering, lua knows nothing about directories). For example, systems
without hierarchichal directories can use a '_' as the 'directory' separator,
so that 'require"a.b"' will search for the file a_b.lua

As we saw before C-function names can't contain dots, so a C library for submodule
a.b can't export a function luaopen_a_b. We can use the hyphen trick here too, 
with some subtle results. For exaample if we have a C library 'a' and we want to
make it a submodule of 'mod', we can rename the file to mod/-a. When we write 
require'mod.-a', 'require' correctly finds the new file mod/-a as well as the 
function luaopen_a inside it.

As an extra facility, 'rquire' has one more option for loading C submodules. When
it can't find either a lua file or a C file for a submodule, ti again searches
the C path, but this time looking for the package name. For example, if the program
requires a submodule a.b.c and 'rquire' can't find a file when looking for a/b/c, 
this last search will look for a. If it finds a C library with this name, then
'require' looks into this library for an appropriate open function, luaopen_a_b_c
(in this example). This facility allows for distribution to put several submodules
together inta a single C library, each with its own open function. 

The module function also offers explicit support for submodules. When we create
a submodule, wiht a call like module('a.b.c'), module puts the environment table
into variable a.b.c. that is, into a field c of a table in field b of a table a. If
any of thes intermediate tables don't exist, 'module' creates them. Otherwise
it reuses them.

From the lua point of view, submodules in the same packages have no explicit 
relationshiop other than that their environment tables may be nested. Requiring
a module does not automatically load any of its submodules; similarly,
requiring a.b does not automatically load a. Of course, the package implementer is
free to create these links if we waant them. For example, a particular module
'a' may start by explicitly requiring oneor all of its submodules.
]]
