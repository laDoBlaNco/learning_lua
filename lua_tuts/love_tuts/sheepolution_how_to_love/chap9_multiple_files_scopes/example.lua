-- if true then
--   local Test = 20
-- end

-- print(Test)

local Test = 20

function Some_function(Test)
  if true then
    local Test = 40
    print(Test)
    -- output 40
  end
  print(Test)
  -- output 30
end

Some_function(30)

print(Test)
-- output 20
return Test