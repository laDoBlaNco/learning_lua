-- using_tables_as_dictionaries.lua

-- see the following example where we use a table to represent a person's profile
person = {
  name = 'Alex',
  age = 48,
  occupation = 'Lua Hacker',
}

print()
print('Name:', person.name)
print('Age:', person.age)
print('Occupation:', person['occupation'])

-- you can also add, modify, and remove elements dynamically from tables
person.email = 'alex@example.com'
print('Email:', person.email)
person.age = 52
print('Updated Age:', person.age)
person.occupation = nil
print('Removed Occupation:', person.occupation)


-- Iterating over tables
-- For array we mainly use the numeric for loop, but when dealing with dictionaries or associative
-- arrays we typically use a generic loop like pairs, or next
print()
for key, value in pairs(person) do
  print(key .. ':', value)
end
print()
for key, value in next,person do
  print(key .. ':', value)
end

-- interstingly it didn't print occupation since we removed it??? 🤔🤔🤔
