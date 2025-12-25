---@diagnostic disable: redundant-value, unbalanced-assignments
--[[
Chapter 4 - STATEMENTS

4.1 - Assignments

]]

-- lua allows multiple assignment
local a,b = 10,2
print(a,b)
print()

-- since evaluation of all values is before assignment, I can use multiple assignment
-- for swapping values
local x,y = 9,6
print(x,y)
x,y=y,x
print(x,y)
print()

-- number of values always adjusted to number of variables. If there aren't enough values
-- the variables are nil, if there are too many values, the extras are thrown away
local d,e,f = 0,1
print(d,e,f)

local g,h = d+1,e+1,e+2
print(g,h)

local i,j,k = 0 -- this means we to assign all to 0, I must use '= 0,0,0'
print(i,j,k)

-- in practice this will only be used for functions that return multiple values


