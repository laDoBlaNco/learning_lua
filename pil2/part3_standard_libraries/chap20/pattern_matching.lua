--[[
20.2 - PATTERN MATCHING FUNCTIONS

The  most powerful funtions in the string library are 

  • find
  • match
  • gsub (global substitution)
  • gmatch (global match)

The are all based on patterns. Unlike several other scripting languages, lua uses
neither POSIX (regexp) nor Perl regular expressions for patten matching. The main 
reason for this decision is size: a typical implementation of POSIX regular expressions
takes more than 4000 lines of code. This is about the size of all lua standard libraries
together. In comparison, the implementation of pattern matching in lua has less
than 500 loc. Of course, the pattern matching in lua can't do all that a full POSIX
implementation does. Nevertheless, pattern matching in lua is a powerful tool, and
includes some features that are difficult to match with standard POSIX implementations.

THE STRING.FIND FUNCTION:

The string.find function searches for a pattern inside a given subject string. The
simplest form of a pattern is a word, which matches only a copy of itself. For
example, the pattern 'hello' will search for th substring 'hello' inside the
subject string. When find finds its pattern, it returns two values: the index where
the match starts and the index where the match ends. If it doesn't find a match,
it returns nil:
]]
s = 'hello world'
i,j = s:find('hello',1)
print(i, j)
print(s:sub(i or 1,j))
print(s:sub(i or 1,j))
--[[
A peculiarity I found with string.find and string.sub. Apparently it requires a null-check
or it gives a warning that these functions that require ints might get nils at runtim. so
I had to do a nil check, basically i or 1, meaning, use i or default to 1 (beginning) if nil
]]

print(s:find('world'))
i,j = s:find('l')
print(i,j)
print(s:find('lll'))

--[[
When a match succeeds, we can call string.sub or s:sub with the values returned
by string.find (or s:find) to get the part of the subject string that matched the
pattern. (for simple patterns this is the pattern itself)

string.find has an optional third parameter: an index that tells where in the subject
string to start looking. This parameter is useful when we want to process all the
indices where a given pattern appears. We search for a new match repeatedly, each time
starting after the position where we found the previous one. As an example, the
following makes a table with the positions of all newlines in a string
]]
print()
local t = {}
local i = 0
while true do
  i = s:find('\n',i+1)
  if i==nil then break end
  t[#t+1]=i
end
-- there is a simpler way to write this loop, but we'll  see it later. using the 
-- string.gmatch iterator

--[[
THE STRING.MATCH FUNCTION

The string.match function is similar to string.find, in the sense that it also searches
for a pattern in a string. However, instead of returning the position where it found
the pattern, it returns the actual part of the subject string that matched the
pattern:
]]
pattern = 'hello Lua world'
print(string.match(pattern,'hello'))
print(pattern:match('hello'))
print()
-- for fixed patterns like 'hello' this function is pointless. It shows its real
-- power when used with variable patterns, as in the next example:
date = 'Today is 01/10/2026'
d = date:match('%d+/%d+/%d+')
print(d);print()

-- we'll get into some of the more advanced uses of string.match soon

--[[
THE STRING.GSUB FUNCTION

The string.gsub function has three parameters:
  • a subject string (which can also go before the : in the OO syntax str:gsub(...))
  • a pattern
  • a replacement string

its basic use is to substitute (gsub = global substitution, not 'substring' as in string.sub) 
the replacement string for all occurrences of the pattern inside the subject string:
]]
s = string.gsub('Lua is cute','cute','great')
print(s)
s = string.gsub('all lii','l','x')
print(s)
s = string.gsub('Lua is great','Sol','Sun')
print(s)

-- an optional 4th parameter limits the number of substitutions to be made:
s = string.gsub('all lii','l','x',1)
print(s)
s = string.gsub('all lii','l','x',2)
print(s);print()

--[[
The string.gsub function also returns as a second result, if we want to use it, the 
number of items it made the substitution. for example, an easy way to count the number
of spaces in a string is the following idiom
]]
str = 'this is a string with a bunch of words and spaces.'
count = select(2,string.gsub(str,' ',' '))
print(count);print()

-- note the use of select() to select the 2nd return value from the 2 returned from the function
-- I could have also done:
_,count = str:gsub(' ',' ')
print(count)

--[[
THE STRING.GMATCH FUNCTION

The string.gmatch function returns a function that iterates (an iterator function) over
all occurrences of a pattern in a string. This would make :gmatch a FACTORY and the anony
function that is returned is STATEFUL since it doesn't take any arguments, meaning it can
be ran alone to get the resulting matches. It tracks its own state and doesn't need anything
externally to do its job:
]]
func = str:gmatch('is')

print()
print(func()) --> 'is' first occurrence
print(func()) --> 'is' second occurrence
print(func()) --> '' (nil) no more occurrences
print()

-- the following example collects all words in a given string s:
words = {}
for w in str:gmatch('%a+') do words[#words+1] = w end
for _,word in pairs(words) do print(word) end
print()

--[[
As we'll be seeing shortly, the pattern '%a+' matches sequences of one ore more '+' 
alphabetic characters (that is, words). So, the 'for' loop will iterate over all
words of te subject string, storing them in the list words. 

Using gmatch and gsub, it isn't difficult to emulate in lua the search strategy
that 'require' uses when looking for modules:
]]
function search(modname,path)
  modname = string.gsub(modname,'%.','/')
  for c in string.gmatch(path,'[^;]+') do
    local fname = string.gsub(c,'?',modname)
    local f = io.open(fname)
    if f then
      f:close()
      return fname
    end
  end
  return nil  -- not found
end

--[[
The first step is to substitute the directly separator, assumed to be '/' for this
example, for any dots. (As we'll see later, a dot has a special meaning in a pattern.
To get a dot without other meanings we must right with the pattern escape sequence '%'
or in other words '%.'). Then the function loops over all components of the path, wherein
each component is a maximum expansion of non-semicolon characters. For each component,
it replaces the module name for the question marks to get the final file name, and
then checks whether there is such a file. If so, the function closes the file and 
returns its name.
]]








