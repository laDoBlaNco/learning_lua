--[[
5 FUNCTIONS

Functions are the main mechanism for abstraction of statements and expressions in lua. Functions
can both carray out a specific task (what is sometimes called a procedure or subroutine in other
languages) or compute and return values. In the first case, we use a function call as a statement
in the second case, we use it as an expression

]]
print(8*9,9/8)
a=math.sin(3) + math.cos(10)
print(os.date())
print()
--[[
In both cases, I write a lis tof arguments enclosed in ()s. If the function call has no 
arguments, I still have to write an empty () to indicate the call, which is completely expected
and normal for other languages. There is a special case thought o this rule: if the function has
only one single argument AND that argument is either a literal string or a table constructor (NOT A TABLE)
then the ()s are optional:
]]

print'Hello Lua World' -- looks like I don't need that space either 😁
print [[a multi-line
message]]
print(type{})
print()
--[[
lua also offers a special syntax for OOP calls, the colon operator. An expression like
o:foo(x) is just another way to write o.foo(o,x), that is, to call o.foo adding o (self) as
the first extra argument. In Chapter 16, I'll see such calls in detail (along with OOP in general)

A lua program can use functions defined both in lua and in C (or in any other language used by
the host application). for instance, all functions from the standard lua library are written in C
But this fact has no relevance to lua programmers: when calling a function, there is no difference
between functions defined in lua and functions defined in C 

As see in other examples, a function definition has a conventional syntax, like here:
]]
function add(a)
  local sum = 0
  for i,v in ipairs(a) do
    sum = sum+v
  end
  return sum
end
print(add{1,2,3,4,5})
print()
--[[
In  this syntax, a function definition has a name (add), a list of parameters, and a body, which is 
a list of statements

Paremeters work exactly as local variables, initialized with the values of the arguments passed
in the function call. I can call a function with a number of arguments different  from its
number of parameters. Lua adjusts the number of args to the number of params, as it does in a
multiple assignment: extra args are thrown away; extra params get 'nil'
]]
function f(a,b) print('a =',a,', b =',b) return a or b end
print(f(3))
print(f(3,4))
print(f(3,4,5))
print()

--[[
Although this behavior can lead to programming errors (easily spotted at run time), ti is also 
useful, expecially for default arguments. For instance, consider the following function, to
increment a global counter:
]]
function incCount(n)
  n = n or 1
  count = count + n
end

--[[
This function has 1 as its default argument; that is the call incCount(), without arguments
increments count by one. When you call incCount(), lua first initializes n with nil; the or
then results in its second operand and, as a result, lua assigns a default 1 to n.
]]


