-- tables are one of kind incredible powerful tool only in lua. They are similar to other data
-- structures I've seen (or better said tables can mimick all of these data structures)
-- but they are unico
local message = 0
local testScores = {} -- an empty table
-- testScores[1] = 95 -- one way to do this NOTE that lua starts at 1
-- testScores[2] = 87
-- testScores[3] = 98
-- testScores = {95,87,98} -- a second way to do this
table.insert(testScores, 95) -- a third way
table.insert(testScores, 87)
table.insert(testScores, 98)
testScores['hello'] = 99 -- indexes can also be any other type (here its a string)
testScores['there'] = 99

for i, s in ipairs(testScores) do -- SO I JUST REALIZED SOMETHING I DIDN'T NOTICE ABOUT LUA. ipairs and pairs work differently, even WHILE WORKING ON THE SAME TABLE
  message = message + s
  print(message)
end
print()

message = 0
for i,s in pairs(testScores) do -- so ipairs will only work with the values that have numerical indices in the table, while pairs will work with everything.
  message = message + s
  print(message)
end

-- message = testScores[3]


-- print(message)
