--[[
    Variable Scope

▫️ Global - a variable whose value is avaiable anywhere in the program. If we 
  don't put any keywords in front of the variable, it's global

▫️ Local - a variable that is available only in a localized portion of the
  application. We do this with the 'local' keyword as I've been doing throughout
  these tutorials

  It is smart to make sure everything is local, unless it needs to be global

Its  also apparently convention that global variables start with a capital letter.
]]

Temp = "Hi"
_G.temp2 = 'Hello' -- another way to identify as global is with _G
print(Temp)
print(temp2)
-- there is no difference between these two outside of the declaration syntax
-- both are being assigned to the 'global table' inside the environment. More on that later.

-- it also stands for function names as they are also just variables (global and local)
function _G.test1()
    local temp = 'No longer Hi'
    print(temp)
end
-- localizing functions also keeps them local to the individual files and other scopes
-- otherwise they will be able to be called throughout the program as a global var.

test1()


