-- combining_manipulation_techniques.lua

-- here we have a comprehensive sample program that combines various string manipulation
-- techniques. This program processes a sentence by converting its case, extracting substrings
-- searching for specific words, and replacing certain text elements.

-- Sample program for string manipulation in lua
-- Original text message
originalText = 'Lua is fun, dynamic, and powerful. Learning Lua opens many doors.'

-- convert to uppercase and lowercase
upperText = originalText:upper()
lowerText = originalText:lower()
print()
print('Original:', originalText)
print('Uppercase:', upperText)
print('Lowercase:', lowerText)
print()

-- extract a substring: extract the first sentence
periodPosition = string.find(originalText, '%.')
if periodPosition then
  firstSentence = string.sub(originalText, 1, periodPosition)
  print('First Sentence:', firstSentence)
end

-- search for pattern: find the word 'dynamic'
searchPattern = 'dynamic'
startPos, endPos = originalText:find(searchPattern)
if startPos then
  print("The word '" .. searchPattern .. "' found from position",startPos,"to",endPos)
else
  print("The word '" .. searchPattern .. "' was not found.")
end

print()
-- replace the word 'lua' with 'lua programming'
modifiedText,count = string.gsub(originalText,'Lua','Lua Programming')
print('Modified text:',modifiedText)
print('Replacements made:',count)
print()

-- create a formated string combining variables 
name='Explorer'
activity='coding'
str = 'Hello %s, welcome to %s in Lua!'
formattedOutput = str:format(name,activity)
print(formattedOutput)