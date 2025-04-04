--[[
Working with HTTPS
The other examples use HTTP, but many APIs require us to use HTTPS for secure communication
LuaSocket supputs HTTPS as well if we have th e appropriate luasec library installed. For
HTTPS requires ssl

]]

-- require luasocket's https and ltn12 modules (luasec provides https)
local https = require('ssl.https')
local ltn12 = require('ltn12')
local response_body_https = {}
local res,code,headers,status = https.request{
  url = 'https://httpbin.org/get',
  sink = ltn12.sink.table(response_body_https)
}
if code == 200 then
  local full_response = table.concat(response_body_https)
  print('HTTPS GET request successful. Status code:',code)
  print('Response:')
  print(full_response)
end

-- this example is the same as our http example, but we use ssl.https to establish a secure
-- connection. It ensures data transmitted between our application and the API endpoint remains
-- encrypted.
