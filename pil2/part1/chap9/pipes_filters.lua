--[[
9.2 - PIPES AND FILTERS

One or the most typical examples of coroutines is the 'producer-consumer' problem.
let's suppose that we have a function that continually produces values (e.g., reading
them from a file) and another function that continually consumes these values (e.g.,
writing them to another file). Typically tehse two function would like like the following
--]]
--[[
function producer()
  while true do
    local x = io.read()  -- produce new value
    send(x)              -- send to consumer
  end
end
--]]

function consumer()
  while true do
    local x = receive()  -- receive from producer
    io.write(x,'\n')     -- consume new value
  end
end

--[[
In this implementation, both the producer and the consumer run forever. It 
would be easy to change them to stop when there is no more data to handle. The
problem with this is how to match 'send' with 'recieve'. It is a typical instance
of the who-has-the-main-loop problem. Both the producer and the consumer are
active, both have their own main loops, and both assume that the other is a
callable service. For this particular, it is easy to change the structure of 
one of the functions, unrolling its loop and making it a passive agent. 
However, this change of structure may be far from easy in other real world
scenarios.

Coroutines provide an ideal tool to match producers and their consumers, since
a resume-yield pair turns upside-down the typical relationship between caller 
and callee. When a coroutine calls yield, ti doesn't enter into a new function;
instead, it returns a pending call (to resume). (I think this means that when I
yield I'm passing or returning the method that the new coroutine will use to 
return the main coroutine to the driver seat 🤔🤔, let's see if I'm right).
Similarly, a call to resume doesn't start a new function, but returns a call
to yield. This property is exactly what we need to match a 'send' with a
'receive' in such a way that each oen acts as if it were master and the other
the slave.  So, 'receive' resumes the producer, so tat it can produce a new
value; and 'send' yields the new value back to the consumer
--]]

--[[
function receive()
  local status,value = coroutine.resume(producer)
  return value
end

function send(x)
  coroutine.yield(x)
end

-- then our producer now needs to be a coroutine to resume, so commented out the first
producer = coroutine.create(function ()
  while true do
    local x = io.read()   -- produce new value
    send(x)
  end
end)

--]]

--[[
So now in this design our program starts by calling the consumer.  When the
consumer needs an item, it resumes the producer, which runs (starts) until it
has an item to give to the consumer, and then sopts until the consumer resumes
it again. Therefore, we have what we call a 'consumer-driven' design. 

We can then extend this with filters, which are tasks that sit between the
producer and the consumer doing some kind of transformation in the data. A
'filter' is a consumer and a producer AT THE SAME TIME, so it resumes a 
producer to get new values and yields the transformed values to a consumer.
As a trivial example, we can add to our previous code a filter that inserts
a line number at the beginning of each line. We'll also create the needed
components, connect them, and start the final consumer.

This could be done with this:

  p = producer()
  f = filter(p)
  consumer(f)

but a better way would be:

  consumer(filter(producer())) 

a more functional method
--]]

-- below is the entire program, so commented out the previous
function receive(prod)
  local status,value = coroutine.resume(prod) -- so prod must be a coroutine
  return value
end

function send(x)
  coroutine.yield(x)
end

function producer()
  return coroutine.create(function()
    while true do
      local x = io.read() -- produce a new value
      send(x)
    end
  end)
end

function filter(prod)
  return coroutine.create(function()
    for line = 1,math.huge do
      local x = receive(prod) -- get the new value
      x = string.format('%5d %s',line,x)
      send(x) -- send it to consumer
    end
  end)
end

function consumer(prod)
  while true do
    local x = receive(prod)  -- get new value
    io.write(x,'\n')         -- consume new value
  end
end

--[[
consumer(filter(producer()))
--]]
--[[
Interesting. So here's my take on it all. First as mentioned when I run the program
its runs forever. It does exactly as it should, but there is no way to stop it without
ctrl-c.

We start our consumer which expects 'prod' (a coroutine), that coroutine comes from
filter which also expects a 'prod' (coroutine), that coroutine comes from producer().
Still no values being passed, just coroutines. I think that's where the connecting 
of the pipes comes into play. We aren't just returning and sending values, but the
actual coroutines or threads are being connected.

producer() starts by creating our initial coroutine (thread) which pulls from io.read().
and then sends its data 'x' to send(x). send(x) yields x. This is what ensures that 
'x' is being passed alone (I think 🤔). Since what's being returned is the actual pipe
(coroutine/thread) 'x' needs to be pushed along the pipe internally, from one coroutine
to another. So producer() creates that first pipe and turns it on to start sending data

Our filter(prod) then gets that pipe and has something to work with. What it returns
though is another pipe (coroutine), so it creates that new extension of our chain of
threads (which is what consumer(prod) is waiting on). Through a for loop it first
receives(prod), not the value, but the original thread or pipe. receive() is what
resumes our original coroutine, checks the status and gets the actual data. It puts
the data in a new local 'x' which which is what we work with in the filter (adding
the line number). Then we send(x) once again which yields or pushes the data 
through our newly returned coroutine (pipe/thread) returned from our filter.

Now consumer(prod), which started everything doesn't create a new coroutine, it simply gets
the coroutine/pipe from filter(prod), and then in a 'while true' loop we once again
'recieve(prod) our pipe/coroutine and check its status and return the actual data value.
This time the value is then put into another local 'x' to be written to stdout instead
of sent/yielded/pushed through another returned coroutine/pipe.

I think I got it, but it is complex, which most pipes, threads, etc are.
--]]

--[[
This reminds of of Unix pipes. After all, coroutines are a kind of (non-preemptive) 
multithreading. While with pipes each task runs in a separate process, with coroutines
each task runs in a separate coroutine. Pipes provide a buffer between the writer 
(producer) and the reader (consumer) so there is some freedom in their relative
speeds. This is imporant in the context of pipes, since the cost of switching between
processes is high. With coroutines, the cost of switching between tasks is much
smaller (roughtly the same as a function call), so the writer and the reader can
run hand in hand 
--]]

