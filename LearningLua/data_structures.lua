--[[
    Learning Lua

Part 12 - Data Structures (tables, arrays, lists, records, queues, & sets)
lua utilizes TABLES to represent all other data structures (simplicity at its best 🤯)
    ▫️ arrays - unlike other languages tables are hetero
        ▫️ customary to start arrays with an index of 1 in lua
        ▫️ values can be assigned as a single expression
        ▫️ local binary = {1,2,4,18,16,32,64,128,256}
        ▫️ tables can also store multi-dimensional arrays (matrices)
    ▫️ records (structs)
    ▫️ lists
    ▫️ queues
    ▫️ sets

Table library (main tools I'll be using)
▫️ # = returns size of the array (number of elements in table) (this assumes I'm following the 1-indexing in lua)
▫️ table.insert - inserts an element in a given position
▫️ table.remove - removes an element from a given position
▫️ table.sort - sorts a table 

]]

local number = {} -- initializes an empty table or 'array'
for i = 1, 10 do
    number[i] = 0
    print(i, '-->', number[i])
end
print("The table information:")
print(number)
print() print()

-- multi-dimensional
local matrix = {}
for i=1,10 do
    matrix[i] = {}
    for j=1,10 do
        matrix[i][j] = 0
    end
end

print('Here we see that each index in matrix is another table:')
for i=1,10 do
    print(i,'=>',matrix[i])
end

print() print()

print('table.insert example on a "list":')
local list = {5,7,1,10,12,6}
table.insert(list,2,8) -- (table_name, location_to_insert, value)
for i=1,#list do
    print(i,'=>',list[i])
end
-- and it actually inserts, not overwrites, pusing everything over 
print('table.remove example on a "list":')
table.remove(list,2) -- (table_name, location_to_remove)
for i=1,#list do
    print(i,'=>',list[i])
end
print('table.sort example on our list:')
table.sort(list) -- (table_name) - ther are other optional parameters for customer sorting as well 
for i=1,#list do
    print(i,'=>',list[i])
end

