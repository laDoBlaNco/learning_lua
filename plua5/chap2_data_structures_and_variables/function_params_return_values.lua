-- function_params_return_values.lua

-- define a function to calculate the area of a rectangle
calculateArea = function(length,width)
  return length * width
end

-- invoke the function with same values
area = calculateArea(10,5)
print('Area of rectangle:',area)
