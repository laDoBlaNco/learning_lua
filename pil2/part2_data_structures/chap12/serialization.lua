--[[
12.2 - SERIALIZATION

Now frequently we'll need to serialize some data, that is, to convert the data into
a stream of bytes or characters, so that we can save it into a file or send it 
through a network connection. We can represent serialized data as lua code as well
in such a way that, when we run the code, it reconstructs the saved values into the
reading program.

Usually, if we want to restore the value of a global variable, our chunk will be 
something like 'varname=exp', where 'exp' is the lua code to create the value.
The 'varname' is the easy part, so let's see how to write the code that creates
a v alue. For a numeric value, the task is pretty easy:
]]
function serialize(o)
  if type(o) == 'number' then
    io.write(o)
  else
    --<do something else>
  end
end

-- for string values, a naive approach would be something like:
function serialize(o)
  if type(o) == 'number' then
    io.write(o)
  elseif type(o) == 'string' then
    io.write("'",o,"'")
  end
end

--[=[ I had to add [=[ since I have some embedded [[]] in here 🤓
However, if the string contains special chars (such as quotes newlines, which almost
always is the case) the above code wouldn't be a valie lua program. We might be
tempted to fix it by changing the quotes like:

  if type(o) == 'string' then
    io.write("[[",o,"]]")
  end

BUT BEWARE! A malicious hacker could manage to direct our program to save something
like "]] ..os.execute('rm *')..[[" for example supplying this string as an address
Then our final chunk would turn into

  varname = [[ ]]..os.execute('rm *')..[[ ]] 🫨🫨

The simple way to to quote a string in a secure way is using the option '%q' from
the string.format function. It surrounds the string with double quotes and 
properly escapes double quotes, newlines, and some other characters inside the
string:
]=]

local a = 'a "problematic" \\string'
print(string.format('%q',a));print()

-- using this we can change our serialize function to:
function serialize(o)
  if type(o) == 'number' then
    io.write(o)
  elseif type(o) == 'string' then
    io.write(string.format('%q',o))
  end
end

--[[
Lua 5.1 offers another option as well to quote arbitrary strings in a secure way
(I specify 5.1 since that's what I'm focusing on using in my career and not the
newer version of 5.2  to 5.5, etc, which of course also do this).

We have notion [=[... ]=] for long strings. However, this notation is mainly 
intended for hand-written code, where we dn't want to change a literal string
in any way. In automatically generated code, its just easier to escape problematic
characters, as the option '%q' from string.format does.

If we nevertheless want to use the long-string quotation for automatically generated 
code, we must take care of some details. 

  - First, we must choose a proper number of equal signs. A good proper number is
    one more than the maximum that appears in the original string. Since strings 
    containing long sequences of equal signs are not uncommon (e.g., comments 
    delimiting parts of a source code), we can limit our attention to sequences
    of  equal signs preceded by a closing square bracket; other sequences cannot
    produce an erroneous end-of-string mark. 

  - Second, we must remember that the newline at the beginning of a long string is
    always ignored; a simple way to avoid this problem is to always add a newline to 
    be ignored. 
]]
function quote(s)
  -- find maximum length of equal signs
  local n = -1
  for w in string.gmatch(s,']=*') do
    n = math.max(n,#w-1)
  end
  --[[
  (Just as a side note, the difference between string.match and string.gmatch is 
  as follows, according to Google)
  The primary difference is how many matches they find AND how they return them. This
  is important as we would use them in different cases:

    - string.match only finds the first occurence and returns the captured string
      directly
    - string.gmatch finds ALL occurences in the string (g=global) and returns an
      ITERATOR FUNCTION to be used in the for..in loop as we learned with our deep
      dive into lua iterators
  ]]
  

  -- produce a string with 'n' plus one equal sign
  local eq = string.rep('=',n+1)

  -- build quoted string
  return string.format('[%s[\n%s]%s]',eq,s,eq)
end

--[[
Our 'quote' function receives an arbitrary string and returns it formatted as a long
string. The call to string.gmatch creates an iterator to traversre all occurences of
the pattern ']=*' (that is, the closing square bracket followed by a sequence of zero
or more equal signs) in the string 's'. For each occurrence, the loop updates n with
the max number of equal signs so far. After the loop finishes and we have the max
number of equal signs from 's', we use string.rep to replicate (NOT REPLACE) ...

(Again as a side note and to clear up my any confusion):
  - string.rep is to simply replicate (ore 'repeat' a pattern)
  - string.gsub (there is no string.replace) is used for replacing/global substitution.
    It uses lua patterns and returns a new string AND a match count (if needed)

    - example: 'change every "old" to "new"''
  
  - string.sub (not to be confused with string.gsub) is used for extracting/cutting
    our string (substring NOT substitution). It uses numeric positions (indices) and
    returns the extracted substring
  
    - example: 'give me chars 5 through 10' (note THROUGH, o sea, inclusive) 

... an equal sign n+1 times, which is one more than than the maximum occurring in
the string. Finally string.format encloses 's' with pairs of brackets with the correct
number of equal signs in between and adds extra spaces around the quoted strings plus
a newline at the beginning to be ignored.
]]



