--[[
1.1 Run the factorial example. What happens to the program if I enter a neg number?
    ▫️ we get a stack overflow. 
    ▫️ Fix it: I changed it to if n <= 0 return 1

1.2 Run the twice example, both by loading with -l and with dofile. Which is better?
    ▫️ As of right now, no preference, but I did note a couple of thinks about the use
        ▫️ with lua -l, I don't use the ext. 
        ▫️ also with both if I have the vars as 'local' in the script they can't be used
          as globals in the interpreter 
1.3 What other languages use '--' for comments. 
    ▫️ I'm guessing its pascal. 
    ▫️  There are a number of them, euphoria, haskell, sql, ada, applscript, eiffel, elm, etc

1.4 Which if the following are valid identifiers:
    ▫️ ____ -->valid
    ▫️ _end -->valid
    ▫️ End -->valid
    ▫️ end --> not valid its a keyword
    ▫️ until? --> not valid 'until' is a keyword
    ▫️ nil --> nil is a keyword
    ▫️ NULL --> valid
    ▫️ one-step --> '-' isn't valid in a var 
    Though they are valid, doesn't mean they are smart to use at all

1.5 What is the value of the expression 'type(nil) == nil'
    ▫️ false because the result of nil is a string always and a string isn't == to nil
1.6 How can you check whether a value is a bool without using the function type?
    ▫️ 
1.8 write a simple script that prints its own name without knowing it in advance

]]

print(arg[0])


