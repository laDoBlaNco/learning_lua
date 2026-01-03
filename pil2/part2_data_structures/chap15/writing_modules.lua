--[[
15.2 - THE BASIC APPROACH TO WRITING MODULES

The simplest way to create a module in Lua is really really simple. 
  • create a table
  • put all functions we want to export in that table (making those we don't private
    by making the 'local')
  • then we return that table
]]
complex = {}

function complex.new(r,i) return {r=r,i=i} end

-- define a constant 'i'
complex.i = complex.new(0,1)

function complex.add(c1,c2)
  return complex.new(c1.r+c2.r,c1.i+c2.i)
end

function complex.sub(c1,c2)
  return complex.new(c1.r-c2.r,c1.i-c2.i)
end

function complex.mul(c1,c2)
  return complex.new(c1.r*c2.r - c1.i*c2.i,c1.r*c2.i+c1.i*c2.r)
end

local function inv(c)
  local n = c.r^2 + c.i^2
  return complex.new(c.r/n,-c.i/n)
end

function complex.div(c1,c2)
  return complex.mul(c1,inv(c2))
end

return complex
--[[
Just he use of tables for modules though doesn't provide exactly the same functionality as
provided by 'real' modules. 
  • First, we must explicitly put the module name in every function definition.
  • Second, a function that calls another function inside the same module must 
    qualify the name of the of the called function. 
    
We can fix these issues by just using a fixed local name for the module, (which in actuality
just means that we shorten the name to make it less verbose)

  local M = {}
  complex = M
  M.i = {r=0,i=1}
  function M.new(r,i) return {r=r,i=i} end

  function M.add(c1,c2)
    return M.new(c1.r+c2.r,c1.i+c2.i)
  end

  <etc>

It still needs to prefix the name, but now the connection between the two functions 
doesn't depend on the module name anymore. Moreover, there is only one place in the
whole module where we write the actual module name. 

There are also some other tweaks that I might see in the wild with  modules, for 
example:

  • we don't have to write the module name at all since require passes it as an arg
    to the module:

      local modname = ...
      local M = {}
      _G[modname] = M 

      M.i = {r=0,i=1}
      <etc>
    
    With this change all we have to do is rename the file and that'll rename the
    the module.

  • Another tweak is with the closing return statement. We can put the module 
    related tasks all at the beginning of the module. One way to do this is assign
    the module table directly into package.loaded, since if a module doesn't return
    any value, 'require' returns the current value of package.loaded[modname]
    anyways:

      local modname = ...
      local M = {}
      _G[modname] = M
      package.loaded[modname]=M

      <etc>
]]
