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
--[[
Remember that the 4 isn't part of the result string. Its the second result of gsub, the  
total number of substitutions

Some charachters, called 'magic characters', have special meanings in patterns. The magic
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

The character '%' works as an escape for these magic characters.
]]



