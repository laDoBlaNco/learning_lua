local cjson = require('cjson')
local data = { name = 'Explorer', score = 95 }

local jsonString = cjson.encode(data)
print('JSON Output:',jsonString)