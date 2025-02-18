--[[
    Operating System Library
Used to get a lot of information back from the computer or the device

Here are some of the more common ones I'll be using:
    ▫️ time - returns os current time
    ▫️ date - returns os current data
    ▫️ clock - returns execution time of program
    ▫️ getenv - returns environment information
    ▫️ exit - terminates the program
    ▫️ execute - runs system command
    ▫️ setlocale - set location for program
    ▫️ difftime - returns number of seconds between 2 given times
    ▫️ remove - deletes a file or directory
    ▫️ rename - renames a file or directory

os.time:
    ▫️ primary function - convert a given date/time to seconds (1/1/1970)
    ▫️ when called without arguments, returns the current (os) date and time

os.date:
    ▫️ converts seconds back to date/time (opposite of os.time)
    ▫️ returns table when given an argument and time number value

]]

print('using os.clock and os.time:')
print(os.clock())
local t1 = os.time()
print(t1)

local t2 = os.time({
    year = 1999,
    month = 1,
    day = 1,
    hour = 12,
    min = 10,
    sec = 30,
})
print(t2)
print('Seconds difference: ' .. os.difftime(t1, t2))
print()print()

print('using os.date:')
print(os.date())
local date1 = os.date("*t",t2)
for k,v in pairs(date1) do
    print(k,'=>',v)
end
print()
print(os.date('%A',t2))
print()print()
print('using os.getenv:')
print(os.getenv('HOME'))  -- case sensitive

