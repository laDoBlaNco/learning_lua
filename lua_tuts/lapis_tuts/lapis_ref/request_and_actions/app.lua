local lapis = require('lapis')
local app = lapis.Application()

-- an unnamed action
app:match('/',function(self) return 'hello' end)

-- an action with a name
app:match('logout','/logout',function(self) return {status=404} end)

-- a named action with a path parameter that loads the action function by module name
app:match('profile','/profile/:username','user_profile')


