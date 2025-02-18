--[[

Global Variables:

Global variables don't need declarations. I simply use them. It is not an error
to access a non-initialized variable. I'll just get its value which is 'nil'

lua doesn't see any differnce in a var that I set to nil and one that simply isn't
initialized. After the assignment lua can eventually reclaim the memory regardless.

Its wise not to use global variables unless I have a very good reason to do so. Apparently
the convention is to make them capitalized, otherwise, set the var to local


]]