--[[
Database Interaction Modules

If i'm going to use lua instead of or with PHP then I need to be able to use  it with dbases as well.
Many times I'll need to link the lua app with a relational database, but that's not as easy as it
sounds. We'll need to use specialized modules to do it, and there's a module call luasql that we'll
use to connect to databases like mysql, postgresql, and sqlite. let's see how we set up that connection
and I'll compare it to how we do it with PHP. Then we'll look at running queries, handling transactions,
and processing results to manage dynamic data effictively. In the end we'll be building data driven apps
in Lua

Connecting to Database:
First we'll need to set up a connection to a mysql database. we'll do that with luasql. I'll need to
get luasql mysql module and create an environment object in the lua script. then using that environment
i can open a connection to the database with the necessary credentials

]]

local luasql = require('luasql.mysql')
local env = luasql.mysql()

-- connect to the database 'lua_practice' with provided credentials
local conn, err = env:connect('lua_practice', 'lua_user', 'luapass', 'localhost', 3306)

if not conn then
  print('Error connecting to the database:', err)
  return
end

print('Connected to the database successfully.')

-- here we created an environment which is just running the luasql.mysql() function and then we
-- attempt to connect with the credentials. Not that this function returns 2 values, a connection or
-- a possible err.

-- now let's create a table called 'users' if it doesn't already exist
local res, err = conn:execute([[
  create table if not exists users(
    id int primary key auto_increment,
    name varchar(100),
    age int
  )
]])
-- NOTE the use of [[ for literal multiline strings]]

if not res then print('Error creating table:', err) end

-- insert sample records intot the users table
conn:execute("insert into users(name,age) values('Alice',25)")
conn:execute("insert into users(name,age) values('Bob',30)")

-- then we begin the transaction
conn:execute('start transactions')

-- update a record inside the transaction
conn:execute('update users set age = age + 1 where name = "Alice"')

-- commit the transaction to save changes
conn:execute('commit')

-- above we created basic tables and inserted data. We also did a transaction which allows us to 'rollback'
-- if needed, as well as commit. transactions also make sure that multiple operations are all done as
-- one unit.

-- Processing Query Results
-- Once I execute a select query, I need to process the returned results in lua. luasql returns a
-- 'cursor' that I can iterate over to fetch each row as lua table. This is the same as what I do in php.
-- Let's print all the users records
local cur, err = conn:execute('select id,name,age from users')
if not cur then
  print('Error executing query:', err)
  return
end
print('Query Results:')

-- fetch rows one by one using an associative array format. Let's see if its easier than php 🤔
local row = cur:fetch({}, 'a') -- ([table[,modestring]]) retrieves next row of results and copied into
-- the table and the table itself will be returned to our row var. modes are 'n' - numerical indices and
-- 'a' - alphanumerical indices (associative array)???
-- each returned row is a table since it has the  fields and values from our db
while row do
  print('ID: ' .. row.id .. ' | Name: ' .. row.name .. ' | Age: ' .. row.age)
  row = cur:fetch(row, 'a') -- does it replace or add to??? I'm assuming its copied into the table
  -- replacing what's currently there.
end

-- close the cursor after processing the results
cur:close()

-- here I iterated over the result set using a while loop. Each row is printed, demonstrating
-- how I can access fields by their column names which are keys in our associative tables
-- Ths allows me to dynamically process query results, integrate them into my application logic
-- or display them to users. It does seem somehow easier than PHP

-- Once I'm done I need to remember to close the cursor (did above) and the connection and the env
conn:close()
env:close()
print('Database connection was closed.')
