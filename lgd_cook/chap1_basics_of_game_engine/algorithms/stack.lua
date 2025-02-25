--[[
Making a stack

Stack can be defined in the lua language as a closure that always returns a new table.
This table contains two functions defined by keys, push and pop. Both run in constant
time
]]

-- I'm making a local definition but can change it to global if needed to put into a project
local function stack()
  local out = {}
  out.push = function(item)
    out[#out + 1] = item
  end
  out.pop = function()
    if #out > 0 then
      return table.remove(out, #out)
    end
  end
  out.iterator = function()
    return function()
      return out.pop()
    end
  end
  return out
end

-- test it
local s1 = stack()
-- place a few items onto the stack
for _, element in ipairs { 'lorem', 'ipsum', 'dolor', 'sit', 'amet' } do
  s1.push(element)
end

-- the iterator function can then be used to pop and process all elements
for element in s1.iterator() do
  print(element)
end
print()
print()

print('My experimenting:')
print('length after running the iterator which pops everything:', #s1)
print("let's push some stuff on manually with the loop")
s1.push('first')
s1.push('second')
s1.push('third')
s1.push('fourth')
s1.push('fifth')
print('Length after pushing 5 elements onto the stack: ', #s1)
print("Now let me pop off a few items and then check the length:")
print('first pop:', s1.pop())
print('second pop:', s1.pop())
print('third pop:', s1.pop())
print('Length after popping 3 elements onto the stack: ', #s1)


--[[
How this works:

Calling the stack creates a new empty table with three functions, push and pop use the property
of the length operator that returns the integer index of the last element. The iterator function
returns a closure that can be used in a for loop to pop all the elements. The out table contains
integer indices and no holes. Both the functions are excluded from the total length of the out
table.

After calling push teh element is appended at the end of the out table. The pop function
removes the last element and returns the removed element.

]]
