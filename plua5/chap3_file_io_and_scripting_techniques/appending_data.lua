-- appending data to an existing file without overwriting its contents is done by opening
-- the file in 'a' mode. We will see how this is done and useful for logging or gradually
-- adding data to a file.
file = io.open('output.txt','a')

if file then
  file:write('Appending a new line to the file.\n')
  print('Data appended successfuly to output.txt')
  file:close()
else
  print('Error: Unable to open file for appending.')
end