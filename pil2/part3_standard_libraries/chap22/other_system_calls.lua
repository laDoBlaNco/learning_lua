--[[
22.2 - OTHER SYSTEM CALLS

The os.exit function terminates the execution of a program. 

The os.getenv function gets the value of an environment variable. It takes 
the name of the variable and returns a string with its value:
]]
print(os.getenv('HOME'));print()

--[[
If the variable isn't defined (or spelled wrong or with wrong caps). 

The call returns nil. The function os.execute runs a system command; it is 
equivalent to the 'system' function in C. it takes a string with the command
and returns an error code. For instance, both in Unix and in Dos-Windows, we can write
the following function to create new directories:
]]
function createDir(dirName)
  os.execute('mkdir '..dirName)
end
-- createDir('new_directory')

--[[
The os.execute function is powerful, but it is also highly system dependent.

The os.setlocale function sets the current locale used by a lua program. Locales
define behavior that is sensitive to cultural or linguistic differences. The
'setlocale' function has two string parameters:
  • the locale name and
  • a category that specifies what features the locale will affect. There are
    six categories of locales:
      • 'collate' - controls the alphabetic order of strings;
      • 'ctype' - controls the types of individual characters (e.g., what is a letter)
        and the conversion between lower and upper cases;
      • 'monetary' - has no influence in lua programs;
      • 'numeric' - controls how numbers are formatted; 
      • 'time' - controls how date and time are formatted (i.e., function os.date);
      • 'all' - controls all the above functions 
    The default category is 'all', so that if we call setlocale with only the locale
    name it will set all categories. 
The os.setlocale function returns the locale name or nil if it fails (usually because
the system doesn't support the given locale).
]]
print(os.setlocale('ISO-8859-1','collate'));print()

--[[
The cateogry 'numeric' is pretty tricky. As Portuguese and other Latin languages
use a comma instead of a point to represent decimal numbers, the locale changes
the way lua prints and reads these numbers. But the locale doesn't change the
way that lua parses numbers in programs (among other reasons because expressions
like 'print(3,4)' already have a meaning in lua). If we are using lua to create
pieces of lua code, we may have problems here. 
]]
