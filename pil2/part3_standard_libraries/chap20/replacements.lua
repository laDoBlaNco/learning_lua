--[[
20.5 - REPLACEMENTS

Instead of a string, we can also use either a function or a table as the third
argument to string.gsub. When invoked with a function, string.gsub calls the 
function everytime it finds a match; the arguments to each call are the captures,
and the value that the function returns is used as the replacement string. When
invoked with a table, string.gsub looks up the table using the first capture as 
the key, and the associated value is used as the replacement string. If the table 
doesn't have this key, gsub doesn't change this match.

as a first example, the following function does variable expansion: it substitutes
teh value of the global variable varname for every occurrence of $varname in a
string
]]
function expand(s)
  return (string.gsub(s,'$(%w+)',_G))
end
name = 'Lua';status = 'great'

print(expand("$name is $status, isn't it?"));print()

--[[
So for each match with '$(%w+)' (a dollar sign followed by a name), :gsub looks up
the captured name in the global table (_G); the result replaces the match. When
the table doesn't have the key, there is no replacement.
]]
print(expand("$otherName is $status, isn't it?"));print()

--[[
If we aren't sure whether the given variables have string values, we may want to
apply tostring to their values. In this case, we can just use a function as the
replacement value
]]
function expand2(s)
  return (string.gsub(s,'$(%w+)',function(n)
    return tostring(_G[n])
  end))
end
print(expand2('print = $print; a = $a'));print()

--[[
Now, for each match with '$(%w+)', gsub calls the given function with the captured
name as argument; the return replaces the match. If the function returns nil, there
is no replacement. (This case can't happen in this example, since tostring never 
returns nil).

This last example goes back to our format converter, from the previous section. Again
we want to convert commands in LaTeX style (\example{text}) to XML style (<example>text</example>),
but allowing nested commands this time. The next function uses recursion for this:
]]
function toXml(s)
  s = string.gsub(s,"\\(%a+)(%b{})",function(tag,body)
    body = string.sub(body,2,-2) -- remove brackets
    body = toXml(body)            -- handle nested commands if there are any
    return string.format('<%s>%s</%s>',tag,body,tag) -- similar to when we did html 
  end)
  return s
end
print(toXml('\\title{The \\bold{big} example}'));print() -- 🤯🤯🤯

--[[
URL ENCODING

For our next example, we'll use URL encoding, which is the encoding used by HTTP
to send parameters in a URL. This encoding encodes special characters (such as
'=','&', and '+') as '%xx', where xx is the hexadecimal representation of the 
character. After that, it changes spaces to '+'. For example, it encodes this:

  'a+b = c' 

to:

  'a%2Bb+%3D+c'

finally it writes each parameter name and parameter value with the '=' between and
appends all resulting pairs name=value with an ampersand in between, so:

  name = 'al'; query = 'a+b'; q='yes or no'

are encoded as:

  name=al&query=a%2Bb+%3D+c&q=yes+or+no

Now, suppose we want to decode this URL and store each value in a table, indexed
by its corresponding name. The following function doe the basice decoding:
]]
function unescape(s)
  s = s:gsub('+',' ')
  s = s:gsub('%%(%x%x)',function(h)
    return string.char(tonumber(h,16))
  end)
  return s
end

--[[
First we change each '+' in the string to a space. Then we use gsub to match all of 
the two-digit hex numerals preceded by a '%' and call an anony function for each match.
This function converts the hex numeral into a number (tonumber, with base 16) and
returns the corresponding character with string.char. So:
]]
print(unescape('a%2Bb+%3D+c'));print()

--[[
Nwo to decode the pairs name=value we will gmatch. Since both names and values can't
contain either '&' or '=', we can match them with the pattern '[^&=]+':
]]
cgi = {}
function decode(s)
  for name,value in s:gmatch('([^&=]+)=([^&=]+)') do
    name=unescape(name)
    value=unescape(value)
    cgi[name]=value
  end
end

--[[
Here the call to :gmatch matches all pairs in the form name=value. For each pair
the iterator returns the corresponding captures (as marked by the parentheses in
the matching string) as the values for name and value. The loop body simply calls
unescape on both strings and stroes the pair in the cgi table. (Note when we say
'the iterator' we remember that gmatch, unlike gsub, is a factory function that 
returns an iterator function to be used with for.in)

The corresponding encoding is also easy to write. First, we write the escape function;
this function encodes all special characters as a '%' followed by the character code
in hex (the format option '%02x' makes a hex number with two digits, using 0 for padding),
and then changes spaces to '+'.
]]
function escape(s)
  s = s:gsub('[&=+%%%c]',function(c)
    return string.format('%%%02X',string.byte(c))
  end)
  s = s:gsub(' ','+')
  return s
end

-- the encode function traverses the table to be encoded, building the resulting string:
function encode(t)
  local b = {}
  for k,v in pairs(t) do
    b[#b+1]=(escape(k)..'='..escape(v))
  end
  -- return b:concat('&') --> This errors out since ':' only works with methods on objects
  -- and the only lua type with methods on the object is strings. All outhers must
  -- use the method libary as follows:
  return table.concat(b,'&')
end

t = {name='al',query='a+b = c',q='yes or no'}
print(encode(t));print()

--[[
TAB EXPANSIONS

An empty capture like '()' has a special meaning in lua. Instead of capturing nothing
(which is quite useless), this pattern tells lua to capture its position in the subject
string, as a number
]]
print(string.match('hello','()ll()'));print()


--[[
(note that this isn't the same thing we get from string.find, since the position of the
second empty capture is after the match. - But I don't understand why the first capture
then isnt BEFORE the match. Not very intuitive. 🤔)

A nice exaample of the use of empty () captures is for exanding tabs in a string:
]]
function expandTabs(s,tab)
  tab = tab or 8    -- tab 'size' (default is 8)
  local corr = 0
  s = s:sub('()\t',function(p)
    local sp = tab - (p-1+corr)%tab
    return string.rep(' ',sp)
  end)
  return s
end

--[[
So the gsub pattern matches all tabs in the string, capturing their positions. For each
tab, the inner function uses this position to compute the number of spaces needed to
arrive at a column that is a multiple of tab: it subtractsone from the positoin to make
it relative to zero and adds 'corr' to compensate for previous tabs (the expansion of
each tab affectds the position of the next ones). It then updates the correction (corr)
to be used for the next tab: minus one for the tab being removed, plus sp for the spaces
being added. Finally it returns the appropriate number of spaces.

Just for completeness, lets see how to reverse this operation, converting spaces to tabs.
A first approach could also involve the use of empty captures to manipulate positions, 
but there is a simpler solution. At every eighth character we insert a mark in the string.
Then, wherever the mark is preceded by spaces, we replace it by a tab:
]]

function unexpandTab(s,tab)
  tab = tab or 8
  s = expandTabs(s)
  local pat = string.rep('.',tab)
  s = s:gsub(pat,'%0\1')
  s = s:gsub(' +\1','\t')
  s = s:gsub('\1','')
  return s
end

--[[
The function starts by expanding the string to remove any previous tabs. Then it
computes an auxiliary pattern for matching all sequences of tab characters, and uses
this pattern to add a mark (a control character \1) after every tab character. It then
substitutes a tab for all sequences of spaces followed by a mark. Finally it removes
the marks left (those not preceded by spaces.)
]]

