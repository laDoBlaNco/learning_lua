--[[
    Named and Optional Argumenst in lua

Generally we want to reduce the amount of arguments in our functions, but with gfx and game programming
its often necessary to have a lot of arguments. This creatse the problem for readability as well as
even remembering what they are all for. Or if you don't need some, wasting time putting them in, etc.

Name Arguments
    ▫️ helps readability

Default Arguments
    ▫️ Allows us to reduce arguments needed all the time.

]]

-- for example take the following

Textbox = {}
Textbox.__index = Textbox

--[[
function Textbox.new(x, y, width, height, text, shadow, outline, portrait, name)
    local instance = setmetatable({}, Textbox)
    instance.x = x
    instance.y = y
    instance.width = width
    instance.height = height
    instance.text = text
    instance.shadow = shadow
    instance.outline = outline
    instance.portait = portrait
    instance.name = name
    -- now that's a lotta crap to write and remember

    return instance
end

-- instansiating it shows us one of the problems, WTH does all this stand for??? 🤔 many of the args look the same
local welcomeBox = Textbox.new(200,300,300,200,'Welcome :)',true,true,'player','Kev')

--]]

-- Named arguments in Lua happen in a table then we pass the table

---[[

function Textbox.new(settings)
    local instance = setmetatable({}, Textbox)

    if settings.shadow == nil then settings.shadow = true end
    if settings.outline == nil then settings.outline = true end

    instance.x = settings.x or 0  -- with its short circuit feature we do defaults like this. meaning if x wasn't set (nil) then lua would set it to '0'
    instance.y = settings.y or 0
    instance.width = settings.width or 300
    instance.height = settings.height or 200
    instance.text = settings.text or ''
    instance.shadow = settings.shadow or true -- when working with booleans you need to be careful as lua will treat nil and explicit 'false' the same
    instance.outline = settings.outline or true -- we can get by this adding the if statement above (we could also use another short circuit 'instance.outline = settings.outline == nil and true or settings.outline')
    -- a final and and slightly more deceptively simple is 'instance.outline = settings~=false' (if false or nil it'll be set to 'false' if true it'll be set to 'true' as true ~= false ) I should use
    -- the one that makes the most since to me 
    instance.portait = settings.portrait or 'none'
    instance.name = settings.name or ''
    -- now that's a lotta crap to write and remember
    
    return instance
end

-- now the order of the args won't matter
-- also with the 'or defaults' we can remove any args that just repeat the same default 
-- now our call is both more verbose and with fewer args
local welcomeBox = Textbox.new({x=200,y=300,text='Welcome :)',portrait='player',name='Kev'})

--]]
