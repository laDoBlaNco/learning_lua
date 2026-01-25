---@diagnostic disable: param-type-mismatch
require('myenv')
--[[
Chapter 22 - THE OPERATING SYSTEM LIBRARY

The OS library includes functions for file manipulation, for getting the current 
date and time, and other facilities related to the OS. It is defined in table os.
This library pays a price for Lua portability: 

  Because Lua is written in ansi c, it uses only the functions that the ansi
  standard defines. Many OS facilities, such as directory manipulation and
  sockets, are not part of this standard 🤔🤔; therefore, the system library
  doesn't provide them. Which is why there are other lua libraries, not included
  in the main distribution, that provide extended OS access. Examples are the
  'posix' library, which offers all functionality of the POSIX.1 standard to lua;
  and luasocket, for network support.

  For file manipulation, all that this library provides is an os.rename function,
  that changes the name of a file; and os.remove, that removes (deletes) a file.

22.1 - DATE AND TIME

Two functions, 'time' and 'date', provide all date and time functionality in Lua.

The 'time' function, when call without arguments, just returns the current date and
time, coded as a number. (In most systems, this number is the number of seconds since
some epoch.) When called with a table, it returns the number representing the date
and time described by the table. Such date tables should have the following
significant fields:

  • year - a full year
  • month - 01-12
  • day - 01-31
  • hour - 00-23
  • min - 00-59
  • sec - 00-59
  • isdst - a boolean, true if daylight saving is on

The first 3 fields are mandatory; the others default to noon (12:00:00) when not
provided. In Unix systems (where the epoch is 00:00:00 UTC, January 1, 1970) we have
the following examples:
]]
print(os.time{year=1970,month=1,day=1,hour=0})
print(os.time{year=1970,month=1,day=1,hour=0,sec=1})
print(os.time{year=1970,month=1,day=1});print()

--[[
Note that the result is 16200 is 4.5 hours in seconds (DR time), then 16201 is 4.5 + 1 
second, and 59400 is 4.5 hours + 12 hours (noon) or 16.5 hours in seconds

The 'date' function, despite its name, is a kind of reverse of the 'time' function:
it converts a number representing the date and time back to some higher-level 
representation. Its first param is a 'format string', describing the representation
we want. The second is the numeric date-time; it defaults  to the current date
and time.

To produce a date table, we can use the format string '*t' (for table). 
So for example the call:

  os.date('*t',906000490) 

returns a date table. While, os.date() returns a string
]]
for k,v in pairs(os.date('*t',906000490)) do
  print(k,'=',v)
end
print()
for k,v in pairs(os.date('*t')) do -- with no time given, defaults to now
  print(k,'=',v)
end

--[[
Notice that, besides the fields used by os.time, the table created by os.date also
gives the week day (wday, 1 is Sunday) and the year day (yday 1 is Jan 1st).]]
print(os.date('*t'));print()
ptbl(os.date('*t'))
ptbl{1,2,3,4,5}

--[[
for other format strings, os.date formats the date as a string that is a copy of
the format string where specific tags are replaced by information about time and
date. All tags are represented by a '%' followed by a letter, as seen below.
]]
print(os.date('today is %A, in %B'))
print(os.date('%x',906000490));print()
-- interestingly capital letters vs lowercase changes the result. for example, 
-- %A gives format day name and %a gives the abbreviation. Same for %B. %X gives a
-- military time (assuming for that specific day) and %x gives the date

--[[
All representations follow the current locale. The following table shows each tag.
For numeric values, the table shows also their range of possible values:

  • %a - abbreviated weekday (e.g., Wed)
  • %A - full weekday name (e.g., Wednesday)
  • %b - abbreviated month name (e.g., Sep)
  • %B - full month name (e.g., September)
  • %c - date and time (e.g., 09/16/98 23:48:10)
  • %H - hour, using a 24-hour clock (e.g., 23) [00-23]
  • %I - hour, using a 12-hour clock (e.g., 11) [01-12]
  • %M - minute (e.g., 48) [00-59]
  • %m - month (e.g., 09) [01-12]
  • %p - either 'am' or 'pm' 
  • %S - second (e.g., 10) [00-61]
  • %w - weekday (e.g., 3) [0-6=Sunday-Saturday]
  • %x - date (e.g., 09/16/98)
  • %X - time (e.g., 23:48:10)
  • %Y - full year (e.g., 1998)
  • %y - two-digit year (e.g., 98) [00-99]
  • %% - the character '%' 🤔🤔🤔

If you call 'date' without any args, it uses the %c format as default, that is,
complete date and time information in a reasonable format. Note that the 
representations for %x, %X, and %c change according to the locale and the system.
If we want a fixed representation, such as mm/dd/yyyy, we can use an explicit 
format string such as 'mm/dd/yyyy'

The os.clock function returns the number of seconds of the CPU time for the program.
Its typical use is to benchmark a piece of code:
]]
local x = os.clock()
local s = 0
for i=1,10000000 do s=s+i end
print(('elapsed time: %.2f\n'):format(os.clock()-x))

