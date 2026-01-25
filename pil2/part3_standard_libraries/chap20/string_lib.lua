--[[
Chapter 20 - THE STRING LIBRARY

The power of raw lua to manipulate strings is very limited. A program can create string
literals, concatenate them, and get string lengths. But it can't extract substrings
or examine their contents. The full power to manipulate strings in lua comes from its
string library.

The string library exports its functions as a module (table), called string. In lua
5.1, it also exports its functions as methods of the string type (using the metatable
of that type). Which as we remember can only be done through the C code and is what
what emulates other languages in calling methods on the strings themselves. So
for instance, to make a string uppercase we can write:

  • either string.upper(s)
  • or s:upper() (remembering the difference in '.' and ':' on the metatable index
    this makes perfect sense) (looks like this doesn't work on literals. O sea
    s should be in a variable. 'kevin':len() won't work, but s:len() will)

To avoid unnecessary incompatibilities with lua 5.0, in this book we use the 
module notation, (but I'll probably mix it  to make sure both work equally)

20.1 - BASIC STRING FUNCTIONS

Some functions in the string library are quite simple:
  • string.len(s) or s:len() returns the length of a string
    (good to note that this ':' doesn't work with literals, o sea 
    'string':len() doesn't work. The string must be in a variable:
    str:len() or string.len(str), or even string.len('string'))
  • string.rep(s,n) or s:rep(n) returns the string s repeated n times
  • string.lower(s) or s:lower() returns a copy of s with lowercase letters
  • string.upper(s) or s:upper() returns a copy of s with uppercase letters
    A normal case is to use this to standardize text for something like sorting

      table.sort(t, function(a,b)
        return a:lower() < b:lower()
        -- or string.lower(a) < string.lower(b)
      end)

  • string.sub(s,i,j) or s:sub(i,j) extracts a piece of the string s, from i-th to
    j-th character (inclusive). In lua, we use 1-index normally for tables, etc. For 
    strings this is the same, but we can also use negative indexes for strings while
    we can't for tables (arrays). In a table it'll return nil but for a string we get
    the last, next to the last, next to the next to the last, etc. 
    Remember that strings in lua are immutable, so if we want to modify s we need to
    reassign it to the result.
  • string.char and string.byte convert between characters and their numeric reps
    Interesting behavior here:
      • as we know, literals don't work with ':', so 'a':byte() and 97:char() don't work
      • but string.char(97) and string.byte('a') both work as expected
      • Now the interesting is that string.char('97') also works as '97' is converted
        the number first

        NOTE: coming back to this after a couple months I've also discovered something
        new for me that helps close the gap here. Reaffirming that only strings have
        its metatable connected to the base type, so that ':' works with the  actual
        base string. I thought it didn't work with literals and only varaibles, but
        in actuality we can use it with literals as long as they are in ()s
        So for my examples above I have the correction that:
          • while 'a':byte() doesn't work, ('a'):byte() does
          • so does ('97'):char()
          • 97:char() and (97):char() still don't work as again the metatable is 
            connected to the string type and not number. I'll learn how to modify
            that later if needed.

      • With this in mind we can now use ':' with variables. Not n=97, but n='97' and
        a = 'a'. a:byte() and n:char() (OR NOW '97':char() and ('a'):byte())
      • A behavior I wasn't counting on 🤯🤯🤯, both of these functions take more than
        the single 'self' (char or number). 
          • for string.char(97,98,99...) we can use zero or more ints to string together
            words. string.char(97,98,99) --> 'abc'
          • for string.byte(str,i) we can choose a certain index of 's', rather than just
            the default index 1. 
            string.byte('a') --> 97
            string.byte('abc') --> 97
            string.byte('abc',3) --> 99
            string.byte('abc',-1) --> 99
            In lua 5.1 string.byte also can use a 3rd argument, giving us a mix of .sub and
            .byte. Meaning we get the numeric representation from i to j inclusive
            string.byte(s,i,j) or string.byte('abcd',2,3) --> 98 99 🤯🤯🤯🤯🤯

            The default value for j is i (i.e., .byte('abcd',2) == .byte('abcd',2,2)) working
            as it dead in lua 5.0. A nice idiom is {s:byte(1,-1)}, which creates a table
            or array with the codes of all characters in s. Given this table, we can recreate
            the original string by then calling string.char(unpack(t)). But this only works
            on strings small than 2kbs, since Lua puts a limit on how many values a function
            can return. In standard Lua, the max number is typically restricted by the vm
            to just below 255 items

      • string.format is a powerful tool for formatting strings, typically for output. It
        returns a formatted version of its varible number of arguments following the desc
        given by its first argument, the so-called 'format string'

        Similar to C syntax and composed of regular text and directives. The directives
        control where and how each argument is placed in the resulting string. A directive
        is the character '%' plus a letter that tells how to format the argument: d for decimal,
        x for hex, o for octal, f for float, s for string, plus other variants. Between '%'
        and the letter, a directive can include other options that control the details of
        the format, such as the number of decimal digits of a float.
          string.format('%02d/%02d/%04d',25,12,1976) --> '25/12/1976'
          Or if tag,title = 'h1','a title' then string.format('<%s>%s</%s>',tag,title,tag) -->
          <h1>a title</h1>
          based on all of that then I can use what I know about ':' to plug this on a pattern
          like: pattern:format(tag,title,tag) 🤔? YEAP IT WORKS --> <h1>an html title</h1> 🤯🤓
        Lua uses the standard C library to do the heavy lefting, so directives are the same.
        
  • 



]]
