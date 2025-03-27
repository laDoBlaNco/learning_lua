-- when we combine serialization and deserialization we can easily exchange data between systems
-- Let's see an example 
-- Sending user data from lua app to a webservice and then process the response
-- First converting our lua table into json and send it via an HTTP POST request, and then get
-- a json response and we convert the response back into a lua table. 

local http = require('socket.http')
local ltn12 = require('ltn12')
local cjson = require('cjson')

-- define a lua table with user data to send to an api
local userData = {
  name = 'ladoblanco',
  age = 30,
  interests = {'programming','21 Pilots','gaming'}
}

-- Serialize the lua table to a JSON string
local jsonRequest = cjson.encode(userData)
print()
print('Serialized JSON Request:')
print(jsonRequest)

-- table to store the response body
local response_body = {}

-- Perform an HTTP POST request to a hypothetical API endpoint
local res,code,headers,status = http.request{
  url='http://httpbin.org/post',
  method='POST',
  headers = {
    ['Content-Type'] = 'application/json',
    ['Content-Length'] = tostring(#jsonRequest)
  },
  source = ltn12.source.string(jsonRequest),
  sink = ltn12.sink.table(response_body)
}
if code == 200 then
  print('HTTP POST request successful. Status code:',code)
  local fullResponse = table.concat(response_body)
  print('Received JSON Response:')
  print(fullResponse)

  -- Deserialize the JSON response into a lua table
  local decodedResponse = cjson.decode(fullResponse)

  -- access specific parts of the response, for example, the 'json' field that httpbin.org returns
  if decodedResponse.json then
    print()
    print('Decoded Response Data:')
    print('Name:',decodedResponse.json.name)
    print('Age:',decodedResponse.json.age)
    print('Interests:')
    for i,interest in ipairs(decodedResponse.json.interests) do
      print('  ' .. i .. ':',interest)
    end
  else
    print('No JSON field found in the response.')
  end
else
  print('HTTP request failed with status code:',code)
end

