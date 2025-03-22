--[[
You have multiple options for embedding lua scripts. The simplest method is using dofile
to execute an external lua file. This method allows you to load and run a script as part 
of our main application. Alternatively, I can use 'require' to load modules that return 
tables or functions. In more advanced scenarios, you might embed lua in a host application
in C or another language using lua's C API, which offers greater control over the integration
process. 

Here's an example wherein the main lua application needs to call an embedded script
to perform a specific task. 

]]

-- main.lua: main application file
print('Main Application Starting...')

-- load and execute the embedded lua script
local status, err = pcall(function()
  dofile('embedded_script.lua')
end)

if not status then -- remember that pcall returns a boolean ,thus that's where 'status' is coming from
  print('Error during script integration:', err)
  -- Implement fallback: log the error or continue with default behavior
else
  print('Embedded script executed successfully')
end
print('Main Application Continues...')

-- here again we used pcall to catch any errors that occur during the execution of
-- embedded_script.lua this helps prevent the entire application from crashing if the
-- embedded script fails

