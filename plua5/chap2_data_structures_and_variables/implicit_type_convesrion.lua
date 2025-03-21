-- implicit_type_conversion.lua

-- implicit conversion error demonstration
numValue = 10
strValue = 'ten'

-- The following line will produce an error due to a type mismatch:
combined = numValue + strValue
print('Combined:',combined) 