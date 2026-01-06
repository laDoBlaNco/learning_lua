--[[
16.5 - THE SINGLE-METHOD  APPROACH

A particular case of the previous approach for OOP occurs when an object has
a single method. In such cases, we don't need to create an interface table; instead
we can simply return the single method as the object representation (basically returning
the actual closure rather than a table of closures). If this sounds a little weird, its
worth remembering what we discussed in section 7.1, where we saw how to construct 
iterator functions that KEEP STATE AS CLOSURES. An iterator that keeps state is
nothing more than a single-method object.

Another interesting case of single-method objects occurs when this single method
is actually a dispatch method that performs different tasks based on a distinguished
argument. A possible implementation for such an object is as follows:
]]

function new_object(value)
  return function(action,v)
    if action == 'get' then return value
    elseif action == 'set' then value = v
    else error('invalid action')
    end
  end
end

-- this is pretty straightforward
d = new_object(0)
print(d('get')) --> 0
d('set',10)
print(d('get')) --> 10
-- d('some other action') --> error: invalid action

--[[
This unconventional implementation for objects is quite effective. The syntax d('set',10)
although peculiar, is only two characters longer than the more conventional d:set(10). 
Each object uses one single closure, which is cheaper than one table. There is no
inheritance, but we have fully privacy; the only way to access an object state is through
its sole method.

Tcl/Tk uses a similar approach for its widgets. The name of a widget in Tk denotes a
function (a widget command) that can perform all kinds of operations over the widget.
]]

