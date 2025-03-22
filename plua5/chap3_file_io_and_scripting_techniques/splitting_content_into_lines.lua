-- splitting_content_into_lines.lua

-- let's say we need to split th file content into individual lines. This is done by
-- iterating over each line using lua's pattern matching. We create an empty table to store
-- the lines and then use a pattern that matches each line ending with a newline char.

-- check the return value from io.open for errors
local file = io.open('data.csv','r')
if not file then
  error('Failed to open file "data.csv"')
end

-- read all lines from the file.
local fileContent = file:read('*all')
file:close()

print()
print('File contents:\n' .. fileContent)

local lines = {}
for line in fileContent:gmatch('[^\r\n]+') do
  table.insert(lines,line)
end

-- print the number of lines read
print()
print('Total lines read:',#lines)
print()
