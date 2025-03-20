-- write a function that given a positive integer, n, returns the largest prime number smaller
-- than n

-- a Prime number is a natural number greater than 1 that has no positive divisors other than 1 and 
-- itself
-- 2,3,5,7,11,13,17,19,23,29,31,37
local is_prime

local largest_prime_smaller = function(n)
  for i=n-1,2,-1 do
    if is_prime(i) then
      return i
    end
  end
  return nil
end

is_prime = function(num)
  if num < 2 then return false end
  for i=2,math.sqrt(num) do  -- more efficient since we don't have to check numbers over the sqrt root of num
    if num%i==0 then return false end
  end
  return true
end

print(largest_prime_smaller(20))
print(largest_prime_smaller(35))
print(largest_prime_smaller(116))

