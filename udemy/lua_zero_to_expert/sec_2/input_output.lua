--[[
Input: we can use 'io.read() function to read input from the user via the standard input stream. This function
       allows us to read a line of text from the user
Output: To display to the user we can use the print() function. If we want to print without a newline, we can
        use io.write()
]]

io.write('Enter you name: ')
local name = io.read()
print('Hello ' .. name .. '!')
