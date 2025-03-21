-- tables_as_arrays_and_dicts.lua

fruits = {'apple','banana','cherry','date'}
print()
print("First fruit:",fruits[1])
print('Second fruit:',fruits[2])
print('Third fruit:',fruits[3])
print('Last fruit:',fruits[#fruits])


-- or we can iterate through it with a for loop
print()
for index=1,#fruits do
  print('Fruits at position ' .. index .. ' is ' .. fruits[index])
end


