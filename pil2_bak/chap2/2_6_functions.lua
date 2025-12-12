--[[
2.5 FUNCTIONS

Functions are first-class values in lua. This means that functions can be stored in variables
passed as args to other functions, and returned as results. Such facilities give great 
flexibility to the language: a program may redefine a fucntion to add functionality, or 
simply erase a function to create a secure enironment when running a piece of untrusted code 
(such as code received through a network). Moreover, lua offers good support for funtional
programming, including nested functions with proper lexical scoping; I'll get into that in
chapter 6. Finally, first-class functions play a key role in lua's OOP facilities which I'll
see in Chapter 16.

Lua can call functions written in c. All teh standard libraries in lua are written in C. They
comprise functions for string manipulation, table manipulation, i/o, access to basic operating
system facilities, mathematical funtions, and debugging. Application programs may define other
functions in C.

I'll see lua functions in Chapter 5 and C functions in Chapter 26
]]