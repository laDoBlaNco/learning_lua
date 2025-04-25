--[[
2.4 STRINGS

so strings in lua havec the usual meaning I would think of: a sequence of chars. Lua is
eight bit clean and its strings may contain characters with any numeric code, including
embedded zeros. This means that I can store any binary data into a string

Srings in lua are immutable values. I can't change a character inside a string, the way
I can in say C; instead, I will need o create a new string with the desired modifications,
as in the example below:
]]
a = 'one string'
b = string.gsub(a, 'one', 'another') -- change string parts
print(a)                           --> one string
print(b)                           --> another string

--[[
Strings in lua are subject to automatic memory management, like all other lua objects
(tables, functions, etc.) This mean sthat I don't have to worry about allocation and
deallocation, as I do in C; lua will handle all of that for me and do so very efficiently.
Programs that manipulate strings with 100k or 1m characters are not unusual in lua.

I can aso delimit literal strings by matching single or double quotes which is pretty
standard nowadays in different langs.
]]
a = "a line"
b = 'another line'

--[[ As a matter of style, I should use always the same kind of quotes (single or double)
in a program, unelss the string itself has quotes; there I can use the other quote, or 
escape those quotes with backslashes. Strings in lua an contina the following C-like
esape sequences
  ▪ \a bell
  ▪ \b back space
  ▪ \f form feed
  ▪ \n newline
  ▪ \r carriage return
  ▪ \t horizontal tab
  ▪ \v vertical tab
  ▪ \\ backslash
  ▪ \" double quote
  ▪ \' single quote

Below some examples illustrate their use:
]]

print()
print("one line\nnext line\n\"in quotes\",'in quotes'")
print()
print('a backslash inside quotes: \'\\\'')
print()
print("a simpler way: '\\'")
print()

--[[ I can also specify a character in a string by its numeric value through the escape
sequence \ddd, where ddd is the sequence of up to 3 digits that identify the character.
As a somewhat complex example, the two literals 'alo\n123\"' and '\97lo\10\04923"' result
in the same thing using ascii:
  ▪ 97 is the code for 'a'
  ▪ 10 is the code for newline
  ▪ 49 is '1' (49 is used here with three digits \049 because it is followed by another
    digit; otherwise lua will try to read \492 as the code
    
I can also delimit literal strings also by matching double square brackets, without the --
as we do with long comments. Literals in this bracketed form may run for several lines and
do not inteprt escape sequences. Moreover, this form ignores the first character of the string
when this character is a newline. This form is especially convenient for writing strings 
that contain program pieces, as in the following example:]]
page = [[
<html>
<head>
<title>An HTML Page</title>
</head>
<body>
  <a href="http://www.lua.org">Lua</a>
  <a href="https://defold.com">Defold</a>
</body>
</html>
]]

print(page)
print()

--[=[ Sometimes I may want to enclose a piece of code containing something like a=ab[c[i]]
(notice the ]] in this code) Or I may need to enclose some code that already has some code
commented out. To handle such cases, as I've done here mismo, I can add any number of equals
signs between the two opening and closing brackets. This changes the delimter for comments and
literal strings 

Pairs of brackets with a differnt number of equal signs will be ignored. By choosing an
appropriate number of signs, I can enclose any literal string without having to add escapes
into it. 

This facility is valid as mentioned for both strings and comments, allowing me to easily comment
out a piece of code that contains parts already commented out. 

Lua provides automatic conversions between numbers and strings at run time. Any numeric
operation applied to a string will try to conver the string to a number first
]=]

print('10'+1)
print('10 + 1')
print('-5.3e-10'*'2') -- this is very interesting, so I can do math with strings 🤔
-- print('hello' + 1) --> error (cannot convert 'hello')
print()

--[[Lua applies such coercions not only in arithmetic operators, but also in other places
that expect a number.

Conversely, whenever lua finds a number where it expects a string, it converts the number
to a string]]

print(10 .. 20)
print()

--[[The .. is the string concatenator like . in PHP. When i write it right  after a number
I need to separate them with a space; otherwise lua thinks that teh first dot is a decimal
and I'm writing a float incorrectly, as I've already seen

At the time of writing PiL2 the creators of lua weren't sure if these coercions were a good
idea in the design of lua or not. As a rule, its better not to count on them. They are handy
in a few places, but add complexity to the language and sometimes to programs that use them.
After all, strings and numbers are different things, despite these conversions. A comparison
like 10=='10' is false because 10 is a number and '10' is a string. If I need to convert
a string to a number or vice versa its better to do so explicitly with the functions
  ▪ tonumber - which returns nil if the string doesn't denote a proper number:]]

--[[
line = io.read()      -- read a line
n = tonumber(line)    -- try to convert it to a number
if n==nil then
  error(line .. ' is not a valid number')
else
  print(n*2)
end
print()
--]]

--[[
  ▪ tostring - converts a number to a string; or I can concatenate the number with a ''
]]
print(tostring(10) == '10') --> true
print(10 .. '' == '10')     --> true as well

-- such conversions are always valid. In lua5.1 I can get the length of a string using
-- the length operator '#'
a = 'hello'
print(#a)
print(#'good\0bye') -->8
-- NOTE  TO SELF, interestingly that \0 is aa null terminator in C and it does the same
-- thing with this lua string 'good\0bye' just prints as 'good' 🤔🤔🤯

