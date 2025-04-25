local lapis = require("lapis")
-- local config = require('lapis.config').get()

local app = lapis.Application()
app:enable('etlua')
app.layout = require 'views.layout'

app:get("/", function(self)
  -- return {render = 'index'}
  -- return config.greeting .. ' from port ' .. config.port
  self.my_favorite_things = {
    'Cats',
    'Horses',
    'Skateboards',
  }

  return {render='list'}
end)

return app
