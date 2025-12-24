--[[
9.4 - NON-PREEMPTIVE MULTITHREADING

As we saw earlier, in our little deep dive into lua multithreading, coroutines allow
a kind of collaborative multithreading. Each coroutine is equivalent to a thread. A
pair (yield-consume) switches control from one thread to another (the connection of the 
tubes). However, unlike regular multithreading, coroutines are non preemptive. 

  - According to google - Non-preemptive means a process, once given the CPU, keeps
    it (driver's seat) until it finishes or it itself voluntarily gives it up (e.g.,
    for I/O), without the OS forcibly interrupting or switching it out for another
    task, even a higher-priority one.

    It's rigid, simpler, but can lead to long waits for other processes if a long job
    runs, unlike preemptive methods that allow for timely interruptions for better
    responsiveness.

While a coroutine is running, it can't be stopped from the outside. It suspends
execution only when it explicitly requests so (thorugh a call to yield) (so google
was right). For several applications this is not a problem, quite the opposite. 
Programming is much easier in the absence of preemption. We don't need to be
paranoid about synchronization bugs, since all synchronization among threads
is explicit in the program. We just need to ensure that a coroutine yields
only when it is outside of a critical region.

However, an issue with non-preemptive multithreading,is that whenever any thread 
calls a blocking operation, the WHOLE program blocks until the operation completes. 
For most applications, this is an unacceptable behavior, which leads many 
programmers to disregard coroutines as a real alternative to conventional
multithreading. But, as we will soon see here, this problem has an interesting,
(and actually obvious, with hindsight) solution.

So let's assume a typical multithreading situation: we want to download several 
remote files through HTTP. Now of course, to download SEVERAL remote files, we 
must know how to download ONE remote file. In this example, we will use the 
'luasocket' library, developed by Diego Nehab. To download a file, we must:

  - open a connection to its site
  - send a request to the file
  - receive the file (in blocks),
  - and close the connection

In lua, we can write this task as follows. First we load the 'luasocket' library
--]]

--[[
As a quick side note, it too me a while to get socket working because of some things
I need to remember for later. 

  - require 'socket' - doesn't work as it says in the book because we need a
    variable to use as 'socket.connect'
  - local socket = require 'socket' - doesn't work because apparently for using
    libraries we need to have GLOBAL vars and not local
  - socket = require 'socket' - this works
  - socket = require('socket') - this as well
--]]

socket = require 'socket'

--[[
Then, we define the host and the file we want to download. In this example, we'll
download the HTML3.2 Reference specification from the World Wide Web Consortium
site:
--]]
host = 'www.w3.org'
file = '/TR/REC-html32.html'

--[[
Then we open a TCP connection to port 80 (which is the standard port for HTTP
connections) of that site:
--]]
c = assert(socket.connect(host,80))

-- this operation returns a connection object, which we use to the send the
-- file request
c:send('GET ' .. file .. ' HTTP/1.1\r\n' .. 'Host: '.. host .. '\r\n\r\n') -- (note the ':' sugar though I can't remember much)
-- had to add an extra header 'host' but still get a 301 code back

-- next, we read the file in blocks of 1 kb, writing each block to stdout
while true do
  local s, status,partial = c:receive(2^10) -- 2^10 = 1024. Not sure why he didn't just
  -- put (1024) 🤔
  io.write(s or partial)
  if status == 'closed' then break end
end

--[[
OK, I'm coming back to this later as I can't get luasockets working for the example,
but I don't need it really just yet for what I'm doing. So once I become a master of
lua, I'll come back and fix this 🤓🤓🤓🤓🤓
--]]


