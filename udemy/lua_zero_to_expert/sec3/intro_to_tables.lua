--[[
  Introduction to Tables

▫️ Tables are a fundamental and powerful data structure in lua
▫️ They serve as the primary way to represent arrays, dictionaries, sets, etc in lua
▫️ A table is an assoc. array that accepts not only numbers as indices, but also strings or
   any other value of the language (EXCEPT NIL)
▫️ Tables in lua are neither values nor variables -> they are objects

]]

local t = {}
t[1] = 10 --> 1-indexing language
t[2] = 3
print(#t)
t[3] = 9
print(#t)

local exam = {}
exam['john'] = 9
exam['chris'] = 7.7
print()
print(exam['john'])
print(exam.john)
print()
local k = 'x'
local a = {}
a[k] = 50
print(a['x'])

print()
local x = {}
x['discovery'] = 20
local y = x
y['discovery'] = 100
print(y['discovery'])
print(x['discovery'])



