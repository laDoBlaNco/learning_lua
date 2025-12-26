--[[
11.6 - STRING BUFFERS

Now suppose we are building a string piecemeal, for instance reading a file line
by line. Our typical code would look like the following:
--]]

--[[
local buff = ''
for line in io.lines() do
  buff = buff..line..'\n'
end
print(buff);print()
--]]

--[[
Despite its innocent looke, this code in lua cause a huge performance penalty for 
large files: for example, it takes alomst a minute to read a 350kb file. 

Why is that? we ask. To understand whats happening, let's assume that we are in the
middle of the read loop; each line as 20 bytes and we have already read some 2500
lines, so buff is a string with 50kbs. Now when lua concatenates buff..line..'\n',
it creates a new string with 50020 bytes and copies 50000 bytes from buff into this
new string. That is for each new line, lua is moving 50kbs of memory, and growing.
After reading 100 new lines (only 2kbs), lua has already moved over 5mbs of memory.
More to the point, the algorithm is quadratic. When lua finishes reading 350kbs, it 
has moved around more than 50gbs. 🤯🤯🤯

This problem is not peculiar to lua: other languages wherein strings are immutable
values present a similar behavior, Java being the most famous example. 

Before we continue, we should take note that, despite everything we've said, this
situation isn't a common problem. for small strings, the above loop is fine. To 
read an entire file, lua provides the io.read('*all') option, which reads the file
at once. However, sometimes we must face this problem. Java offers the structure
StringBuffer to ameliorate (make something bad better) the problem. In lua, we 
can use a table as the string buffer. The key to this approach is the table.concat
function, which returns the concatenation of all the strings of that given list.
Using .concat, we can write our previous loop as follows
--]]

--[[
local t = {}
for line in io.lines() do
  t[#t+1] = line..'\n'
end
local s = table.concat(t)
--]]

-- table.concat works like this
local strbuff = {'first line\n','second line\n','third line\n'}
print(table.concat(strbuff))

--[[
The algorithm takes less than 0.5 seconds to read the file that took almost a minute
to read with the original code. (of course, for reading a whole file it is better to
use io.read('*all'))

We can actually do even better than this though. The concat function accepets an
optional second argument, which is a separator to be inserted between the strings.
Using this separator, we don't need to insert a newline after each line.
--]]

--[[
local t = {}
for line in io.lines() do
  t[#t+1] = line
end
s = table.concat(t,'\n')..'\n'
--]]

-- table.concat works like this with the second parameter
local strbuff = {'first line','second line','third line'}
print(table.concat(strbuff,'\n'))

--[[
So the function concat inserts the separator between the strings, but we still have to
add the last newline. This last concatentation duplicates the resulting string, which
can be quite long. There is no option to make concat insert this extra separator,
but we can decieve it, inserting an extra empty string in t: t[#t+1] = ''

The extra newline that concat adds before this empty string would then be at the end
of the resulting string as we wanted.

Internally, both concat and io.read('*all') use the same algorithm to concatenate
many small strings. Several other functions from the standard libraries also use this
algorithm to create large strings. Let's see how that works.

Our original loop took a linear approach to the problem, concatenating small strings
one by one into the accumulator. This new algorithm will avoid this, using a binary 
approach instead. It concatentates several small strings among them and, occasionally,
it concatenates the resulting large strings into larger ones. The heart of the 
algorithm is a stack that keeps the large strings already created in its bottom,
while small strings enter through the top. The main invariant of this stack is
similar to that of the popular (amount programmers anyways) Tower of Hanoi:
a string in the stack can never sit over a shorter string. Whenever a new string
is pushed over a shorter one, then (an only then) the algorithm concatenates
both, thus keeping the longer strings at the bottom. This concatenation creates
a larger string, which now may be larger than its neighbor in the previous floor.
If this happens, they are also concatenated. These concatenations go down the 
stack until the loop reaches a larger string or the stack bottom
]]
function add_string(stack,s)
  stack[#stack+1] = s     -- push 's' into the stack
  for i = #stack-1,1,-1 do -- note we are loop backwards here or going down
    if #stack[i] > #stack[i+1] then break end
    stack[i] = stack[i] .. stack[i+1]
    stack[i+1] = nil
  end
end

--[[
To get the final contents of the buffer, we just concatentate all strings down to the
bottom
]]







