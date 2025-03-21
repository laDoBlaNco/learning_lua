-- The generic for loop traverses all values returned by an iterator function 'next'
-- in lua an iterator function is typically a closure like the following:
--[[

function iterator(collection)
  -- initialization code

  -- iterator function returns the NEXT value during each iteration
  return function() -- returning an anony function
  
  -- Logic to generate and return the next value goes here, incrementing the index
  -- and checking the termination conditions 

  -- stop iteration when there are no more values
  end
end

]]

--[[

Closure is when a function references varibles outside of its scope and retains access to those
variabls and that context even if the outerscope has ended and no longer active. 

function outerFunction(x)
  return function()
    print(x) -- x is from the outerFunction
  end
end

local innerFunction = outerFunction(42)
innerFunction() -- will print 42 even though the outerFunction is no longer running

]]

-- The gener For is very powerful --> we can traverse almost anything in a readable fashion
-- not just sequences. Even works with tables with holes

-- Unlike the numerical For, the generic for can have multiple variables, usually two (index or key and value)

function genericFor(s)
  -- iterate over the collection using the generic 'for' loop
  for item,i in myIterator(s) do -- this myIterator is the same as an ipairs or pairs or next
    print(i,item)
  end
end

function myIterator(s)
  local index = 0
  local length = #s

  return function()
    index = index + 1
    if index <= length then return s[index],index end -- here our iterator now returns 2 things
  end
end

local t = {'apple','banana','pear','orange','pineapple'}
genericFor(t)

