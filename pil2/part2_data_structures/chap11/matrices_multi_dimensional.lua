--[[
11.2 - MATRICES AND MULTI-DIMENSIONAL ARRAYS

There are two main ways to represent matrices in lua. The first one is to use
an array of arrays, that is, a tble wherein each element is another table.
For example, we can create a matrix of zeros with dimensions n by m with
the following code:
--]]
m,n = 10,10
mt = {}     -- create the matrix
for i=1,n do
  mt[i] = {} -- create a new row
  for j=1,m do
    mt[i][j] = 0
  end
end

--[[
since tables are objects in lua, we have to create each row explicitly to create
a matrix. One the one hand, this is certain more verbose than simply declaring
a matrics as we do in C. But on the other hand, it gives us more flexibilty. For
instance, we can create a triangular matrix changing the loop 'for j=1,m do...end'
in the previous example to 'for j=1,i do ... end'. With this code, the triangular
matrix uses only half the memory of the original one.

The second way to represent a matrix in lua is by composing the two indices into
a single one. if the two indices are integers, we can multiply the first one by
a suitable constant and then add the second index. With this approach, the following
code would create our matrix of zeros with dimensions n by m:
--]]
mt = {}   -- create the matrix
for i=1,n do
  for j=1,m do
    mt[(i-1)*m + j] = 0
  end
end

--[[
If the indices are strings, we can create a single index concatenting both indices
witha character in between to separate them. For instance, we can index a matrix m
with string indices s and t with the code m[s..':'..t], provided that both s and t
do not contiain colons; otherwise, pairs like ('a:','b') or ('a',':b') would 
collapse into a single index 'a::b'. when in doubt, we can use a control character
like '\0' to separate the indices

Quite often, applications use a 'sparse matrix', a matrix wherein most elements 
are 0 or nil. For instance , we cna represent a graph by its adjacency matrix,
which has the value x in position m,n when the nodes m and n are connected with
cost x; when those nodes are not connected, the value in position m,n is nil. To
represent  a graph with ten thousand nodes, where each node has about five 
neighbors, we'll need a matrix with a hundred-million entries (a square matrix
with 10000 columns and 10000 rows), but approximately only fifty thousound of
them will not be nil (five non-nil columns for each row, corresponding to the
five neighbors of each node). Many books on data structures discuss at length
how to implement such sparse matrices without wasting 400 mbytes of memory, but 
we don't need those techniques when programming in lua. since arrays are 
represented by tables, they are naturally sparse. With our first representation
(tables of tables), we'll need ten thousand tables, each one with about five
elements, with a grand total of fifty thousand entries. With the second
representation, we'll have a single table, with fifty thousand entries in it.
Whatever the representation, we need space only for the  non-nil elements.

We can't us the lngth operator over sparse matrices either,  because of the holes 
(nil values) between active entries. this is not a big loss; even if we could use 
it, we really shouldn't. for most operations, it would be quite inefficient to 
traverse all those empty entries. Instead, we can use pairs to traverse only the 
non-nil elements. For example, to multiply a row by a constant, we do the following:
--]]
function mult(a,row_index,k)
  local row = a[row_index]
  for i,v in pairs(row) do
    row[i] = v*k
  end
end

--[[
We should be aware, however, that keys have no intrinsic order in table, so the 
iteration with pairs doesn't ensure that we visit the columns in increasing
order. For some tasks (like our previous example), this doesn't matter. For
other tasks, we may need an alternative approach, such as LINKED LISTS:
--]]



