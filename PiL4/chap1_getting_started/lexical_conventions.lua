--[[

I should avoid identifiers starting with an underscore followed by one or
more uppercase letters. They are reserved for special uses in lua. I can use a 
single _ for dummy vars as well.

The following words are reserved, so I can't use them as identifiers:

and     break   do      else        elseif
end     false   for     function    goto
if      in      local   nil         not
or      repeat  return  then        true   
until   while

▫️ lua is also case sensitive

]]

-- a common trick used to deactivate and reactivate code is enclosing it as in the
-- example below. 
-- The first line below starts a long comment and the two hyphens in the last line
-- are still inside that comment. When I add the third - it turns it into an ordinary
-- single line comment. And this makes the one below the code as well just a simple
-- single line comment. 

---[[ 

print(10)       -- no action (commented out)

--]]

-- lua doesn't need separators between consecutive statements, but we can use a semi-colon
-- if we want to. Line breaks play NO part in lua syntax. 