-- one frequent issue is attempting to load a file that doesn't exist. for example if a file
-- if missing to handle this we can check the file's existence before attempting to load it
-- catching the error with pcall
local function loadScript(filename)
  local file = io.open(filename,'r')
  if not file then
    error("File '" .. filename .. "' not found.")
  else
    file:close()
    dofile(filename)
  end
end

local status, err = pcall(loadScript, "embedded_script.lua")
if not status then
  print('File not found error handled:',err)
  -- fallback: execute default script or use built-in functionality
end

-- this approach ensure that if the file is not present, you log the error and fall back
-- gracefully