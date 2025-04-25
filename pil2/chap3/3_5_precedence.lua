--[[
Operator precedence in lua follows the following table, from higher to lower:

  ▪ ^
  ▪ not # -(unary)
  ▪ * / %
  ▪ + -
  ▪ .. 
  ▪ < > <= >= ~= ==
  ▪  and
  ▪  or

All binary operators are left ossociative, except for ^ 9xponentiation) and '..' (concatentation),
which are right associative. Therefore, the following expressions on the left are equivalent 
to those on the right
    a+i < b/2+1         <-->        (a+i) < ((b/2)+1)
    5+x^2*8             <-->        5+((x^2)*8)
    a < y and y <= z    <-->        (a < y) and (y <= z)
    -x^2                <-->        -(x^2)
    x^y^z               <-->        x^(y^z)

When in doubt, I should always use explicit ()s. It is easier than looking it up in the 
manual, and I'll probably have the same doubt when I read the code again later
]]

