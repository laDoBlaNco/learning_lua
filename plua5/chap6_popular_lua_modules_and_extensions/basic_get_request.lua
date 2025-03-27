-- first require the necessary modules from luasocket
local http = require('socket.http')
local ltn12 = require('ltn12')

-- create a table to store the response body
local response_body = {}

-- build and send the http get request using  table as argument
local res,code,response_headers,status = http.request{
  url = 'http://httpbin.org/get',
  sink = ltn12.sink.table(response_body),
  method = 'GET' -- so this is case sensitive here 
}

-- check if the request was successful
if code == 200 then
  print('HTTP get request successful. Status code:',code)

  -- combine the table elements to form the complete response string
  local full_response = table.concat(response_body)
  print('Response Body:')
  print(full_response)
else
  print('HTTP GET request failed. Status code:',code)
end