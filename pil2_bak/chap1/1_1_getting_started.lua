-- to keep with the tradition, our first program in lua just  prints 'hello world'
print('Hello World')

-- the next program is a bit more complex and defines a function to compute the factorial
-- of a given number, then asks the user for a number and prints its factorial

-- defining a factorial function
function fact(n)
  if n == 0 then
    return 1
  else
    return n * fact(n - 1)
  end
end

-- print('Enter a number: ')
-- a = io.read('*number') -- read a number
-- print(fact(a))

-- 1.1 Chunks
-- each piece of code taht lua executes, such as a file or a single line in interactive mode
-- is called a chunk. A chunk is simply a sequence of commands (or statements)
-- lua needs no separator between consecutive statements, but you can use a semicolon if
-- you wish. A person convention is to sue semicolons only to separate two or more statements
-- written on the same line. Line breaks play no role in lua syntax; for instance, the following
-- 4 chunks are all valid and the same:
a = 1
b = a * 2
a = 1;
b = a * 2;
a = 1; b = a * 2
a = 1
b = a * 2 -- ugly but still valid
print(a,b) print()


--[[
A chunk may e as simple as a single statement, such as in the hello world example, or it may be
composed of a mix of statetment and function definititions (which are actually assignments, as 
we'll see later), such as the factorial example. A chunk may be as large as you wish. Because lua
is used also as a data-description language, chunks with several megabytes are not uncommon. The 
lua interpreter has no problems at all with large chunks.

Instead of writing my program to a file, I may run t he stand-alone interpreter in interactive
mode as well. 

using lua -i pror I can tell the interpreter to run the chunk first and then leave me in the
interpreter. 
Another common way to do this is to enter the interpreter and use dofile(''). For example with 
the definition below:
]]
function norm(x,y)
  return (x^2+y^2)^0.5
end

function twice(x)
  return 2*x
end

-- I can then dofile('thisfile') and it'll run and use my defs in the interpreter. This dofile
-- function is usefule also when I'm testing a piece of code. I can work with two windows:
-- one as a text editor with the program file (in a file prog.lua for example) and the other
-- as a console running lua. After saving a modification I can execute dofile('prog.lua') in
-- the console to load the code; then start to test it.
