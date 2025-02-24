--[[
The power of raw lua to manipulate strings is quite limited. A program can create string literals,
concatenate them, compare them, and get string lengths. However, it can't extract substrings or
examine their contents. That all comes from the string library

many of the functions in string lib are pretty simple
]]
print('string.rep')
print(string.rep('abc',3))
print()
print('string.reverse')
print(string.reverse('A Long line'))
print()
print('strong.lower')
print(string.lower('THIS WAS IN CAPITALS'))
print()
print('string.upper')
print(string.upper('this was in lowercase'))
print()
print('string.sub')
--[[
string.sub(s,i,j) extracts a substring from i to j inclusive. Remember that lua starts with 1 not zero
We can also use negative numbers to start at the end.
]]
local s = '[in brackets]'
print(s)
print(string.sub(s,2,-2))
print(string.sub(s,1,1))
print(string.sub(s,-1,-1))
-- as stated  before none of these things change the original string unless we reassign it explicitly
print()

print('string.byte and string.char')
print(string.char(97,98,99))
local i = 99; print(string.char(i,i+1,i+2))
print(string.byte('abc'))
print(string.byte('abc',2))
print(string.byte('abc',-1))
print(string.byte('abc',1,2))
print(string.byte('abc',1,3))
print()

print('string.format')
-- seems like the same as used in C
print(string.format('x = %d y = %d',10,20))
print(string.format('x = %X',200))
print(string.format('x = 0x%X',200)) -- capital or lower x controls the letters in the hex number
print(string.format('x = %f',200))
local tag,title = 'h1','a title'
print(string.format('<%s>%s</%s>',tag,title,tag))
-- between the % and the directive  we can include other options just like in C
print(string.format('pi = %.4f',math.pi))
local d,m,y = 5,11,1990
print(string.format('%02d/%02d/%04d',d,m,y))
print()

print('string.find and string.gsub')
-- there are several functions on pattern matching as well
print(string.find('hello world','wor')) --> start to finish o sea 7 9
print(string.find('hello world','war')) --> nil
-- gsub - global sub will replace our pattern everywhere its found unless we explicitly tell lua
-- many matches to find. The it returns the replacement result with the number of changes made
print(string.gsub('hello world','l','.'))
print(string.gsub('hello world','ll','..'))
print(string.gsub('hello world','a','.')) -- these pattern matching functions are seen again in chap10