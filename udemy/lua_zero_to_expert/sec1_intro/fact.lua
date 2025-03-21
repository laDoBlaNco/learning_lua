--[[ Recursive Factorial --
  n! = n * (n-1)!
]]
local fact

fact = function(n)
  if n == 0 then return 1 end
  return n * fact(n-1)
end

print(fact(0))
print(fact(1))
print(fact(2))
print(fact(3))
print(fact(4))