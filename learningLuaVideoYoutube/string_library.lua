--[[
The String Library

  ▫️ byte    ▫️ lower
  ▫️ char    ▫️ match
  ▫️ find    ▫️ pattenrs
  ▫️ format  ▫️ rep
  ▫️ gmatch  ▫️ sub
  ▫️ gsub    ▫️ upper
  ▫️ len

Looks like there's no regex in lua cuz we have pattern recognition
]]

local first_string = 'hello world'
print(string.len(first_string))
print(#first_string) -- this works because of the way strings ar stored. I'm assuming it 
-- has to do with them being stored as arrays of chars similar to C

local second_string = string.rep('hi ',5) -- repeat or replicate(I thought it was replace)
print(second_string)

local third_string = 'HELLO world'
print(string.lower(third_string))
print(string.upper(third_string))

local sub_string = 'Hello World'
print(string.sub(sub_string,1,5)) -- again sub isn't substitution but substring 

print(string.char(99))
print(string.byte('xyz',1,3)) -- the arguments are either 1 index or a range

--formatting
print(string.format("pi: %.4f",math.pi))

local day,month,year = 5,2,2005
print(string.format('%02d/%02d/%04d',month,day,year)) -- note how we moved the day
-- based on the  printf from C
--[[
String Format / Patterns
    ▫️ string.format
      ▫️ % followed by a directive or specifier
          ▫️ d - decimal number (digit)
          ▫️ x - hexidecimal
          ▫️ o - octal
          ▫️ f - floating-point number
          ▫️ s - string
          ▫️ p - punctuation (not pointer) 
          ▫️ l - lower case ???
          ▫️ u - upper case ???
          ▫️ + - 1 or more repititions
          ▫️ * - 0 or more repititions
          ▫️ - - 0 or more repetitions
          ▫️ ? - 0 or 1 occurence

]]

local find_string = 'hello world'
local s_begin,s_end = string.find(find_string,'world')
print(s_begin,s_end) -- interesting that this gives us the whole word index rather than 
-- just the start like other languages. The power of returning multiple values.

local find_string2 = 'Hello World'
local found = string.match(find_string2,'World')
print(found)
-- same as the string.find but instead of giving us the indexes it returns the actual word
-- this example is contrived so it may not make sense as to why this is useful, but in
-- other siuations...

local date = 'Today is 2/15/2025'
local d = string.match(date, '%d+/%d+/%d+') -- there we go with some pseudo-regexing
print(d) -- using pattern matching to pull out the date 

-- we can also substitute strings
local temp = 'I have 2 children'
-- local temp = string.gsub(temp,'2','3') -- we could make the sub in place rather than have
-- a before and after as below.
local temp2 = string.gsub(temp,'2','3') -- gsub or global sub 
print(temp)
print(temp2)


