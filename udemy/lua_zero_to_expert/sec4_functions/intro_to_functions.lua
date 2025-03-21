--[[
What is a function?

In programming, a function is a named block of code that performs a specific task
or operation.

Think of a function as a mini-program within the larger program. Just like I can break
down a complex problem into smaller sub-problems, functions allow me to break down the
solution into smaller managaable pieces or solutions.

▪️ Functions are the main mechanism for abstraction of statements and expression in lua
▪️ The can both carry out a specific task or compute and return values. In the first case
    we use a function call as a statement; in the second case we use it as an expression
▪️ In lua functions are considered 'first-class citizens', meaning they can be assigned
   to variables, passed as arguments, stored in tables, and treated like any other data
   type.
▪️ Call Functions - A list of arguments enclosed in ()s denotes a call; if the call has no arguments
    we still must write an empty list () to denote it. There is a special case to this rule
    if the function has one single argument and that argument is either a literal string or a
    table constructor, then the ()s are optional.

]]

print(5 * 6, 6 / 5)
local a = math.sin(2) + math.cos(10)
print(os.date())

print()

print 'Lost Island' --> print('Lost Island')

-- a function definition in lua has conventional syntax, though its just sugar on what is really happening.
-- all functions are actually anony functions.
local function calculate_sum(seq) -- this is actually 'local calculate_sum = function(seq) ... end'
  local sum = 0
  for i = 1, #seq do
    sum = sum + seq[i]
  end
  return sum
end
print(calculate_sum({ 1, 2, 3, 4, 5 }))

print()

local f = function(x, y)
  print(x, y)
end

-- f(1,2,3,4,5) -- the extra get discarded
f(1, 2)
f(3)
f()
print()

function maximum(s)
  local max_index = 1 -- initial case
  local m = s[max_index]
  for i = 2, #s do
    if s[i] > m then
      m = s[i]
      max_index = i
    end
  end
  return m, max_index -- return max and its index
end

print(maximum({ 6, 58, 96, 69, 77, 32, 695, 69 }))
print()

function f1() end

function f2() return 'a' end

function f3() return 'a', 'b' end

x, y = f3()
print(x)
print(y)

x = f3()
print(x)

print()
x, y, z = 10, f3()
print(x, y, z)
print()

x, y = f1()
print(x, y)
