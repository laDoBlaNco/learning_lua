--[[
json parsing and serialization is all about to convert lua tables into json strings and
back into lua tables using json modules. This capability is essential when exchanging data between
systems, particularly when interacting with web APIs or storing data in a platform-independent
format. We will work with a popular json module, such as lua-cjson, to encode and decode json
data. This makes possible to serialize lua tables into a json format that can be transmitted
over the network and then deserialize the json data back into lua tables for further processing

Converting Lua Tables to JSON Strings

To do this we start by taking a lua table, similar to one you may have used in previous examples
]]

-- require the cjson module
local cjson = require('cjson')

-- define a lua table with suer data
local user = {
  name = 'Explorer',
  age = 30,
  interests = {'programming','music','travel'}
}

-- convert the lua table to a json string
local jsonString = cjson.encode(user)
print()
print('JSON String:')
print(jsonString)

-- here we load the cjson module and then encode the user table into json string using cjson.encode
-- The print json string represents the lua table in a standard format that can be transmitted to
-- other systems