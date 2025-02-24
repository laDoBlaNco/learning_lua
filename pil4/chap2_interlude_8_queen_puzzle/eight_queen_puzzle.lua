--[[
In this chapter we make a short interlude to present some 'real-world' lua. Its a
simple but complete program. Its not doing anything specific but presents the
general flavor of lua.

I'll just go through and note anything that doesn't make sense to me and comment
what does
]]

N = 8 --board size. Note its capital letter meaning its a global (convention)

--check whether position (n,c) is free from attacks
local function isplaceok(a, n, c) -- note the convention with big runon names 🤔
    for i = 1, n - 1 do         -- for each queen already placed
        if (a[i] == c) or
            (a[i] - i == c - n) or
            (a[i] + i == c + n) then
            return false
        end
    end
    return true -- no attacks; place is ok
end

-- printa  a board
local function printsolution(a)
    for i = 1, N do    -- do for each row
        for j = 1, N do -- and for each column
            -- write 'X' or '-' plus a space
            io.write(a[i] == j and 'X' or '-', ' ')
        end
        io.write('\n')
    end
    io.write('\n')
end

-- add to board 'a' all queens from 'n' to 'N'
local function addqueen(a, n)
    if n > N then -- all queens have been placed?
        printsolution(a)
    else          -- try to place n-th queen
        for c = 1, N do
            if isplaceok(a, n, c) then
                a[n] = c -- place n-th queen at column 'c'
                addqueen(a, n + 1)
            end
        end
    end
end

-- run the program
addqueen({}, 1)
