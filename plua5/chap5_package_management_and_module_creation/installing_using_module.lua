-- Sample Program:  Installing and Using a Module - luasocket

local socket = require('socket')
local host = 'www.example.com'
local port = 80

-- create a tcp connection to the host
local tcp = assert(socket.tcp())
tcp:connect(host,port)
tcp:send('get / http/1.1\r\nHost: ' .. host .. '\r\n\r\n') 

-- recieve the response and print it
local response,status = tcp:receive('*a')
print()
print('Response from server:')
print(response)
tcp:close()

-- here I see how to use luasocket a bit to establish a tcp connection, send a basic get 
-- request, and print the server's response. 