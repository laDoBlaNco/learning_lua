local lapis = require 'lapis'
local app = lapis.Application()

-- route for the home page
app:get('/',function(self)
  return {render = 'index'}
end)

-- route for a simple greeting page
app:get('/hello',function(self)
  return 'Hello, welcome to our Lapis web app!'
end)

-- route for a dynamic user profile using a URL parameter (THIS DOESN'T WORK CUZ i DON'T HAVE A VIEW
-- AND BELOW IT SAYS 'render = 'user')
app:get('/user/:id',function(self)
  local user_id = self.params.id
  return {render = 'user', user = {id = user_id,name='User ' .. user_id}}
end)

-- lapis also supports url parameters and wildcards to handle a variety of routing scenarios
-- since parameters with a : allow me to extract specific parts of the url, wildcards can capture
-- multiple segments
app:get('/files/*path',function(self)
  local file_path = self.params.path
  return 'You requested the file at path: ' .. file_path
end)

-- The *path wildcard captures all parts of the url after /files/, storing the entire segment in
-- self.params.path. This is especially useful when I need to build file servers or create dynamic
-- routes that can accept a variable number of subdirectories

return app

--[[
Here I require the lapis module and create an application instance. The app:get method defines
a rount for HTTP GET requests. For the home page '/' the route returns a render directive
that tells lapis to display the 'index' template. For the /hello route, the function returns
a simple text response. The dynamic route /user/:id demonstrates how to capture a parameter from the 
url; here, :id is a placeholder, similar to PHP that lapis extracts and makes available through
self.params.id. 
]]