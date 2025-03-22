-- When an error does occur, it is important to have a fallback strategy that prevents
-- data loss or application failure. We might choose to use a default file, log the error
-- for further review, or provide an alternative operation

local file,err = io.open('data.csv','r')
if not file then
  print('Warning: Could not open "data.csv". Using default data instead.')

  -- fallback: provide a default csv string
  defaultData = 'name,age,score\nDefault,0,0'
  fileContent = defaultData
else
  fileContent = file:read('*all')
  file:close()
end

print('Processed Data:')
print(fileContent)

-- here we see that if 'data.csv' can't be opened then we print the warning and assign a default
-- csv string to continue processing. This ensures tha our application can operate even when the
-- expected file is missing.
