local Timer = require('functions_first_class_objs')

function love.update(dt)
    Timer.updateAll(dt)
end

Timer.add(3,function() -- again we can use left value or right value, the most common is right value in this situation
    print('hello from the callback')
end)


