Sample = {} -- module is a table so typically starts with an empty table

function Sample.add(n1, n2)
    return n1 + n2
end

function Sample.hi(name)
    return "hi " .. name
end

function Sample.twofer(v1, v2, v3)
    return v1, v2, v3, (v1 + v2) * v3 --note that I'm returning 4 values from this function 🤯
end

return Sample -- key part of a module is that it must return the table that will be used in the other file.
