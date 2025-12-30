--[[
Chapter 12 - DATA FILES AND PERSISTENCE
When dealing with data files, its usually much easier to write the data than to
read it back. when we write a file, we have full control of what is going on. But,
when we read a file, on the other hand, we don't know what to expect all the time.
Besides all the kinds of data that a correct file might contain, a robust program
should also be hable to handle bad files gracefully. Therefore, coding robust input
routines is typically difficult.

In this chapter we'll take a look at how we use lua to eliminate the complex code for 
reading data from our programs, simply by writing the data in an appropriate 
format.

12.1 - DATA FILES
So as we saw in an example a couple of chapters ago (10.1), constructors ({}) provide
an interesting alternative for file formats. With a little extra work when writing 
data, reading becomes trivial. The technique is to write our data file as lua code
that, when run, builds the data into the program. With {}s, these chunks can look
remarkably like a plan data file. (I've heard of lua as a data language. In google it
says that Lua was originally designed as a data description language influenced by
SOL (Simple Object Language) and DEL (Data Entry Language). That's why it can be 
used as a configuration language as well)

As usual, let's see an example to make things clearer. If our data file is in a 
predefined format, such as csv or xml, we don't have much of a choice. However,
if we are the ones creating the file for our own use, then we can use {}s as our 
format. In this format, we represent each data record as a lua constructor. so
instead of writing:

  Donald E. Knuth, Literate Programming, CSLI, 1992
  Jon Bentley, More Programming Pearls, Addison-Wesley, 1990

we would write the example below. Remember that Entry{code} is the same as Entry({code}),
which means that we are calling a function named 'Entry' with a table as a single argument.
So, that makes it a lua program. To read that file, we only need to run it, with a
sensible definition for Entry.
]]

local count = 0
function Entry(_) count = count + 1 end
-- that we had to use (_) to tell lua that Entry will have one arg, the {}. But since we
-- don't use it for anything outside of increasing a counter, we use '_'

--[[
dofile('data_file') -- if this was in a separate file
--]]


Entry{
  "Donald E. Knuth",
  "Literature Programming",
  "CSLI",
  1992,
}

Entry{
  "Jon Bentley",
  "More Programming Pearls",
  "Addison-Wesley",
  1990,
}

print('number of entries: ' .. count);print()

--[[
The next chunk collects into a set the  names of all the authors found in the file,
and the prints them (not necessarily in the same order, since 'pairs' is for unordered
series)
]]
local authors = {} -- a lua set to collect authors (just a table using keys for the set)
function Entry(b) authors[b[1]] = true end
-- Note here we are using the {} arg so we name it 'b' (and this also means that the 
-- order of the data must be consistent since we are using b[1] o sea, index 1 for name)
--[[
dofile('data_file') -- again if data is in a different file
--]]
Entry{
  "Donald E. Knuth",
  "Literature Programming",
  "CSLI",
  1992,
}

Entry{
  "Jon Bentley",
  "More Programming Pearls",
  "Addison-Wesley",
  1990,
}
for name in pairs(authors) do print(name) end;print()

--[[
so the b[1] gets our name which is at index 1 of our {}, and makes it a key in authors
setting the value to true.

Note the event-driven approach here: the Entry function acts as a callback function, 
which is called during the dofile for each entry in the data file.

When file size is not a big concern, we can use name-value pairs for our representation.

This is called 'self-describing data' format, since each piece of data is attached
is attached to its description. Self-describing data is more readable (by humans, at
least) than csv or other compact notations (its basically JSON); its easier to edit
by hand, when necessary; and allow us to make small modifications in the basic
format without having to change the data file (since we are working with keys now).
For example, if we wanted to add a new field, we just need to make a small change 
in the reading definition, so that it supplies a default value when the field 
is absent 🤓

With the self-describing format our reading program turns into this:
]]
authors = {} -- let's empty out our authors set {}
-- and our entry function adapted with default authors, if at some point we 
-- didn't have a filed for authors 
function Entry(b)
  -- authors[b.author] = true
  if b.author then authors[b.author] = true end
end

Entry{
  author = "Donald E. Knuth",
  title = "Literature Programming",
  publisher =  "CSLI",
  year = 1992,
}

Entry{
  author = "Jon Bentley",
  title = "More Programming Pearls",
  publisher = "Addison-Wesley",
  year = 1990,
}

-- this would error out with - "table index is nil"
-- if we didn't put the 'if' check in there
Entry{
  title = 'Deep Dive Lua',
  publisher = 'LaDoBlaNco Productions',
  year = 2025,
}

for name in pairs(authors) do print(name) end;print()

--[[
Now the order of the fields is irrelevant, as opposed to before. Even if some entries
don't have an author, we don't have any issues.

Lua not only runs fast, but it also COMPILES FAST. For instance, the above program
for listing authors can process 2mb of data in less than a second. This isn't by
chance. Data description as been one of the main applications of Lua since its 
creation (as we saw in Google) and the lua team takes great care in making its
compiler fast for large data programs.
]]

