-- basic_string_manipulation.lua
message = 'Lua is fun and powerful!'

-- string.upper('string') or 'string':upper()
upperMessage = string.upper(message)
print()

print('Uppercase:',upperMessage)
print()

-- string.lower('string') or 'string':lower()
lowerMessage = string.lower(message)
print('Lowercase:',lowerMessage)
print()

-- extracting portions of a strign with string.sub or 'string':sub 
subMessage = string.sub(message,8,10) -- inclusive?? yes it is!
print('Substring (chars from 8 to 10):',subMessage)
print()



