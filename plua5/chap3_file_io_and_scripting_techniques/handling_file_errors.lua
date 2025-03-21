-- while performing file i/0, we will at times encounter situations where a file can't
-- be opened or read. Lua's file handling functions return nil when an error occurs, allowing
-- us to implement error checking as we've seen so far. Incorporating conditional statements
-- to handle such cases gracefully like print a message to the console.

-- this seems similar to Go in thie respect
file,err = io.open('nonexistent.txt','r')
if not file then
  print('Error opening file:',err)
else
  content = file:read('*all')
  print('Content of file: ')
  print(content)
  file:close()
end

-- so it not only returns 'nil' but it also returns the error itself. Like Go it returns two things
-- If we address thsoe messages first then we can manage i/o errors without crashing our program.
-- We need to check return values of io.open before proceeding with an file operations. 