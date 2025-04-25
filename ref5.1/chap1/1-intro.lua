--[[
Lua is an extension programming language designed to support general procedural programming
with data description facilities. it also offers good support for object-oriented programming
functional programming, and data-driven programming. Lua is intended to be used as a powerful
light-weight scripting language for any program that needs one. Lua is implemented as a library
writing in clean C (that is a common subset of ansi C and C++)

Being an extension language, lua has no notion of a main program: it only works embedded in
a host client, called the embedding program or simply the host. This host program can invoke
functions to execute a piece of lua code, can write and read lua variables, and can register
C functions to be called by lua code. Through the use of C functions, lua can be augmented
to cope with a wide range of different domains, thus creating customized programming languages
sharing aa syntactical framework. The lua distribution includes a sample host program called
lua, which uses the lua library to offer a complete, stand-alone lua interpreter. 

lua is free softward, and is provided as usual with no guarantees, as stated in its license.
The implementation described in this manual is avaialble at luas' official web site www.lua.org

Like any other reference manual this document is dry in places. For a discussion of the decisions
behind the design of lua, see the technical papers availae lua's website. For a detailed 
introduction to programming in lua, see programming in lua (second edition)

]]