--[[
20.3  PATTERNS

(Before we start, just for my on clarification. I looked up LPEG as I remember that 
being lua's version of regexp. But PiL talks about Lua Patterns being the basic built-in
tool. But in investigating LPEG I see that its a library. LPeg (Lua Parsing Expression
Grammars) is a powerful, first-class pattern-matching library for the lua programming
language, enabling devs to build complex parsers and text processors that go beyond 
traditional regular expressions by defining patterns as objects that can be created,
combined, and manipulated programmatically. It provides efficient text analysis for
tasks like language parsing, data extraction, and syntax matching, often used to
create entire compilers or interpreters for other languages within lua. So in summary
its better than both Lua Patterns and RegExp 🤓🤯🤯. I knew there was a reason why
I remembered it.

  • Parsing Expression Grammars (PEGs): LPeg implements PEGs, a formal grammar model
    that offers more expressive power than standard regular expressions, particularly
    for recursive structures like those found in programming languages
  
  • First-Class Patterns: Patterns are treated as regular lua values (userdata, por fin),
    allowing them to be assigned to variables, passed as arguments, and built up using 
    lua's functions and operators, making complex definitions manageable and documented.

  • Powerful Matching: It can match literal strings, character sets, ranges, and complex
    sequences, while also supporting capturing groups to extract matched data.

  • re Module: LPeg includes a companioin 're' module  that translates standard regular
    expression syntax into LPeg patterns 🤯🤯, bridging the gap between familiar regex
    and LPeg's advanced capabilities.
)

We can make patterns more useful with 'character classes'. A character class is an item
in a pattern that can match any character in a specific set. For instance, the class %d
matches ANY digit. Therefore, we can search for a date in the format dd/mm/yyyy with the
pattern '%d%d/%d%d/%d%d%d%d'.
]]
str = 'The deadline is 31/01/2026, firm'
date = '%d%d/%d%d/%d%d%d%d'
s,e = string.find(str,date)
if s then print(string.sub(str,s,e)) end
-- a bit verbose to ensure we ensure sub gets an int and not nil. an easier way would
-- be to just :match
print(str:match(date)) -- no warnings or errors 🤔🤓
print()

--[[
The following lists all character classes in lua patterns:

  • . -- all characters
  • %a -- letters
  • %c -- control characters (escape, backspace, delete, etc)
  • %d -- digits
  • %l -- lowercase letters
  • %p -- punctuation characters
  • %s -- space characters
  • %u -- uppercase characters
  • %w -- alphanumeric (word) characters
  • %x -- hexadecimal digits
  • %z -- the character  whose representation is 0
  • an uppercase version of any of the above represent the compelement of the class
    i.e., '%A' represents all non-letter characters
]]
print(string.gsub('hello, up-down!','%A','.'));print()
--[=[
Remember that the 4 isn't part of the result string. Its the second result of gsub, the  
total number of substitutions

Some characters, called 'magic characters', have special meanings in patterns. The magic
characters are:
  • ()
  • .
  • %
  • +
  • -
  • *
  • ?
  • []
  • ^
  • $

The character '%' works as an escape for these magic characters. So '%.' matches
a dot; '%%' matches the character '%' itself. We can use the escape '%' not only
for the magic characters but also for all other non-alphanumeric characters. When
in doubt, play safe and put an escape. 

for lua, patterns are regular strings. They have no special treatment, following
the same rules as other strings. Only the pattern functions interpret them as
patterns, and only then does the '%' work as an escape. To put a quote inside
a pattern, we use the same techniques that we would use to put a quote inside
any other string; for instance, we can escape the quote with a '\', which is 
the escape character for Lua.

A 'char-set' allows us to create our own character classes, combining different
classes and single characters between square brackets (similar to regexp). For
instance, the char-set '[%w_]' matches both alphanumeric characters and underscores;
the char-set '[01]' matches binary digits (0s and 1s); and the char-set '[%[%]]' matches
square brackets (cuz we escaped %[ and %]). To count the numbero of vowels in a text
we can write:
]=]
text = 'this is some text with A bunch of vowells in it.'
nvow = select(2,string.gsub(text,'[AEIOUaeiou]',''))
print(nvow);print()
-- also note again using 'select' to get the 2nd result (substitution count) and 
-- discard the principle. 
--[[
We can also include character ranges in a char-set, by writing the first and the 
last characters of the range separated by a hyphen. The author of Lua seldom uses
this facility, because most useful ranges are already predefined in lua; for instance,
'[0-9]' is the same as '%d', and '[0-9a-fA-F]' is the same as '%x'. However, if we
need to find an octal digit, when we can write [0-7]' instead of the explicit 
enumeration like '[01234567]'. We can get the complement of any char-set by starting
it with '^' (just like regexp as well): the pattern '[^0-7]' finds any character that
is NOT an octal digit and '[^\n]' matches any character different from newline. But
remember that we can negate simple classes with its upper-case version as well:
'%S' is simpler than '[^%s]'.

Character classes follow the current locale set for Lua.Therefore, the class '[a-z]'
can be different from '%l'. In a proper locale, the latter from includes letters that
aren't in the english alphabet. So its good to always use the latter form rather than
just the character class, unless we have a strong reason not to. It's simpler and more
portable and slightly more efficient. 

We can also make patterns still more useful with modifiers for repetitions and optional
parts. Patterns in lua offer 4 modifiers:
  • + 1 or more repetitions
  • * 0 or more repetitions
  • - also 0 or more repetitions
  • ? optional (0 or 1 occurrence)

The '+' modifier matches one or more characters of teh original class. It will always
get teh longest sequence that matches the pattern. For example, the pattern '%a+' means
one more more letters, or a word
]]
print(string.gsub('one, and two; and three','%a+','word'))
print()

