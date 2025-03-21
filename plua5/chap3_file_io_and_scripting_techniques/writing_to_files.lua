-- Writing data to files is another critical operation that I need to master using luas
-- file i/0 lib. To write to a file, I typically open it in write  mode ('w') or append mode ('a')

-- in write mode the file is created if it doesn't exist already, and its contents are overwritten
-- if it already exists
file = io.open('output.txt','w')
if file then
  file:write('Hello, Lua! This is a test message written to the file\n')
  file:write('File writing in Lua is simple and effective.\n')
  print('Data written successfully to output.txt.')
  file:close()
else
  print('Error: Unable to open file for writing.')
end

-- again we notice that closing the file is so crucial to ensure that all data is saved
-- properly and resources are freed

