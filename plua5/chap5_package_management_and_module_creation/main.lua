-- main.lua
-- load the custom calculator module
local calc = require('calculator')

-- use the module's functions
print()
print('Sum:',calc.add(10,5))
print('Difference:',calc.subtract(10,5))
print('Product:',calc.multiply(10,5))
print('Quotient:',calc.divide(10,5))
