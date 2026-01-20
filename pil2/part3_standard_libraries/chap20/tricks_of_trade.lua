--[[
20.6 - TRICKS OF THE TRADE

Pattern matching is a powerful tool for manipulating strings. We can perform
many complex operations with only a few calls to :gsub. However, as with any
power, we must use it carefully.

Pattern matching is not a replacement for a proper parser. For quick-and-dirty
programs, we can do useful manipulations on source code, but it is hard to build
a product with quality. As a good example, consider the pattern we used to match
comments in a C program: '/%*.-%*/'. If our program has a literal string containing
'/*', ewe may get a wrong result:
]]
test = [[char s[] = "a /* here"; /* a tricky string */]]
print(test:gsub('/%*.-%*/','<COMMENT>'));print()

--[[
Strings with such contents are rare and, for our own use, that pattern will probably
do its job. But we should not distribute a program with such a flaw.

Usually, pattern matching is efficient enough for lua programs: a Pentium 333mhz (which
is an ancient machine) takes less than a tenth of a second to match all words in a text
with 200K characters (30k words). But we can take  precautions. We should always make 
patterns as specific as possible; loose patterns are slower than specific ones. A 
extreme example is '(.-)%$', to get all text in a stringup to the first dollar sign. If
the subject string has a dollar sign, everything goes fine; but suppose that the string
doesn't cantain any dollar signs. The algorithm will first try to match the pattern
starting at the first position of the string. It will go through all the string, looking
for a dollar. When the string ends, the pattern fails for the first position of the
string. Then, the algo will do the whole search again, starting at the second position
of the string, only to discover that the pattern doesn't match there either, and so on.
This will take a quadratic time, which results in more than 3 hours in a pentium 333mhz
for a string of 200k chars. we can correct this by simply anchoring the pattern at the
first position of the string, with '^(.-)%$'. The anchor tells the algo to stop the 
search if it can't find a match at the first position. With the anchor, the pattern
runs in less than a tenth of a second.

Also we need to beware of 'empty' patterns, that is, patterns that match the empty
string. For instance, if we try to match names with a pattern like '%a*', we'll find
names everywhere:
]]
i,j = string.find(';$% **#$hello13','%a*');
print(i,j);print()

--[[
In this example, the call to string.find has correctly found an empty sequence of
letters at the beginning of the string.

It never makes sense to write a pattern that begins or ends with the modifier '-',
since it will match only the empty string. This modifier always needs something around
it to anchor its expression. Similarly, a pattern that includes '.*' is tricky, since
this construction can expand much more than we intended.

Sometimes, it is useful to sue lua itself to build a pattern. We already used this
trick in our function to convert spaces to tabs. As another example, let's see 
how we can find long lines in a text, say lines with more than 70 characters. 
Well, a long line is a sequence of 70 or mroe characters different from newline.
We can match a single character differnt from newline with the character class
'[^\n]'. Therefore, we an match a long line with a pattern that repeats 70 times
the pattern for one character, followed by zero or more of these characters. Instead,
of writing this pattern by hand, we can create it with string.rep:
]]
pattern = string.rep('[^\n]',70)..'[^\n]*'

--[[
As another example, suppose we want to make a case-insensitive search. A way of 
doing this is to change any letter x in the pattern for the class '[xX]', that
is, a class including both the lower and upper-case versions of the original letter.
We can automate this conversion with a function
]]
function noCase(s)
  s = s:gsub('%a',function(c)
    return '['..string.lower(c)..string.upper(c)..']'
  end)
  return s
end
print(noCase('Hi there!'));print()

--[[
Sometimes we want to change every plain occurrence of s1 to s2, without regarding
any character as magic. If the string s1 and s2 are literals, we can add proper
escapes to magic characters while we write the strings. But if these strings are
variable values, we can use another :gsub to put the escapes in for us:
]]
--[[
s1 = s1:gsub('(%W)','%%%1')
s2 = s2:gsub('%%','%%%%')
--]]
--[[
In a search string, we escape all non-alphanumeric characters (thus the upper-case 'w').
In the replacement string we escape only the '%'

Another useful technique for pattern matching is to pre-process the subject string
before the real work. Suppose we want to change to upper case all quoted strings
in a text, where a quoted string starts and ends with a double quote('"'), but may
contain escaped quotes ("\"")

Our approach to handlign such cases is to pre-process the text so as to encode the
problematic sequence to something else. For example, we could code "\"" as "\1".
However, if the original text already contains a '\1', we are in trouble. An easy 
way to do the encoding and avoid this problem is to code all sequences '\x' as
'\ddd', where ddd is the decimal representation of the character x.
]]
function code(s)
  return(s:gsub('\\(.)',function(x)
    return string.format('\\%03d',string.byte(x))
  end))
end

--[[
Now any sequence '\ddd' in the encoded string must have come from the coding,
because any '\ddd' in the original string has been coded, too. So, the decoding is
an easy task as well:
]]
function decode(s)
  return (s:gsub('\\(%d%d%d)',function(d)
    return '\\'..string.char(d)
  end))
end

-- now we can complete our task. As the encoded string doesn't contain any escaped
-- quote ("\""), we can search for quoted strings simply with '+.-"':
s = [[follows a typical string: "This is \"great\"!".]]
s = code(s)
s = s:gsub('".-"',string.upper)
s = decode(s)
print(s);print()

-- or a more compact version of the same
print(decode(string.gsub(code(s),'".-"',string.upper)));print()







