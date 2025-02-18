--[[
    Metamethods 2
▫️ a function that has been attached or associated with a table
  to handle specific operations

OPERATOR        METAMETHOD SIG          DESCRIPTION
+               __add(a,b)              Called when a value is added to the parent table using the + operator
-               __sub(a,b)              Called when a value is subtracted from the parent table using the - operator
*               __mul(a,b)              Called when the parent table is multiplied by a value using the * operator
/               __div(a,b)              Called when the parent is divided by a value using the / operator
%               __mod(a,b)              Called when a value is used as a modulus of teh parent table using the % operator
^               __pow(a,b)              Called when the parent table is raised to the power of a value using the ^ operator
-               __unm(a)                Called when the parent table is used with the unary operator
..              __concat(a,b)           Called when a value is concatenated to the parent table with the .. operator
#               __len(a)                Called when the length of the parent table is queried with the # operator
==              __eq(a,b)               Called when the parent table is compared with a table ALSO registered with the same metamethod
<               __lt(a,b)               Called when the parent table is compared to a vlaue using < operator
>               __gt(a,b)               Called when the parent table is compared to a vlaue using > operator
<=              __le(a,b)               Called when the parent table is compared to a value using the <= operator
>=              __ge(a,b)               Called when the parent table is compared to a value using the >= operator

These are added automatcally to any other primitive value  or var we create. With metamethods we do this explicitly for the tables
we create.
]]

-- first we create our matrix (2 dimensional table)
local myTable1 = {}
local myTable2 = {}

for i=1,5 do
    myTable1[i] = {}
    myTable2[i] = {}
    for j=1,4 do
        myTable1[i][j] = math.random(10)
        myTable2[i][j] = math.random(10)
    end
end

for i=1,5 do
    for j=1,4 do
        print(i,j,myTable1[i][j])
    end
end

-- Now we need to create and set our metamethod for __add
-- first our metamethod
local function matrix_add(t1,t2) -- receive two tables and add them using matrix addition. tables are assumed to be the same size
    local newTable = {}
    for i=1,#t1 do
        newTable[i] = {}
        for j=1,#t1[i] do
            newTable[i][j] = t1[i][j] + t2[i][j]
        end
    end
    return newTable
end
print()print()

-- now we create out metatable setting our __add to our metamethod
local metaTable = {__add = matrix_add}

setmetatable(myTable1,metaTable) -- setting our metaTable to a parent table
local myNewTable =myTable2 + myTable1 -- order doesn't matter. As long as at least one of the tables is associated with our metaTable
-- lua will know what we want to do 
print('Our Matrix Addition:')
for i=1,5 do
    for j=1,4 do
        print(i,j,myTable1[i][j] .. ' + ' .. myTable2[i][j] .. ' = ' .. myNewTable[i][j])
    end
end


