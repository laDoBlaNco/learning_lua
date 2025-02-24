-- Operator precedence in lua follows the table below from high to low priority:
--[[
    ^
    unary operators - # ~ not
    * / // %
    + -
    .. (concatenation)
    << >> (bitwise shifts)
    & (bitwise AND)
    ~ (bitwise exclusive OR)
    | (bitwise OR)
    < > <= >= ~= ==
    and
    or

All binary operators are left associative, except for exonentation and concatentation, which are
right associative. 
]]