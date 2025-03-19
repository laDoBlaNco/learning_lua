-- syntax_exmaple.lua
-- define variables of different data types

name = 'Lua Learner'        -- string
year_started = 2009         -- number
current_year = 2025         -- number
active = true               -- bool

-- calculate the number of years of experience
experience = current_year - year_started

-- create a personalized message using string concatentation and arithmetic NOTE: concat oerator .. 
message = 'Hello, ' .. name .. '! You have been learning Lua (off and on) for ' .. experience .. ' years.'
print()
print(message)