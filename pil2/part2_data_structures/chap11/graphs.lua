--[[
11.7 - GRAPHS

Like any reasonable lanugage, lua allows multiple implementations for graphs,
each one better adapted to some particular algorithms. Here we see a simple
OOP implementation, where we represent nodes as objects (actually tables, of course)
and arcs as references between nodes. 

We'll represent each node as a table with two fields: name, with the node's name;
and adj, the set of nodes adjacent to this one. Since we will read the graph
from a text file, we also need a way to find a node given its name. So we'll 
use an extra table mapping names to nodes. Given a name, function name2node 
returns the corresponding node:
]]

--[[
first we have a function that builds a graphs. 

  - It reads a file where each line ha two node names, meaning that there 
    is an arc from the first node to the second. 
  - For each line, it uses a string.match to split the line into two names, 
  - finds the nodes corresponding to these names (creating the nodes if needed), 
  - and connecting the nodes.
 
In addition for a quick reference I looked up in google (which just references mt to 
secion 20.2 of this same book 😀🤓) a list of all character classes in lua lpeg

  An uppercase version of any of these classes represents the complement of the class
  for example, '%A' would be all NON-LETTER characters
  - . all characters
  - %a letters
  - %c control characters 🤔? - a non-printable command in computing that tells a device
    or software to perform an action, like moving to a new line (LF/Line Feed or CR)
  - %d digits
  - %l lowercase letters
  - %p punctuation characters
  - %s space characters
  - $u uppercase letters
  - %w alphanumeric characters
  - %x hexadecimal digits
  - %z the character with representation 0
]]

local function name2node(graph,name)
  if not graph[name] then
    -- node doesn't exist; create a new one
    graph[name] = {name=name,adj={}}
  end
  return graph[name]
end

function readgraph()
  local graph = {}
  for line in io.lines() do
    --split line in two names
    local namefrom,nameto = string.match(line,'(%S+)%s+(%S+)')
    -- find corresponding nodes
    local from = name2node(graph,namefrom)
    local to = name2node(graph,nameto)
    -- adds 'to' to the adjacent set of 'from'
    from.adj[to] = true
  end
  return graph
end



--[[
Then we need an algorithm using such graphs. The function findpath searches for a 
path between two nodes using a depth-first traversal. Its first parameter is the 
current node; the second is its goal; the third keeps the path from the origin to
the current node; the last parameter is a set with all the nodes alredy visited
(to avoid loops). Note how the algorithm manipulates nodes directly, without using
their names. For example, visited is a set of nodes, not of node names. Similarly,
path is a list of nodes
]]
function findpath(curr,to,path,visited)
  -- make some defaults for the last two args, so curr and to are obligated, path and visited
  -- not so much
  path = path or {}
  visited = visited or {}
  if visited[curr] then -- node already visited?
    return nil          -- no path here
  end
  visited[curr] = true  -- mark node as visited using our "lua sets" 
  path[#path+1] = curr  -- add it to the path
  if curr==to then      -- final node?
    return path
  end
  -- try all adjacent nodes
  for node in pairs(curr.adj) do
    local p = findpath(node,to,path,visited)
    if p then return p end
  end
  path[#path]=nil       -- remove node from path
end

-- NOTE I need to understand better the relationship between global and local 
-- vars, when functions are using each other or recursive

-- to test the code, we add a function to print a path and some code to put
-- it all to work:
function printpath(path)
  for i=1,#path do
    print(path[i].name)
  end
end

g = readgraph()
a = name2node(g,'a')
b = name2node(g,'b')
p = findpath(a,b)
if p then printpath(p) end



