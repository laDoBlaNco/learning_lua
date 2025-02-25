--[[
so what is LOVE?

LÖVE is what we call a 'framework' Simply said: its a tool that makes
programming games easier. Like all the JS frameworks we have floating 
around the world

LÖVE is made with C++ and OpenGL, which are both considered to be very
difficult. The source code for love is very complex, but all this complexity
makes our ability to use lua and create games easier. 

Lua is the programming language the LÖVE uses. lua is a programming lang
on its on, its not made for or by LÖVE, but the creators of love simply
chose lua as the language for their framework. So what part of what we
code is LOVE, and what is lua? Very simple: Everything starting with 'love.'
is part of the LÖVE framework, everything else is plain lua.

How does LOVE work?

LÖVE calls 3 functions. First it calls love.load(). In here we create our
variables. After that it calls love.update() and then love.draw(), in that 
order.

So: love.load -> love.update -> love.draw -> love.update -> love.draw -> love.update -> love.draw etc.

Behind the scenes, Love calls these functions and we create them and fill them with code. This
is what we call a 'callback'

Love is made out of modules, love.graphics, love.audio, love.filesystem, etc. there are about 15
modules and each module focuses on 1 thing. Everything that I will draw is done with love graphics.
And anything with sound is done with love.audio. 

Let's focus on love.graphics. 

Love has a wiki https://www.love2d.org/wiki/love - so if we want to draw something we can go to the 
wiki and read the docs for example 'love.graphics.rectangle' 

The functions that LOVE provides are what we call an API (Application Programming Interface). 

Summary:
Love is a tool that makes it easier for us to make games. Love uses a programming language called 
lua. Everything starting with 'love.' is part of the LOVE framework. The wiki/docs tells us everything
we need to know about how to use LOVE.
]]

function love.draw()
  love.graphics.rectangle('fill',100,200,50,80)
end