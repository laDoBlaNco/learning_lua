-- luasockets also allows for advance customizations of HTTP requests. I can set timeouts,
-- add custom headers, and even handle redirects, which are important when dealing with dbases
-- as I learned in studying PHP. 
-- Here I set up a timeout for the HTTP request
local http = require('socket.http')
local ltn12 = require('ltn12')
local response_body = {}

local res,code, response_headers,status = http.request{
  url='http://httpbin.org/get',
  sink=ltn12.sink.table(response_body),
  method='GET',
  timeout=10 -- timeout in seconds
}

if code == 200 then
  print('HTTP GET request successful with timeout. Status code:',code)
  local full_response = table.concat(response_body)
  print()
  print('Response:')
  print(full_response)
else
  print('HTTP GET request failed or timed out. Status code:',code)
end