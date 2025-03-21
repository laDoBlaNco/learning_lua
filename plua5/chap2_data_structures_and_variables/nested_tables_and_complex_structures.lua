-- nested_tables_and_complex_structures.lua

-- we can also get complex with nested tables
people = {
  {name = 'Alex',age = 28},
  {name = 'Jordan',age = 32},
  {name = 'Taylor',age=25},
}
print()
for index,individual in ipairs(people) do
  print('Profile ' .. index .. ":")
  print('\tName:  ' .. individual.name)
end
