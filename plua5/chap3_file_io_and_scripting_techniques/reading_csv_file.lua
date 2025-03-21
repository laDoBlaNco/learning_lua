-- open the csv file in read mode
local file = io.open('data.csv','r')
if not file then
  error('Failed to open file "data.csv".')
end

-- this is exactly like Go 🤔🤔🤔
-- read all lines from the file
local fileContent = file:read('*all')
file:close()

-- print the file content (for debugging purposes)
print('File contents:\n' .. fileContent)

