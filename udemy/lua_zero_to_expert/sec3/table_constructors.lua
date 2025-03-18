--[[
Table Constructors - 

  • Construcctors are expressions that build and set up tables. They represent a unique aspect
    of lua and are amount its most valuable and flexible mechanism
  • The most basic constructor is the empty constructor, represented by {} as demonstrated
    earlier. Constructors can also initialize lists.
  • Lua also offers special syntax to intialize a record-like table (structure)
  • A record-like structure table in lua refers to a table that is used to represent structured
    data with named fields or attributes 
  • We can also mix record-style with list-style initializations
]]
local days,person

days = {'sunday','monday','tuesday','wednesday','thursday','friday','saturday',}
print()
print(days[6])

person = {
  name='John',
  age=48,
  occupation='Engineer',
}

-- A note about local and Global variables. If it isn't explicitly set to local or global,
-- the default scope is global.
Global_var = 'I am global'

local function my_function()
  -- local variable
  Local_var = 'I am local...not really'

  print(Global_var) --> accessible within the function
  print(Local_var) --> accessible within the function
end

my_function()

print(Global_var) --> accessible globally
print(Local_var) --> accessible globally (since not explicitly set to 'local') 
print()

local polygon = {
  color = 'blue',
  thickness = 3,
  npoints = 4,
  {x=0,y=0}, -- polygon[1]
  {x=-20,y=0}, -- polygon[2]
  {x=-20,y=5}, -- polygon[3]
  {x=0,y=5}, -- polygon[4]
}

print(polygon) --> prints the memory address
print(polygon.color)
print(polygon.npoints)
print(polygon[1].x)
print(polygon[3].y)
print()



