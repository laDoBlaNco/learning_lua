-- once a file is open, I can read its contents using methods provided by the file handle
-- such as file:read('*all') or file:read('*line') 
file = io.open('example.txt','r')
if file then
  content = file:read('*all')
  print('File content:')
  print(content)
  file:close()
else
  print('Error: Unable to read the file')
end

-- here we opened the file in 'read' mode then used :read('*all') to capture all the text
-- then we print and CLOSE THE FILE

