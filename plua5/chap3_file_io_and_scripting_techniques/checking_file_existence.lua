-- one of the most common errors in file i/o is failing to open a file. 
local file,err = io.open('data.csv','r')
if not file then
  print('Error opening file "data.csv":',err)
  -- implement fallback: provide a default value or log the error
  -- you might exit the function or return from the script safely
  return
end

-- this function returns both a file handle and an error message if the file can't 
-- be opened. if the file is nil, then we print the error message and take necessary
-- actions. Thsi approach prevents our script from continuing with invalid file operations
-- and causing further issues. 