-- the pattern '%d+' matches one or more digits (an integer)
print(string.match('the number 1298 is even','%d+'));print()

--[[
The modifier '*' is similar to '+', but it also accepts zero occurrences of characters
of the class. A typical use is to match optional spaces between parts of a pattern.
For instance, to match an empty parenthesis pair, such as () or ( ), we use the 
pattern '%(%s*%)': the pattern '%s*' matches zero or more spaces. (Parenthesis are
magic characters so we need to escape them with '%'). As another example, the pattern
'[_%a][_%w]*' matches identifiers in a lua program: a sequence starting with a letter or
an underscore, followed by zero or mroe underscores or alphanumeric characters.

Like '*', the modifier '-' also matches zero or more occurrences of characters of the
original class. However, instead of matching the longest sequence, ti matches
the shortest one. Sometimes, there is no difference between '*' and '-', but
usually tyey present rather different results. For example, if we try to find an
identefier with the pattren '[_%a][_%w]-', we'll find only the first letter, since
the '[_%w]-' will always match the empty sequence. On the other hand, suppose
we want to find comments in a C program. Many people would first try '/%*.*%*/'
(that is, a '/*' followed by a sequence of any characters followed by '*/', written
with teh appropriate escapes). however, since the '.*' expands as far as it can,
the first '/*' in the program would close onl with the last '*/'
]]
test = 'int x; /* x */ int y; /*y */'
print(string.gsub(test,'/%*.*%*/','<COMMENT>'))
print()

-- but '-' would expand only the necessary amount
print(string.gsub(test,'/%*.-%*/','<COMMENT>'))
print()

--[[
The last modifier '?' matches an optional character. As an example, suppose we want to
find an integer in a text, where the number may contain an optional sign. The pattern
'[+-]?%d+' does the job, matching numerals like '-12', '23', and '+1009'. The '[+-]' is a
character class that matches both '+' and '-'; the following '?' maeks it optional. 

Unlike some other systems, in lua a modifier can be applied only to a character class;
there is no way to group patterns under a modifier. For instance there is no pattern
that matches an optional word (unless the word has only one letter). Usually we can 
circumvent this limitation using some of the advanced techniques that we'll see at the
end of this chapter.

If a pattern begins with a '^', it will match only at the beginning of the subject
string. Similarly, if it ends in '$', it will match only at the end of the subject
string. These marks can be used both to restrict the patterns that we find and to
anchor patterns. For example, the test: 

  if string.find(s,'^%d') then ...
  
checks whether the string s starts with a digit, and the test
  if string.find(s,'^[+-]?%d+$') then ...

checks whether thsi string represents an integer number, without other leading or 
trailing characters.

Another item in a pattern is '%b', which matches balanced strings. Such item is written 
as '%bxy', where x and y are any two distinct characters; the x acts as an opening
character and the y as the closing one. For example, the pattern '%b()' matches parts
of the string that start with a '(' an finish at the respective '):'
]]
s = 'a (enclosed (in) parentheses) line'
print(s:gsub('%b()',""));print()

-- Typically thsi pattern is used as '%b()', '%b[]', '%b{}', or '%b<>', but we can
-- use any characters that we need.









