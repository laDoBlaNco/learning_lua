-- in addition to GET requests I'll need to use POST requests  to send data to a server
-- the process is similar but includes additional parameters like request body and headers

local http = require('socket.http')
local ltn12 = require('ltn12')
local post_body = 'name=LuaUser&age=48'
local response_body_post = {}
local res_post,code_post,headers_post,status_post = http.request{
  url = 'http://httpbin.org/post',
  method = 'POST',
  headers = {
    ['Content-Type'] = 'application/x-www-form-urlencoded',
    ['Content-Length'] = tostring(#post_body)
  },
  source = ltn12.source.string(post_body),
  sink = ltn12.sink.table(response_body_post)
}

if code_post == 200 then
  print('HTTP POST request successful. Status code:',code_post)
  local full_response_post = table.concat(response_body_post)
  print('Response from POST request:')
  print(full_response_post)
else
  print('HTTP POST request failed. Status code:',code_post)
end
