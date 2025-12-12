--[[
8 - COMPILATION, EXECUTION, AND ERRORS

Although we refer to lua as an interpret language, it always precompiles source code to an
intermediate form before running it. (many interpreted languages do the same) The presence
of a compilation phase may sound out of place in an interpreted language like lua, but the 
distinguishing feature of interpreted langs isn't that they aren't compiled, but rather that
the compiler is part of the language runtime and that, therefore, ti is possible (and easy)
to execute code generated on the fly. I can say that the presense of a function 'dofile' is
what allows lua to be called an interpreted language. 

]]