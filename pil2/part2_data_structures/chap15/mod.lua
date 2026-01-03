-- mod.lua - UPDATED
local modname = ...
local m =  {}
_G[modname] = m
package.loaded[modname] = m

function m.foo()
  print('working from module "mod"')
end
-- return m -- no longer neede???