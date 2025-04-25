--[[
2.4 - STATEMENTS

Lua supports an almost conventional set of statements, similar to those in pascal or C, 
similar to those in Pascal or C. This set includes assignments, control structures, 
function calls and variable declarations.

2.4.1 - Chunks

The unit of execution of lua is call a chunk. A chunk is simply a sequence of statements,
which are executed sequentially. Each statement can be optionally followed by a semicolon:
  chunk ::= {stat [';']} 

There are no empty statements and thus ;; is not legal

lua handles a chunk as the body of an anony function with a variable number of arguments. As
such, chunks can define local variables, receive arguments, and return values.

A chunk can be stored in a file or in a string inside the host program. To execute a chunk
lua first pre-compiles the chunk into instructions for a virtual machine, and then it
executes the compiled code with an interpreter for the virtual machine. 

Chunks can also be pre-compiled into binary form; see program luac for details. Programs in
source and compiled forms are interchangeable; lua automatically detects the file type and
acts accordingly. 

2.4.2 - Blocks
A block is a list of statements; syntactically, a block is the same as a chunk:

  block ::= chunk

A block can be explicitly delimited to produce single statement:

  stat ::= do block end

Explicit blocks are useful to control the scope of variable declarations. Explicit blocks
are also sometimes used to add a return or break statement in the middle of another block.

2.4.3 = Assignment
Lua allows multiple assignments. Therefore, the syntax for assignment defines a list of 
variables on the left side and a list of expressions on the right side. The elements in both
lists are separated by commas:
  stat ::= varlist '=' explist
  varlist ::= var {',' var}
  explist ::= exp {',' exp}

]]