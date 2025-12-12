--[[
5.3 NAMED ARGUMENTS

The parameter possing mechanism in lua is positional: when we call a function, arguments
match parameters by their positions. The first argument gives the value to the first parameter,
and so on. Sometimes, however, it is useful to specify the arguments by name. To illustrate this
point, let us consider the function os.rename (from the os library), which renames a file. Quite
often, we forget which name comes first, the new or the old; therefore, we may want to
redefine this function to receive two named arguments:

  -- invalid code
  rename(old='temp.lua', new='temp1.lua')

Lua has no direct support for this syntax, but we can have the same final effect, with a small
syntax change. The idea here is to pack all arguments into a table and use this table as the
only argument to the function. The special syntax that lua provides for function calls, with just
one table constructor as argument, helps the trick

  rename{old='temp.lua', new='temp1.lua'}

Accordingly, we define rename with only one parameter and get the actual arguments from this
parameter
]]

function rename(arg)
  return os.rename(arg.old, arg.new)
end

--[[
This style of parameter passing is especially helpful when the function has many parameters,
and most of them are optional. For example, a funtion that creates a new window in a GUI lib
may hve dozens of arguments, most of them optional, which are best specified by names.

Then the _window function would have the freedom to check for mandatory args, add default values, 
and the like.

]]

--[[
function window(options)
  -- check mandatory options
  if type(options.title) ~= 'string' then
    error('no title')
  elseif type(options.width) ~= 'number' then
    error('no width')
  elseif type(options.height) ~= 'number' then
    error('no height')
  end

  -- everything else is optional -- here we assume a primitive Window function that works
  _window(options.title,
         options.x or 0,
         options.y or 0,
         options.width,options.height,
         options.background or 'white',
         options.border
  )

end

--]]
