-- assume jsonString contains a json string obtained from a remote system or file
local cjson = require('cjson')
local jsonString = '{"name":"Explorer","age":30,"interests":["programming","music","travel"]}'

-- decode the json string back into a lua table
local decodedUser = cjson.decode(jsonString)

-- access fields from the decoded table
print()
print('Decoded User Data:')
print('Name:',decodedUser.name)
print('Age:',decodedUser.age)
print('Interests:')
for index,interest in ipairs(decodedUser.interests) do
  print('  ' .. index .. ':',interest)
end