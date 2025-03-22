-- splitting_content_into_lines.lua

-- let's say we need to split th file content into individual lines. This is done by
-- iterating over each line using lua's pattern matching. We create an empty table to store
-- the lines and then use a pattern that matches each line ending with a newline char.

-- Now that we have the file split into lines, we'll want to parse each line to extract
-- the individual fields. Since the data is comma-separated, I can use lua's pattern matching
-- again to split each line on commas. I'll then process the header separtely to identify
-- column names and then parse the remaining lines into a structure format.

-- AFter that we'll convert the string data into numbers as it should be for analysis. we'll
-- loop through each record and convert these fields to numeric values where applicable



-- check the return value from io.open for errors
local file = io.open('data.csv', 'r')
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
  table.insert(lines, line)
end

-- print the number of lines read
print()
print('Total lines read:', #lines)
print()

-- function to split a string by a given delimiter
local function split(input, delimiter)
  local result = {}

  for match in (input .. delimiter):gmatch('(.-)' .. delimiter) do
    -- I think we did 'input..delimiter' to make sure our input ends with the delimiter as well
    table.insert(result, match)
  end
  return result
end

-- Now let's use it with Extracting first our headers
local header = split(lines[1], ',')
print('Header Fields:')
for i, field in ipairs(header) do
  print(field)
end

-- parse data lines into a table of records
local data = {}
for i = 2, #lines do
  local fields = split(lines[i], ',')
  local record = {}
  for j, key in ipairs(header) do
    record[key] = fields[j]
  end
  table.insert(data, record)
end

-- print the parsed records
print()
print('Parsed Records:')
for i, record in ipairs(data) do
  print('Record ' .. i .. ':')
  for key, value in pairs(record) do
    print('  ' .. key .. ':', value)
  end
end

print()
for i,record in ipairs(data) do
  -- convert age and score to numbers
  record.age = tonumber(record.age)
  record.score = tonumber(record.score)
end

-- verify conversion by printing records again
print('Records After Type Conversion:')
for i,record in ipairs(data) do
  print('Record ' .. i .. ':')
  for key,value in pairs(record) do
    print('  ' .. key .. ':',value,'(' .. type(value) .. ')')
  end
end

print()

