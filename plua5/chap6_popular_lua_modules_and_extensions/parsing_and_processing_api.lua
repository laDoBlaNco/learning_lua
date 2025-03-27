-- Lots of times web APIs return data in JSON. Once I have captured the response, I need to
-- parse the json data into a lua table for further processing. for this I can use lua-cjson
-- as I saw befre.

local http = require('socket.http')
local ltn12 = require('ltn12')
local cjson = require('cjson')
local response_body = {}
local res, code, response_headers, status = http.request {
  url = 'http://httpbin.org/get',
  sink = ltn12.sink.table(response_body)
}

if code == 200 then
  local full_response  = table.concat(response_body)
  print()
  print('Raw JSON Response:')
  print(full_response)

  -- parse the json resposne into a lua table
  local parsed_data = cjson.decode(full_response)

  -- access a specific field, e.g., the url from the json response
  print()
  print('Extracted URL:',parsed_data.url)
else
  print('HTTP GET request failed. Status code:',code)
end

-- in this example I require cjson module and decode JSON string obtained from resposne into
-- a lua table. This enables me to easily access individual fields and integrate the API
-- data into our application logic when I need to. 