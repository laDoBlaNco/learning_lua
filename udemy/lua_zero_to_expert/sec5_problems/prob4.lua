-- prob4.lua
--[[
Write a function relatedsum(n) that given a natural number n returns the sum of digits
in the first and in the second half of n. The function must also indicate the order
relationship among those quantities. Assume that the input number n always has an
even amount of digits
]]

local related_sum = function(n)
  local numStr = tostring(n)
  local len = #numStr
  local halfLen = len / 2

  local sumFirstHalf = 0
  local sumSecondHalf = 0

  -- calculate sum of digits in the first half
  for i = 1, halfLen do sumFirstHalf = sumFirstHalf + tonumber(numStr:sub(i, i)) end

  -- calculate sum of digits in the second half
  for i = 1+halfLen, #numStr do sumSecondHalf = sumSecondHalf + tonumber(numStr:sub(i, i)) end

  if sumFirstHalf < sumSecondHalf then
    return sumFirstHalf .. ' < ' .. sumSecondHalf
  elseif sumFirstHalf > sumSecondHalf then
    return sumFirstHalf .. ' > ' .. sumSecondHalf
  else
    return sumFirstHalf .. ' = ' .. sumSecondHalf
  end
end

print(related_sum(78))
print(related_sum(9787))
print(related_sum(70724444))
