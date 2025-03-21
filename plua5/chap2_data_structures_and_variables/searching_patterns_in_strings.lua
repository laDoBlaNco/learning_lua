-- searching_patterns_in_strings.lua
-- we can search for patterns in strings with string.find or 'string':find
-- pattern = 'fun'
message = 'Lua is fun and powerful!'
pattern = 'kevin'
startIndex,endIndex = message:find(pattern)
print()
print(startIndex,endIndex)
if startIndex then
  print("Pattern '" .. pattern .. "' found at position",startIndex,"to",endIndex)
else
  print("Pattern '" .. pattern .. "' not found!")
end
print()

-- Apart from this, lua's pattern matching capabilities extend beyond simply text searches
-- Lua uses PEG (parsing expression grammar) through the LPEG library, which is like regex, but
-- can be more powerful and flexible. 
-- We will encounter special chars and char classes that let us  much digits, letters, or even
-- spaces. 
textWithNumbers = 'The year is 2025.'
nS,nE = string.find(textWithNumbers,'%d+')

print()
print(nS,nE)
if nS then print('Number found:',textWithNumbers:sub(nS,nE)) end
print()



