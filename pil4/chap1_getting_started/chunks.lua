--[[
        Chunks
Each piece of code that lua executes is called a chunk. A chunk is simply
a sequence of commands (or statements)

A chunk can be as simple as a single statement or composed of a mix of of 
statements and function defs, which are just other assignments. A chunk can be
as large as I wish. Lua is used also as a data description language, chunks with
several megabytes are not uncommon. 

Another way to run chunks is with the function dofile, which immediately executes
a file. 
]]

print 'hello world' -- so you don't actually need ()s 🤯🤯

function norm(x,y)
    return math.sqrt(x^2 + y^2)
end

function twice(x)
    return 2.0 * x
end


