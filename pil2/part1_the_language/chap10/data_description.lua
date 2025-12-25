--[[
Chapter 10 - COMPLETE EXAMPLES

To end this introduction to the language, we'll go through two complete programs that
illustrate different facilities of lua. The first example illustrates the use of lua
as a data description language. The second example is an implementation of the 'Markov
chain algorithm', described in K&Ps The Practice of Programming

10.1 - DATA DESCRIPTIONS

The Lua website keeps a database containing a sample of projects around the world that
use lua. Each entry in the database is represented by a constructor in an auto-documented
way. The interesting thing about this representation is that a file with a sequence of
such entries is in itself a lua program, which performs a sequence of calls to a function 
'entry', using the tables as arguments

The goal is to write a program that shows that data in HTML, so that the data becomes
the web page http://www.lua.org/uses.html. Since there are many projects, the final
page first shows a list of all project titles, and then shows the details of each
project. 

To read data, the program simply gives a proper definition for 'entry', and then
runs the data file as a program (with dofile). Note that we have to traverse all
entries twice, first for the title list, and again for the project descriptions.
A first approach would be to collect all entries in an array. However, there is
a second attractive solution: to run the data file twice, each time with a 
different definition for 'entry'. This is the appraoch we are going to follow
in this next program

First we define an aux function for writing formatted text (which we've already
seen in previous chapters)
--]]
function fwrite(fmt,...)
  return io.write(string.format(fmt,...))
end

-- The write_header function simply writes the page header, which is always the same:
function write_header()
  io.write([[
    <html>
    <head><title>Projects using Lua</title></head>
    <body bgcolor='#ffffff'>
    Here are brief descriptions of some projects around the world that use
    <a href="home.html">Lua</a>.
    <br>
  ]])
end

--[[
The first definition for 'entry' writes each title project as a list item. The
argument 'o' will be the table describing the project:
--]]
function entry1(o)
  count=count+1
  local title = o.title or '(no title)'
  fwrite('<li><a href="#%d">%s</a>\n',count,title)
end

--[[
If o.title is nil (that is, the field was not provided), the functions uses a fixed
string '(no title)'

The second definition of entry writes all useful data about a project. Its a little
more complex since all items are optional. (to avoid conflict with html, which uses
double quotes, we use only single quotes in this program)

The last function closes the page
--]]
function write_tail()
  fwrite('</body></html>\n')
end

--[[
The main program, starts the page, loads the data data file, runs it with the first
definition for 'entry(entry1)' to create the list of titles, then resets the counter
and runs the data file again with the second definition for entry, and finally closes 
the page. 
--]]

function entry2(o)
  count=count+1
  fwrite('<hr>\n<h3>\n')

  local href = o.url and string.format(' href="%s"',o.url) or ''
  local title = o.title or o.org or 'org'
  fwrite('<a name="%d"%s>%s</a>\n',count,href,title)

  if o.title and o.org then
    fwrite('<br>\n<small><em>%s</em></small>',o.org)
  end
  fwrite('\n</h3>\n')

  if o.description then
    fwrite('%s<p>\n',string.gsub(o.description,'\n\n+','<p>\n'))
  end

  if o.email then
    fwrite('Contact: <a href="mailto:%s">%s</a>\n',o.email,o.contact or o.email)
  elseif o.contact then
    fwrite('Contact: %s\n',o.contact)
  end
end

local input_file = 'db.lua'
write_header()

count = 0
f = loadfile(input_file)      -- loads data file

entry = entry1                -- defines 'entry'
fwrite('<ul>\n')
f()                           -- runs data file
fwrite('</ul>\n')

count = 0
entry = entry2                -- redefines 'entry'
f()                           -- runs data file again

write_tail()






