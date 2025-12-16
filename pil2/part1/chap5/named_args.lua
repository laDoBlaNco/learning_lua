--[[
5.3 - NAMED ARGUMENTS

Named args are useful when you don't want or can't remember the order of the 
positional args. LUA DOESN'T HAVE DIRECT SUPPORT FOR THIS 🤯, but we can get the same
result as other languages with a small syntax change.

We 'pack' all the args in a table and use that table as the only arg to the function.
The special syntax that lua provides for function calls, with just one table constructor
as argument (optional ()s) helps the trick:

invalid - rename(old='temp.lua', new='temp1.lua') - no support for this
valid - rename{old='temp.lua', new='temp1.lua'}

Then in 'rename' we would refer to those args as arg.old and arg.new, so it doesn't 
matter the order. the one 'arg' (table) is what we are using in the function

This style of parameter passing is very helpful when the function has many parameters,
and most of them are optional. for Example:

  w = Window{x=0,y=0,width=300,height=200,title='Lua',background='blue',border=true}

the function now as the freedom to check for the mandatory args, add default values, 
or whatever else.
]]
--[[
function Window(options)
	-- check for mandatory options
	if type(options.title) ~= "string" then -- cuz if it was missing type would be nil
		error("no title")
	elseif type(options.width) ~= "number" then
		error("no width")
	elseif type(options.height) ~= "number" then
		error("no height")
	end

	-- everything else is optional
	-- then we run the actual hidden function like so??? 🤔🤔🤔
	_Window(
		otions.title,
		options.x or 0,  -- default value
		options.y or 0,  -- default value
		options.width,
		options.height,
		options.background or "white",  -- default value
		options.border  -- default is already false with nil
	)
end
]]


