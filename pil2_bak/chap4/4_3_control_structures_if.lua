--[[
Lua provides a small and conventional set of control stuctures, with 'if' for conditional
execution and 'while', 'repeat', and 'for' for iteration. All control structures have an 
explicit terminator: 'end' terminates 'if','for' and 'while' structures; and 'until'
terminates 'repeat' structures

The condition expression of a control structure may result in any value. lua treats
as true ALL values that aren't 'false' and 'nil'. (in particular, lua treats both 
'0' and the empty string '' as true, which can be a gotcha)

IF THEN ELSE
An 'if' statement test its conditiona nd excutes its then-part or its else-part accordingly
The else-part is optional
Example syntax:

  if a < 0 then a = 0 end

  if a < b then return a else return b end

  if line > MAXLINES then
    showpage()
    line = 0
  end

To write nested 'ifs' I can use the 'elseif' keyword. It is similar to an 'else' followed by a
'if', bu it avoids the need for multiple 'ends'

Example syntax:

  if op == '+' then
    r = a + b
  elseif op == '=' then
    r = a - b
  elseif op == '*' then
    r = a * b
  elseif op == '/' then
    r = a / b
  else
    error('invalid operation')
  end

  LUA HAS NO SWITCH STATEMENT, so the chains above are very common in the wild.

]]
