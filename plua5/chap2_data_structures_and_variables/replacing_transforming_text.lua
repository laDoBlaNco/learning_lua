-- replacing_transforming_text.lua

-- Another critical aspect of string manipulation is replacing parts of strings using
-- string.gsub (or 'string':gsub) This function searches for patterns and replaces all
-- occurrences (unless we use the optional count arg) with a specified replacment string

message = 'Lua , yes Lua is fun and powerful!'
print()
newMessage, replacements = message:gsub('Lua', 'Awesome Lua',1) -- note only the first Lua was changed
print('After replacement:', newMessage)
print('Number of replacements:', replacements)

-- additionally I can use string.format to create formatted string that combine vars with
-- fixed text. 'interpolation'
name = 'Explorer'
score = 95

formattedString = string.format('Congratulations %s, our score is %d.',name,score)
print()
print(formattedString) 
-- or with the 'string'::format syntax
str = 'Congratulations %s, our score is %d.'
print(str:format(name,score)) -- and it works as I expecte 🤯🤯🤯
print()



