--[[
10.2 MARKOV CHAIN ALGORITHM

Our second example is an implementation of the Markov chain algorithm. The
program generates random text, based on what words may follow a sequence of
'n' previous words in a base text. for this implementation, we'll assume 2 for
the value of 'n'

The first part of our program reads the base text and builds a table that,
for each prefix of two words, gives a list of the words that follow that
prefix in the text. After building the table, the program uses the table to
generate random text, wherein each word follows two previous words with the 
same probability as in the base text. As a result, we have text that is very,
but not quite, random. For instance, when applied to this book the output of
the program has pieces like:

  "Constructors can also travers a table constructor, then the parenthesis in 
  the following line does the whole file in a field n to store the contents of 
  each function, but to show its only argument. If you want to find the 
  maximum element in an array can return both the maximum value and continues
  showing the prompt and running the code. The following words are reserved 
  and cannot be used to convert between degrees and radians."

We will code each prefix by its two words concatenated with a space in
between:
--]]
--[[
function prefix(w1,w2)
  return w1..' '..w2
end
--]]


--[[
We use the string NOWORD ('\n') to initialize the prefix words and to mark the
end of the text. For instance, for the following text

  the more we try the more we do

the table of following words would be

  { ['\n \n'] = {'the'},
    ['\n the'] = {'more'},
    ['the more'] = {'we','we'},
    ['more we'] = {'try','do'},
    ['we try'] = {'the'},
    ['try the'] = {'more'},
    ['we do'] = {'\n'},
  }
  
The program keeps its table in the variable 'state_tab'. To insert a new word
in a prefix list of this table, we use the following function:
--]]

--[[
  function insert(index,value)
    local list = state_tab[index]
    if list == nil then
      state_tab[index] = {value}
    else
      list[#list+1] = value
    end
  end
--]]


--[[
It first checks whether that prefix already has a list; if not, it creates a new
one with the new value. otherwise, it inserts the new value at the end of the
existing list.

To build the state_tab table, we keep two variables, w1 and w2, with teh last
two words read. For each new word read, we add it to the list associated with
w1-w2 and then update w1 and w2.

After building the table, the program starts to generate a text with MAXGEN
words. First, it re-initializes variables w1 and w2. Then, for each prefix,
it chooses a next word randomly from the list of valid next words, prints this
word, and updats w1 and w2. The following is the full program, so commenting out
the above
--]]

function all_words()
  local line = io.read()    -- current line
  local pos = 1             -- current position in the line
  return function()         -- iterator function
    while line do           -- repeat while there are lines
      local s,e = string.find(line,'%w+',pos)
      if s then             -- found a word?
        pos = e+1           -- update next position
        return string.sub(line,s,e) -- return the word
      else
        line = io.read()            -- word not found; try next line
        pos = 1                     -- restart from first position
      end
    end
    return nil                      -- no more lines; end of traversal
  end
end

function prefix(w1,w2)
  return w1..' '..w2
end

local state_tab = {}

function insert(index,value)
  local list = state_tab[index]
  if list == nil then
    state_tab[index] = {value}
  else
    list[#list+1] = value
  end
end

local N = 2
local MAXGEN = 10000
local NOWORD = '\n'

-- build the table
local w1,w2 = NOWORD,NOWORD
for w in all_words() do
  insert(prefix(w1,w2),w)
  w1=w2;w2=w;
end
insert(prefix(w1,w2),NOWORD)

-- generate text
w1 = NOWORD; w2 = NOWORD    -- reinitialize
for i=1,MAXGEN do
  local list = state_tab[prefix(w1,w2)]
  -- choose a random item from list
  local r = math.random(#list)
  local nextword = list[r]
  if nextword == NOWORD then return end
  io.write(nextword,' ')
  w1 = w2; w2 = nextword
end