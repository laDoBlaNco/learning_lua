
require('example')

--[[

Multiple files

With multiple files our code will look more organized and easier to navigate. Let's start by
creating a new file 'example.lua'

Scope 

Local variables are limited to their scope. in the case of Test, the scope
is the file 'example.lua' This means that test can be used everywhere inside that file, but not in
other files. I did this with some of vars to have them global in a file but not mixing in others. 

If I create a local var in a block, like a function, if-statement or for-loop, then that would be 
the variable's scope

Parameters of functions are just more local variables. Only existing inside the function
To really understand this, let's take a look at the following code below:

]]
-- print(Test)

Test = 10
print(Test)

