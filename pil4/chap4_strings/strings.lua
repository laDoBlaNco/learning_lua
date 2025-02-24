--[[
Strings represent text. A string in lua can contain a single letter or an entire book. programs
that manipulate strings with 100k or 1m characters isn't unusual in lua.

Strings in lua are sequences of bytes. The lua core is agnostic about how these bytes encode
text. Lua is 8 bit clean and its strings can contain bytes with any numeric code, including
embedded zeros.

This means we can store any binary  data into a string. We can also store unicode strings
in any representation, however there are good reason to use utf8 whenever possible.

Strings in lua are immutable values. We can't change a character inside a string, as we
can in C; instead we create a new string with the desired modifications
]]
local a = 'one string'
local b = string.gsub(a, 'one', 'another')
print(a)
print(b)
print()

-- strings are subject to automatic mem management like all other lua objs (tables, functions, etc)
-- This means we don't worry about allocation and deallocation of strings like we do in C
-- we get the length of a string with the '#' length operator
print(#a)
print(#b)
print()
-- # counts the length in bytes which isn't the same as chars as I've seen in other languages
-- lua uses .. for concatentation. Numbers are converted to strings if used with ..
print('Hello ' .. 'World')
print('result is ' .. 3)
print()

-- remember that strings are immutable, which means that '..' returns a new string
print(a)
local c = a..' and another'
print(c)
print(a)
print()

print('Long Strings:')
-- We can delimit literal strings by mathing double brackets as well, as we do with long comments
-- Literals in brackets can run for several lines and don't interpret escape sequences. Moreover it
-- ignores the first character of the string when this character is a newline. 
local page = [[
<html>
<head>
    <title>An HTML Page</title>
</head>
<body>
    <a href="http://www.lua.org">Lua</a>
</body>
</html>
]]
print(page)print()

--[==[
Sometimes we may need to enclose a piece of code containing something like a = b[c[i]], but this will
mess up our strings and or comments. But if we put any number of '=' between the brackets then we
can specify clearly to lua what the starting and ending delimters are, as I've done here. This is 
valid for both comments and literal strings
]==]

print('Coercions:')
--[[
Lua has automatic coercions between numbers and strings at run time. any numeric operation applied
to a string tries to convert the string to a number. Lua applies such coercions not only in 
arithmetic operators, but also in other places that expect a number.

Also if lua finds a number where it expects a string, it'll try to convert the number to a string
]]
print(10 .. 20)

-- many people arge that this is not a good idea in lua's design, but as a rule its better not to count
-- on them. 
print('10'+1)
-- using 'tonumber' for explicit conversions. If it can't convert it'll return 'nil'
print(tonumber('   -3    '))
print(tonumber('   10e4  '))
print(tonumber('10e'))
print(tonumber('0x1.3p-4'))
print()

-- by default tonumber assumes decimal but we can specify any base between 2 and 36
print(tonumber('100101',2))
print(tonumber('fff',16))
print(tostring(10)=='10')
print()

