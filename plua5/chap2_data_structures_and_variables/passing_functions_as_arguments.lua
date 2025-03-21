-- passing_functions_as_arguments.lua

-- Passing functions as arguments to other functions is particularly useful
-- whne you need to abstract behavior or implement higher-order functions.

-- define a function that appllies a given operation to two numbers
applyOperation = function(a, b, operation)
  return operation(a, b)
end

-- define a couple of operations
add = function(x, y) return x + y end

multiply = function(x, y) return x * y end

-- user the higher-order function with different operations
sum = applyOperation(8,12,add)
product = applyOperation(8,12,multiply)
print()
print('Sum:',sum)
print('Product:',product)
