--[[
    Assert and Error

Ususally want to prevent our programms from crashing, but at times we will want to
make them crash.

]]

Textbox = {}
Textbox.__index = Textbox

function Textbox.new(settings)
    -- assert what this arg should be and if it isn't, break
    assert(type(settings)=='table','Error, table expected but got: '..type(settings))


    local instance = setmetatable({}, Textbox)

    if settings.shadow == nil then settings.shadow = true end
    if settings.outline == nil then settings.outline = true end

    assert(settings.x >=0,'X cannot be negative and its: '..settings.x)
    instance.x = settings.x or 0
    instance.y = settings.y or 0
    instance.width = settings.width or 300
    instance.height = settings.height or 200
    instance.text = settings.text or ''
    instance.shadow = settings.shadow or true
    instance.outline = settings.outline or true
    instance.portait = settings.portrait or 'none'
    instance.name = settings.name or ''

    return instance
end

local welcomeBox = Textbox.new({ x = 200, y = 300, text = 'Welcome :)', portrait = 'player', name = 'Kev' })
-- if we forget that this needs to be a table and just add the args, we'll get an error that's
-- hard to understand. - to make it clearer we can use an assert function at the top and put a message that is clear 
-- local welcomeBox = Textbox.new(200,300,'Welcome :)','player','Kev')

-- another function is 'error'. This is like throwing or raising in other langs. It basically
-- means if the program got this far or to this section, something went wrong and we 
-- need to crash.
local function setDirection(direction)
    if direction == 'left' then
        -- move left
    elseif direction == 'right' then
        -- move right
    else
        error('Direction can only be left or right, but it was: '..direction)
    end
end

setDirection('up')

