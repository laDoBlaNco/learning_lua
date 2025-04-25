--[[
Names (also call identifiers) in lua can any string of letters, digits and underscores, not
beginning with a digit. This conicnides witht he definition of names in most lanugages. (The
definition of letter depends on teh current locale: any character considered alphabetic by the
current locale can be used in an identifier.) Indentifiers are used to anme varibles and table 
fields.

The following keywords are reserved and can't be used as names:
  ▫️ and     ▫️ break   ▫️ do    ▫️ else      ▫️ elseif 
  ▫️ end     ▫️ false   ▫️ for   ▫️ function  ▫️ if▫️ [     ▫️ ]
    ▫️ ;     ▫️ :     ▫️ ,     ▫️ .     ▫️ ..    
  ▫️ in      ▫️ locale  ▫️ nil   ▫️ not       ▫️ or
  ▫️ repeat  ▫️ return  ▫️ then  ▫️ true      ▫️ until     ▫️ while

So there are 21 keywords in lua 5.1

Lua is a case-sensitive language: 'and' is a reserved word, but 'And' and 'AND' are two
different, value names. As a convention, names starting with an underscore followed by
uppercase letters (such as _VERSION) are reserved for internal global variables used by lua

The following strings denote other tokens
▫️ +     ▫️ -     ▫️ *     ▫️ /     ▫️ %     ▫️ ^     ▫️ #
▫️ ==    ▫️ ~=    ▫️ <=    ▫️ >=    ▫️ <     ▫️ >     ▫️ =
▫️ (     ▫️ )     ▫️ {     ▫️ }     ▫️ [     ▫️ ]
▫️ ;     ▫️ :     ▫️ ,     ▫️ .     ▫️ ..    ▫️ ...

so 21 kwords and 22 tokeens

Literal strings can be delimited by matching single or double quotes, and can contain the
following c-like escape sequences:
▫️ '\a' (bell)
▫️ '\b' (backspace)
▫️ '\f' (form feed)
▫️ '\n' (newline)
▫️ '\r' (carriage return)
▫️ '\t' (horizontal tab)
▫️ '\v' (vertical tab)
▫️ '\\' (backslash)
▫️ '\"' (quotation mark [double quote])
▫️ '\'' (quotation mark [single quote])

A backslash followed by a real newline results in a new line in a string. A character in a string 
can also be specified by its numerical value using the escape sequence \ddd where ddd is a sequence
of up to 3 decimal digits. (Note that if a numerical escape is to be following by a digit, it
must be expressed using exactly 3 digits) Strings in lua can contain any 8-bit value, including
embedded zeros, which can be specificed by '\0'.

Literal strings can also be defined using a long format enclosed by long brackets. We define
an opening long bracket of level n as an opening square bracket following by n equal signs
followed by another opening square bracket. So, an opening long bracket of level 0 is written
as two opening square brackets. 
an opening long bracket of level 1 is written [=[ and so on. A closing long bracket is 
defined similarly; for instance a closing long bracket of level would be written as ]====].
A long string starts with an opening long bracket of any level and ends at the first closing
long bracket of the same level. Literals in this bracketed form can run for several lines, do
not interpret any escape sequences, and ignore long brackets of any other level. Which is why
I can then do embedded multiline comments in that way. They can contain anything except a closing
bracket of the proper level. 

For convenience when the opening long bracket is immediately followed by a newline, the 
newline is not included in the string. As an example, in a system using ASCII (in which 'a' is
coded as 97, newline is coded as 10, and '1' is coded as 49), the five literal strings below
denote the same thing
]]
a = 'alo\n123"'
print(a) print()

a = "alo\n123\""
print(a) print()

a = '\97lo\10\04923"' -- and see how the syntax coloring knows which are escape sequences
print(a) print()

a = [[alo
123"]]
print(a) print()

a = [==[
alo
123"]==]
print(a) print()

--[[
A numerical constatn can be written with an otional decimal part and an optional decimal
exponent. lua also accepts integer hexadecimal constants, by prefixing them with 0x. Examples
of value numerical constants are:
▫️ 3 
▫️ 3.0 
▫️ 3.1416 
▫️ 314.16e-2
▫️ 0.31416e1
▫️ 0xff
▫️ 0x56

A comment starts with a double hyphen (--) anywhere outside a string. If the text immediately after
-- is not an opening long bracket, the comment is a short comment, which runs until the end of
the line. Otherwise, it is a long comment, which runs until the corresponding closing long bracket
Long comments are requentyly used to disable code temporarily

]]


