--[[
Arrays, Lists, and Sequences

• To represent a conventional array or a list, we simply use a table with integer keys
• There is neither a way nor a need to declare a size, we just initialize the elements
  we need
]]

-- read 5 lines and store in a table
local t = {}
for i=1,5 do
  t[i] = io.read()
end

print()
print(#t) -- this only works if the list doesn't have 'holes'. 
-- For SEQUENCES (no-holes) lua offers the length operator(#)
-- on tables, it gives the length of the SEQUENCE represented by that table 
print(t[2])
-- so formally a sequence is a table where the positive numeric keys comprise a set {1,...n} for some value n.

-- another idiom is a[#a + 1] = p -- appends 'p' to the end of the sequence, but remembering that # is not trustworthy on anything other than sequences.

