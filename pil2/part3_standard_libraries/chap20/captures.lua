--[[
20.4 - CAPTURES

Now the capture mechanism in lua patterns allows us to yank parts of the subject
string that match parts of the pattern for further use. We specify a capture by
writing the parts of the pattern that we want to capture in ()s

When a pattern has captures, the function string.match returns each captured
value as a separate result (which is differnt from other languags that return it 
in an array); in other words, it breaks a string into its captured parts:
]]
pair = 'name = Anna'
k,v = pair:match('(%a+)%s*=%s*(%a+)')
print(k,v);print()

--[[
The pattern '%a+' specifies a non-empty sequence of letters (1 or more); the pattern
'%s*' specifies a possibly empty (zero or more) sequence of spaces. So in the example
above, the whole pattern specifies a sequence of lettesr, followed by a possible
sequence of spaces, followed by a '=', again a possible sequence of spaces, and another
sequence of letters. Both sequences have their patterns enclosed in ()s, so that they
will be captured if a match occurs and returned as separate results. Here is another
example:
]]
date = 'Today is 01/15/2026'
m,d,y = date:match('(%d+)/(%d+)/(%d+)')
print(y,m,d);print()

--[[
We can also use captures in the pattern itself. In a pattern, an item like '%d',
where d is a single digit, matches only a copy of the d-th capture. As a typical
use, suppose we want to find, inside a string a substring enclosed between single
or double quotes. We could try a pattern such as '["'].-["']', that is, a quote
followed by anything followed by another quote; but we would have problems with
strings like "it's all right". To solve this problem, we can capture the first 
quote and us it to specify the second one 🤔🤓
]]
a = [[then he said: "it's all right"!]]
q,quotedPart = a:match('(["\'])(.-)%1') -- so in other langs or regex where they use $1 $2
-- we use %1, %2 for those parts
print(quotedPart)
print(q)
print()

--[[
The first capture is the quote character itself and the second capture is the contents
of the quote (the substring matchint the '.-').

A similar example is th epatter tha tmatches long string sin lua:

  '%[(=*)%[(.-)%]%1]' -- so again we use the first capture to match the last

It will match an opening square bracket followed by zero or more equal signs, followed
by another opening square bracket, followed by anything (the string content), followed
by a closing square bracket, followed by the same number of equal signs, follwed by
antoher closing square bracket:
]]
p = '%[(=*)%[(.-)%]%1]'
s = 'a = [=[[[ something ]] ]==] ]=]; print(a)'
print(s:match(p));print()

--[[
The first capture is the sequence of equal signs (only one in this example); the second
is the string content

The third use of captured values is in the replacement string of gsub. like the pattern
also the replacement string may contain items like '%d', which are changed to the 
respective captures when the substitution is made. In particular, teh item '%0' is 
changed to the whole match. (by the way, a '%' in the replacement string must also be
escaped as '%%') as an example, the following command duplicates every letter in a string,
with a hyphen between copies:
]]
print(string.gsub('hello lua!','%a','%0-%0'));print()

-- this one interchanges adjacent characters
print(string.gsub('hello lua!','(.)(.)','%2%1'));print()






