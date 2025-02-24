print('Hello Lua!')
print()

-- here's a more complex example. Defining a function to compute the factorial
-- of a given number, using user input and printing its factorial
local function fact(n)
    if n <= 0 then
        return 1
    else
        return n * fact(n-1)
    end
end

print('Enter a number: ')
local a = io.read('*n')     -- reads a number
print(fact(a))
