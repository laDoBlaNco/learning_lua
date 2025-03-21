-- prob5.lua

-- Write a function that reads a real number x and a serries of coefficients C0,C1, C2 ... Cn
-- and computers p(x), that is: p(x) = c0x0 + c1x1 + ... cnxn
-- hence the function returns the evaluation of the polynominal p with input x.
-- what is a polynominal??? A polynomial is defined as an expression which is 
-- composed of variables, constants and exponents, that are combined using mathematical 
-- operations such as addition, subtraction, multiplication and division (No division operation 
-- by a variable)

function evaluatePolynominal(x,...)
  local coefficients = {...} -- put all the arbitary args in a list (table)
  local degree = #coefficients-1
  local result = 0

  for i=0,degree do
    result = result + coefficients[i+1]*x^i
  end

  return result
end

print()
print(evaluatePolynominal(2,3,4,5))
print(evaluatePolynominal(3,0,0,10))
print(evaluatePolynominal(-2.5,1,-2,0,5.4))

-- not understanding polynomials but I get whats going on above from a lua perspective.
