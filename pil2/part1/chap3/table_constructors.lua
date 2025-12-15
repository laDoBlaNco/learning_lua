--[[
3.6 - TABLE CONSTRUCTORS

(I'm going to be typing this out as I really need to understand tables)

Constructors are expressions that create and initialize tables. NOTE, since lua
isn't an OOP language as most consider, the use of the word 'constructor' isn't 
necessarily the same as say a Dart. So from what I can see, 'constructors' are 
exclusively related to tables in lua since that's the main (only) data structure

The are a distinctive FEATURE of lua and one of its most useful versatile mechanisms.

The simplest constructor is the empty constructor, {}, which CREATES AN EMPTY (ANONYMOUS)
TABLE SOMEWHERE IN MEMORY. Constructors also initialize arrays (called also sequences
or lists). 
]]

local days = { "sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday" }

-- lua will initialize days[1] = 'sunday' (1 not 0) and days[2] = 'monday' and so on
print(days[4]) --> wednesday
print()

-- there is also a special syntax to allow me to create table record-like (maps) structure
local a = { x = 10, y = 20 } -- same as a = {}; a.x=10; a.y=20

-- no matter the constructor I use to create a table, I can ALWAYS add fields to and
-- remove from the result
local w = { x = 0, y = 0, label = "console" }
local x = { math.sin(0), math.sin(1), math.sin(2) }

function tbl(t)
	local res = ""
	for k, v in pairs(t) do
		res = res .. "Key: " .. k .. "  " .. "Value: " .. v .. "\n"
	end
	print(res)
end
-- NOTE i didn't have to create one for ipairs  really since all of the  tables are
-- basically associative arrays, either implicitly indexed or explicitly indexed.

tbl(w)
tbl(x)
print()

w[1] = "another field" -- add key 1 to table 'w'
tbl(w)
print()

x.f = w -- here I add key 'f' to table 'x'
-- not printing since I can't concatentate a table to a string, and I'm only
-- printing in my function, not returning anything

-- finally

print(w["x"])
print(w[1])
print(x.f[1])
print()
tbl(w)
w.x = nil -- delete x
tbl(w)
print()

-- In the end, ALL TABLES ARE CREATED EQUAL IN LUA. Constructors affect only their
-- initialization.

-- EVERY TIME LUA EVALUATES A CONSTRUCTOR, IT CREATES AND INITIALIZES A NEW TABLE
-- that's why we can create other structures with tables so easily like linked lists
--[[
local list = nil
for line in io.lines() do
  list = {next=list,value=line}
end
]]

-- I can also mix record style and list-style constuctors to create more complex
-- data structures
local polyline = {
	color = "blue",
	thickness = 2,
	npoints = 4,
	{ x = 0, y = 0 },
	{ x = -10, y = 0 },
	{ x = -10, y = 1 },
	{ x = 0, y = 1 },
}
-- NOTE how the key is automatically assumed to be a variable, o sea I don't have to make
-- it a string and its also not a global variable

print(polyline[2].x)
print(polyline[4].y)
print()

-- I can't initialize fields with negative indices, nor with string indices that aren't
-- proper identifiers. For that I have to use a more general format.
local opnames = { ["+"] = "add", ["-"] = "sub", ["*"] = "mul", ["/"] = "div" }
local i = 20
local s = "-"
local a2 = { [i + 0] = s, [i + 1] = s .. s, [i + 2] = s .. s .. s }
print(opnames[s])
print(a2[22])
print()

--[[
While this is more cumbersome, its also more flexible. Both the list-style and the
record style forms are special cases of this more general syntax. O sea, the constructor
{x=0,y=0} is actually doing {['x']=0,['y']=0} underneath, and {'r','g','b'} is actually
{[1]='r',[2]='g',[3]='b'}

Also trailing commas are optional but always valid

Finally I can also use ';' in constructors. A good way to separate sections of complex
constructors
]]

local a_table = {x=10,y=45;'one','two','three'}
print(a_table[3])

