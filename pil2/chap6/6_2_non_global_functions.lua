--[[
6.2 NON-GLOBAL-FUNCTIONS:

An obvious consequence of first-class functions is that I can store functions not only in
global variables, but also in table fields and in local variables.

I've already seen several examples of functions in table fields: most lua libraries use this
mechanism (e.g., io.read, math.sin). To create such functions in lua, I only have to put TOGETHER
the regular syntax for functions and for tables:
]]
Lib = {}
Lib.foo = function(x, y) return x + y end
Lib.goo = function(x, y) return x - y end

-- we can also use constructors
Lib2 = {
  foo = function(x, y) return x + y end,
  goo = function(x, y) return x - y end,
}

-- and yet lua has another syntax as well, based on the function declaration syntax sugar
Lib3 = {}
function Lib3.foo(x, y) return x + y end

function Lib3.goo(x, y) return x - y end

--[[
When I store a funtion into a local variable, I get a 'local function', that is, a function that
is restricted to a given scope. such definitions are particulary useful for packages; because
lua handles each chunk as a function, a chunk may declare local functions, which are visible only
inside the chunk. Lexical scoping ensures that other functions in the packgae can use these local
functions so:

  local f = function (<params>)
    <body>
  end

  local g = function (<params>)
    <some code>
    f()  -- 'f' is available here due to lexical scoping
    <some more code>
  end

Lua supports such uses of local functions with that same syntactic sugar form:

  local function f(<params>)
    <body>
  end

There is a subtle point in the definition of recursive local functions. The naive approach
doesn't work here:

  local fact = function(n)
    if n == 0 then return 1
    else return n*fact(n-1)  -- this is buggy
    end
  end

  When lua compiles the call fact(n-1) in the recursion, the local fact is not yet defined 🤔🤔
  Therefore, this expression calls a global fact, not the local one. But why isn't it defined yet
  is the question 🤔🤔🤔. I guess its the fact that its local so its restricted to a certain scope
  To solve this problem, I must first define the local variable and then define the function

]]

local fact
fact = function(n)
  if n == 0 then
    return 1
  else
    return n * fact(n - 1)
  end
end

--[[
now the 'fact' inside the function refers to the local variable. Its alue when the function is 
defined doesn't matter; by the time the function executes, 'fact' already has the right value.

When lua expands its syntactic sugar for local functions, it doesn't use the naive definition.
Instead a definition like

  local function foo(<params>) <body> end

expands to 

  local foo
  foo = function(<params>) <body> end

So I can use the syntax sugar for local recursive functions without worrying

  local function fact(n)
    if n == 0 then return 1
    else return n*fact(n-1)
    end 
  end

Of course this trick doesn't work if I have indirect recursive functions. In such cases,
I must use the  equivalent explicit forward declaration:

  local f,g  -- 'forward' declarations

  function g()
    <some code>  f()  <some more code>
  end

  function f ()
    <some code> g() <some more code>
  end

Beware not to write local function f in the last definition. Otherwise, lua would create a 
fresh local variable f, leaving the original f (the one that g is bound to) undefined
]]
