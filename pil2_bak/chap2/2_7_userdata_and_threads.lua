--[[
2.7 USERDATA AND THREADS

The userdata type allows arbitrary C data to be stored in lua variables. It has no
predefined operations in lua, except assignment and equality testing. Userdata are
used to represent new types created by an application program or a library writen
in C; for instance, the standard i/o library uses them to represent files. I'll see
more about userdata later, when i get to the C API. I'll also see the thread type
when I get to Chapter 9 when I learn about coroutines.
]]