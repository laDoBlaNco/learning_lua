-- role_of_functions.luac
-- Simple calculator using functions
-- define basic arithmetic functions

function add(x, y) return x + y end

function subtract(x, y) return x - y end

function multiply(x, y) return x * y end

function divide(x, y) 
  if y == 0 then
    return 'Error: Division by zero'
  else
    return x / y
  end
end

-- here we have a high-order function to execute an operationr
function calculate(a,b,operation) return operation(a,b) end

-- test the calculator functions
num1 = 20
num2 = 4
print()
print('Addition:',calculate(num1,num2,add))
print('Subtract:',calculate(num1,num2,subtract))
print('Multipy:',calculate(num1,num2,multiply))
print('Divide:',calculate(num1,num2,divide))

-- Functions as first-class values demonstrates how we can structure our code for 
-- maxumum reuse and clarity
