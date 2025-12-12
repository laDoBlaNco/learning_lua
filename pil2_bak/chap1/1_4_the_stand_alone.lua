--[[
So the stand alone interpreter (also called lua.c due to its source file, or simply
lua due to its executable) is a small program that allows the direct use of lua. This 
section presents it with its main options

When the interpreter loads a file, it ignores its first line if this line starts with a 
number sign '#'. This is a feature that allows theuse of lua as a script interpreter in
unix systems. So I can do shebang scripts

#!/usr/local/bin/lua   etc.

Using lua on the command line is 'lua [options] [script] [args]
Everything being optional. As I've seen already, when I call lua without any args the interpreter
enters in interactive mode. 

The -e options allows me to enter code directly into the command-line

% lua -e 'print(math.sin(12))' 

The  -l option loads a library
The -i option enters interactive mode after running the other args. so together for example:

$ lua -i -l lib -e 'x = 10' 

will load the 'lib', then execute the assignment x=10, and finally present me with the loa
prompt to continue hacking,

whenever the global var _PROMPT is defined, lua uses its value as the prompt when interacting
So I can change the prompt with a call like:
lua -i -e '_PROMPT=" my_lua>> "''

In interactive mode I can print the alue of any expression by writing a lien that starts
with an equal sign followed by the expression (this was changed in later versions)

This was considered a feature in this version to help use lua as a calculator. Before running
its arguments, lua looks for an environment variable named LUA_INIT. If there is such a var
and its content is @filename, then lua runs the given file. if LUA_INIT is defined bud doesn't
start with '@', then lua assmes that it contains lua code and runs it. LUA_INIT gives me the
great power when configuring the stand-alone interpreter, uz I have full power of lua in the
actual configuration as well. I can pre-load packages, change the prompt and the path, define
my own functions, rename or delete functions, and so on.

A script can retieve its ars from the global variable 'arg'. Lua creates a table 'arg' with
all the command-line args, before running the script. The script name goes into index 0;
the first argument woul go into index 1 and so on. preceding options  go to negative
indices, as they appear befor the script. So here:

% lua -e 'sin=math.sin' script a b

is:
arg[-3] = 'lua'
arg[-2] = '-e'
arg[-1] = 'sin=math.sin'
arg[0] = 'script'
arg[1] = 'a'
arg[2] = 'b'

More  often then not the script will only use the positive indices. 

In lua 5.1, a script can also retieve its arguments through the vararg syntax. In the 
main body of the script, the expression ... (three dots) results in the arguments to
the script (much like the spread operator in other langs) 
]]