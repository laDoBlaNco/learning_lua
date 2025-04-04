-- when making requests we'll run into things like network timeouts, invalid urls, or server
-- errors. luasocket gives us an http status code that we can check to see if the request
-- was successful. that's the 'res' I was checking in the previous example.
local http = require('socket.http')
local ltn12 = require('ltn12')
local response_body = {}
-- JUST ADDING THIS NOTE HERE AS I JUST NOW UNDESTAND WHAT WAS MEANT PRIOR WITH THIS LINE
-- SAYING THAT WE USE A TABLE FOR THE ARGUMENTS. HTTP.REQUEST HERE IS JUST A FUNCTION AND SINCE
-- WE ARE USING A SINGLE TABLE AS THE ARGUMENT INSTEAD OF HTTP.REQUEST({...}) WE ARE ABLE TO DO
-- HTTP.REQUEST{...} 🤯🤯🤯
local res,code,headers,status = http.request{
  url = 'http://nonexistent.url/test',
  sink = ltn12.sink.table(response_body)
  -- from http://lua-users.org/wiki/filterssourcesandsinks 
  -- A source is a FUNCTION that produces data, chunk by chunk, and a sink is a FUNCTION that TAKES
  -- data, chunk by chunk. 
}
if not res then
  print('HTTP request error:',code) -- code contains the error message
else
  if code == 200 then
    print('Request succeeded')
  else
    print('Request returned status code:',code)
  end
end

-- This error handling approach makes sure our application can react the right way when a request
-- fails. All of this knowledge helps us to build network-aware applications that can interact
-- with remote APIs and handle various HTTP scenarios

