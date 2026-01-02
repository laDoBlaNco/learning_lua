--[[
14.2 - GLOBAL VARIABLE DECLARATIONS

So, global variables in lua don't need declarations. So this makes this section
of the book a little unnecessary. Although this is handy for small programs, in 
larger programs a simple typo can cause bugs that are difficult to find. With 
that in mind, we are able to change this behavior if we like. Since lua keeps 
its global variables in a regular table, we can use metatables to change its 
behavior when accessing global variables. Interesting ... 🤔

A first approach simply detects any access to absent keys in the global table:
]]

--[[
setmetatable(_G,{
  __newindex = function(_,n)
    error('attempt to write to undeclared variable ' .. n, 2)
  end,
  __index = function(_,n)
    error('attempt to read undeclared variable ' .. n,2)
  end,
})
--]]

-- after this, any attempt to access a non-existent global var will trigger our error:
-- print(a)

-- But now, how do we then declare new variables? One option is to use rawset, which 
-- again bypasses the metamethod
--[[
function declare(name,initval)
  rawset(_G,name,initval or false)
end
--]]

--[[
(The 'or' with 'false' ensures that the new global always gets a value different from 
nil.) A simpler ways is to just allow assignments to global variables in the main chunk
so that we declare variables as normal

  a = 1

To check whether the assignment is in the main chunk, we can use the debug library. The
call 'debug.getinfo(2,'S')' returns a table whose field 'what' tells whether the function
that called the metamethod is a main chunk, a regular lua function, or a C function. 
Using this function, we can rewrite the __newindex metamethod as so:
]]

--[[
setmetatable(_G,{
  __newindex = function(t,n,v)
    local w = debug.getinfo(2,'S').what
    if w ~= 'main' and w~='C' then
      error('attempt to write to undeclared variable ' .. n, 2)
    end
    rawset(t,n,v)
  end,
  __index = function(_,n)
    error('attempt to read undeclared variable ' .. n,2)
  end,
})
a=1 -- now this works
--]]

--[[
This new version also accepts assignments from C code, as this kind of code usually
knows what its doing.

To test whether a variable exists, we can't simply compare it to nil, because, if it is 
nil, the access will throw an error. Instead, we use rawget, which again avoids the
metamethod:

  if rawget(_G,var) == nil then
    -- var is undeclared
    <other code>
  end

As it is, our scheme doesn't allow global variables with nil values, as they would be
automatically considered undeclared. But it isn't difficult to correct this problem
either. All we need is an auxiliary table that keeps the names of declared variables.
Whenever a metamethod is called, ti checks in this table whether the variable is
undeclared or not. The code may be like our final example below. Now even an assignment
like x = nil is enough to declare a global variable. 

For both solutions, the overhead is negligible. With the first solution, the metamethods
are never called during normal operation. In the second, they may be called, but only when
the program accesses a variable holding nil.

The lua distribution comes with a module 'strict.lua' that implements a global-variable
check that uses essentially the code we just looked at. It is a good habit to use it
when developing lua code. (I've just used luarocks to install 'strict.lua'. Below is 
what I found on Google regarding it:

  strict.lua refers to two distinct tools used to enforce better coding practices in the
  lua ecosystem: 

    • Standard Lua: strict.lua Global Checker
      A global variable checker for standard Lua (5.1-5.4) and LuaJIT, found in the 
      'extras' folder of the distribution or installed via luarocks. Its primary
      purpose is to catch undeclared  global variables, preventing typos from silently
      creating new globals. Lua's creator recommends its use. 

        • Its used with require('strict'). It uses a metatable on the global environment
          (_G) to throw an error whenever an undeclared global  is accessed or assigned 
          (typically a typo, e.g., the variable is 'hello' and we later type 'helllo' 
          and as lua is now it just sits there as nil in our program. With scrict.lua, 
          that type will complain.). FYI if using luarocks to install the maintained 
          version then the usage is a bit more explicit in order to work with the 
          more modern lua-stdlib scope. It can also be applied to specific scopes.
          To use the modern version it must be assigned to the environment scope:
          local _ENV = require('std.strict')(_G) 
          

    • Luau (Roblox): --!strict Mode
      A type-checking mode for Luau (Roblox). In Luau, the specialized version of lua for
      Roblox, 'strick' refers to a script-level directive rather than an external file.
      To use it we place the directive: '--!strict' at the very top of our script. Since
      its a bit more complex than 'strict.lua' it has some key features such as

        • Type Inference: It  enforces strict type checking based on initial values or
          explicit annotations
        • Static Analysis: Errors appear in the script editor at design-time rather than
          during gameplay, helping to catch logic bugs early
        • Performance: It does not affect runtime speed; its purpose is solely to improve
          developer experience and code reliability
  )
]]

local declared_names = {}

setmetatable(_G,{
  __newindex = function(t,n,v)
    if not declared_names[n] then
      local w = debug.getinfo(2,'S').what
      if w~='main' and w~='C' then
        error('attempt to write to undeclared variable ' .. n,2)
      end
      declared_names[n] = true
    end
    rawset(t,n,v)  -- do the actual set
  end,

  __index = function(_,n)
    if not declared_names[n] then
      error('attempt to read undeclared variaable '..n,2)
    else
      return nil
    end
  end,
})

