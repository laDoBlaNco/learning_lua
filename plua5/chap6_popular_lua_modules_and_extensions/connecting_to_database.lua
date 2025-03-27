--[[
Database Interaction Modules

If i'm going to use lua instead of or with PHP then I need to be able to use  it with dbases as well.
Many times I'll need to link the lua app with a relational database, but that's not as easy as it
sounds. We'll need to use specialized modules to do it, and there's a module call luasql that we'll
use to connect to databases like mysql, postgresql, and sqlite. let's see how we set up that connection
and I'll compare it to how we do it with PHP. Then we'll look at running queries, handling transactions,
and processing results to manage dynamic data effictively. In the end we'll be building data driven apps
in Lua

Connecting to Database:
First we'll need to set up a connection to a mysql database. we'll do that with luasql.mysql

]]