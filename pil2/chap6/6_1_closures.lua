--[[
6.1 - CLOSURES

when a functio  n is written enclosed in another function, it has full access to local
variables from the enclosing function; this feature is called lexical scoping. Although
this visibility rule may sound obvious, it is not. it is not. Lexical scoping, plus
first-class functions, is a powerful concept in a programming language, but few languages
actually support it.

I'll start with a simple exaample. Suppose I have a list of student names and a table that
associates names to grades; I want to sort the list of names according to their grades
(higher grades first)
]]
names = { 'Peter', 'Paul', 'Mary' }
grades = { Mary = 10, Paul = 7, Peter = 8 }
table.sort(names, function(n1, n2)
  return grades[n1] > grades[n2] -- compare the grades
end)

-- now if I want to create a funtion to this this.

function sortByGrade(names, grades)
  table.sort(names, function(n1, n2)
    return grades[n1] > grades[n2]
  end)
end

--[[
The interesting point in the example is that the anonymous function given to sort, accesses the
parameter 'grades', which is local to the enclosing function 'sortByGrade'. Inside this anonymous
function, 'grades' is neither a global variable nor a local variable, but what I call a non-local var.
(for historical reasons, non-local variables are also call upvalues in lua)

Why is this point so interesting? Because functions are first-class values. consider the following:
]]
function newCounter()
  local i = 0
  return function() -- anonymous function
    i = i + 1
    return i
  end
end

c1 = newCounter()
print(c1())
print(c1())
print()

--[[
In this code, the anonymous function refers to a non-local variable i, to keep its counter.
However, by the time we call the anonymous function, i is already out of scope, because the
function that created this variable (newCounter) has returned. Nevertheless, lua handles this
situation correctly, using the concept of 'closure'. Simply put, a closure is a function plus
all it needs to access non-local variables correctly. If we call newCounter again, it will
create a new local variable i, so we get a new closure, acting over this new variable.
]]

c2 = newCounter()
print(c2())
print(c1())
print(c2())
print()

--[[
so, c1 and c2 are different closures over teh same function, and each acts upon an independent
instantiation of the local variable i.

Technically speaking, what is a value in lua is the closure, not the function. The function itself
is just a prototype for closures. Nevertheless, we continue to use the term 'function' to refer
to a closure whenever there is no possibility of confusion.

Closures provide a valuable tool in many contexts. As we have seen, they are useful as arguments
to higher-order functions such as 'sort' Closures are valueable for functions that build other
functions too like our newCounter example; this mechanism allows lua programs to incorporate
sophisticated programming tecniques from the functional world. Closures are useful for callback
functions, too. A typical example here occurs when you create buttons in a conventional GUI
toolkit, or maybe using many of the lua frameworks and game engines. Each button has a callback
function to be called when the user presses a button; different buttons to do slightly
different things when pressed. For example, a digital calculator needs ten similar buttons,
one for each digit. I can create each of them with a function like the following:
]]

--[[
function digitButton(digit)
  return Button{label=tostring(digit),
    action=function()
      add_to_display(digit)
    end
  }
end
--]]

--[[
In this example above, I'm assuming that Button is a tookit function that creates new buttons;
'label' is the button label; and 'action' is the callback closure to be called when the button
is pressed. The callback can be called a long time after  'digitButton' did its task and after
the local variable 'digit' went out of scope, but it can still access this variable being a
closure.

Closures are valuable also in a quite different context. Because functions are stored in regular
variables as seen previously, I can easily redefine functions in lua, even predefined functions.
This facility is one of the reason why lua is so flexible. Freuently, when I redefine a function
I need the original function in the new implementation. For instance, suppose I want to redefine
the function 'sin' to operate in degrees instead of radians. This new function must convert its
argument and THEN CALL the original 'sin' function to do the real work.:
]]

oldSin = math.sin
math.sin = function(x)
  return oldSin(x * math.pi / 180) -- so we the original function in the form of a closure to
  -- work with our additional requirements
end

-- an even cleaner way for this redefinition would be:

do
  local oldSin = math.sin
  local k = math.pi / 180
  math.sin = function(x)
    return oldSin(x * k)
  end
end

-- here the old version is in a private variable local to the do .. end block. The only to
-- access it is through the new version.

--[[
I can use this same technique to create secure environments, also called 'sandboxes'. Secure
environments are essential when running untrusted code, such as code received through the
internet by a server. For instance, to restrict the files a program can access, we can redefine
the io.open function using closures in a sandbox:
]]

do
  local oldOpen = io.open
  local access_OK = function(filename, mode)
    -- we check access somehow
  end
  io.open = function(filename, mode)
    if access_OK(filename, mode) then
      return oldOpen(filename, mode)
    else
      return nil, 'access denied'
    end
  end
end

--[[
What makes this example nice is that, after thsi redefinition, there is no way for the program
to call the unrestricted 'open' function except thorugh the new, restricted version. It keeps
the insecure version as a private variable of the closure, inaccessible from the outside, because
from this programs point of view, the original doesn't exist anymore. With this technique, I can 
build lua sandboxes in lua itself, with the usual benefits: simplicity and flexibility. Instead
of a one-size-fits-all approach, lua offers me a meta-mechanism, so that I can tailor my
environment for my specific security needs.
]]
