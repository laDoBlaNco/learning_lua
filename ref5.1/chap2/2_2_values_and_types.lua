--[[
2.2 Values and Types

Lua is a dynamically type language. this means that variables do not have types; only 
values do. There are no type definitions in the language, like in C. All values carry their
own type. 

All values in lua re first-class values. This means that all values can be stored in varaibles
passed as arguments to other functions, and returned as results. 

There are 8 basic types in lua:
▫️ nil - is the type of the value nil, whose main property is to be different from any other
   value; it usually represents the absence of a useful value.
▫️ boolean - is the type  of the values 'false' and 'true'. Both nil and false make a condition
   false; any other value makes it true (including '', 0, etc.)
▫️ number - represents real (double-precision floating-point) numbers (it is easy to build lua
   interpreters that use other internal  representations for numbers, such as single-precision
   float or long integers; see file luaconf.h)
▫️ string - represents arrays of characters. lua is 8-bit clean: strings can contain any 8-bit
   character, including embedded zeros '\0'
▫️ function - lua can call (and manipulate) functions written in lua and functions written
   in C
▫️ userdata - the type userdata is provided to allow arbitrary C data to be stored in lua
   variables. This type corresponds to a bock of raw memory and has no pre-defined operations 
   in lua, except assignment and identity test. However, by using metatables, the programmer
   can define operations for userdata values. uwerdata values cannot be created or modified in
   lua, only through the C API. This guarantees the integrity of data owned by the host program. 
▫️ thread - the type thread represents independent threads of execution and it is used to 
   implement coroutines. Do not confuse lua threads with operating-system threads. Lua supports
   coroutines on all systems, even those that do not support threads.
▫️ table - The type table implements associative arrays, much like php, that is, arrays that
   can be indexed not only with nubmers, but with any value (except nil). Tables are heterogeneous
   that is, they can contain values of all types (except nil). Tables are the sole data structuring
   mechanism in lua; they can be used to represent ordinary arrays, symbol tables, sets, records,
   graphs, trees, etc. To represnt recrods, lua uses the field name as an index. The language
   supports this representation by providing a.name as syntactic sugar for a['name']. There are
   several convenient ways to create tables in lua

   like indices the value of a table field can be of any type (except nil), In particular, 
   because functions are first-class values, table fields can contain functions. Thus labels
   can also carry methods.

   Tables, functions, threads, and (full) userdata values are objects: variables do not actually
   contain these values, only references to them. Assignment, parameter passing, and function
   returns always manipulate references to such values; these operations  do not imply any kind 
   of copy. So like most languages everything else is passed by copy except for these 'objects'
   which are passed by reference

   The library function type returns a string describing the type of given value.

]]

--[[
2.2.1 - Coercion

Lua provides automatic conversion between string and number values at run time. Any arithmetic
operation applied to a string will try to convert the string to a number, following the usual
conversion rules. Conversely, whenever a number is use where a string is expeted, the number is
converted to a string, in a reasonable format. For complete control over how numbers are converted
use the 'format' function from the string library (see string.format)
]]