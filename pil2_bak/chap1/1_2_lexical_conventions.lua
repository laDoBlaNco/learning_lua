--[[
1.2 Some lexical Conventions

Identifiers in lua can be any string of letters, digits, and underscores, not beginning
with a digit;
i   j    i10    _ij
aSomewhatLongName    _INPUT

I should avoid identifiers starting with an _ followed by one or more upper_case letters. They are
reserved for special uses in lua. Usually, I reserve the identifier _ (a single underscore) for
dummy vars as I've seen in other languages as well.

In lua the concept of what a letter is depends on the locale. With a proper locale, I can use
variable names such as ñíéáó etc. But it doesn't work with my ubuntu, so on to the next one.

The following 21 words are reserved in lua5.1 and can't be used as identifiers:
▫️ and   ▫️ break   ▫️ do    ▫️ else      ▫️ elseif
▫️ end   ▫️ false   ▫️ for   ▫️ function  ▫️ if
▫️ in    ▫️ local   ▫️ nil   ▫️ not       ▫️ or
▫️ repeat▫️ return  ▫️ then  ▫️ true      ▫️ until
▫️ while

Lus is case-sensitive: 'and' is a reserved word, but 'And' and 'AND' are two different words

A comment starts anywhere with -- and runs until the end of the line. Lua also offers block
comments, which start with -- and two opening brackets up until two closing brackets

A common trick when I want to comment out a piece of code is to enclose the code as folows
]]

--[[
print(10) -- this won't print
--]]

-- the above is a normal block comment. But by putting -- before the last ]] then if I change
-- the first to ---[[ it becomes a line comment and the ending --]] also becomes just a line
-- comment, allowing lua to run the code in between
---[[
print(10) -- this prints
--]]
