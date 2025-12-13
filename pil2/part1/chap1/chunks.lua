-- chunks.lua

-- all valid
a=1
b=a*2

c=1;
d=c*2;

e=1;d=e*2

f=1 g=f*2   -- this is ugly but still valid

----------------------------------------------------------------

-- using dofile with the interpreter
function norm(x,y)
  return (x^2+y^2)^0.5
end

function twice(x)
  return 2*x
end

