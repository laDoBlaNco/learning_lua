--[[
We want to senda postcard my mail. We need a stamp worth n cents. Stamps have values 7 and 4
cents. As space is limited we want to know the minimum number of stamps we need to put on the
postcard, without losing a cent.

Write a function 'stamps(n)' that givecn an integer number n it returns two numbers p>=0 and q>=0
such that n = 7p+4q and p+q is minimum among all possible choices

Combinatory optimization problem

]]

local stamps

stamps = function(n)
  local p = 0
  local q = 0

  -- find the number of q(4) stamps that we need
  while n >= 4 and n % 7 ~= 0 do
    q = q + 1
    n = n - 4
  end

  -- find the remaining number of 7-cent stamps needed
  p = math.floor(n / 7)

  return p,q

  -- if we have a value that is not divisible by 7,
  -- we can always use some combination of 4-cent stamps
  -- to make p the remaining value (since 4 is a smaller
  -- denomination and any positive integer can be represented
  -- as a sume of 4s)
end

print(stamps(20))
print(stamps(31))
print(stamps(53))
print(stamps(127))
