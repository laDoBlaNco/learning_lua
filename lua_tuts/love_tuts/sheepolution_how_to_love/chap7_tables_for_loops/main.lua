--[[
Chapter 7 - Tables and for-loops

Tables are basically (very generally speaking) lists in which we store values. They are actually
the workhorse and only data structure in lua. Associative lists/arrays that allow us to do almost
anything we want to very simply.

We create them with {}

for-loops:
A for-loop is a way to repeat a piece of code a certain amount of times.

editing tables
We can first use #Fruits which will get us the length of our table. The length of the table refers
to

ipairs:
Using ipairs we don't have to get the length of our table. lua will put an index on each element
and iterate through them

]]

function love.load()
  Fruits = { 'apple', 'banana' }
  table.insert(Fruits, 'pear')
  table.insert(Fruits, 'pineapple')
  table.remove(Fruits, 2)
  Fruits[1] = 'tomato'
end

function love.update(dt)
end

function love.draw()
  -- arguments (text, x-position, y-position)
  -- love.graphics.print(Fruits[1], 100, 100)
  -- love.graphics.print(Fruits[2], 100, 200)
  -- love.graphics.print(Fruits[3], 100, 300)
  -- for i = 1, #Fruits do
  --   love.graphics.print(Fruits[i], 100, 100 + 50 * i) -- 100 + 50 * i o sea,
  -- end

  -- with ipairs works the same
  for i, v in ipairs(Fruits) do
    love.graphics.print(Fruits[i], 100, 100 + 50 * i)
  end
end

-- Tables are lists in which we can store values. We store these values when creating the table, with
-- table.insert, or with table_name[1] = 'some_value'. We can get the length of the table with the
-- #table_name (# lenght operator). With for-loops we can repeat a piece of code a number of times. 
-- We can also use for-loops to iterate through tables. 
