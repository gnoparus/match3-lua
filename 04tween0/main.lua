push = require 'push'

VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

MOVE_DURATION = 2

function love.load()

    flappySprite = love.graphics.newImage('flappy.png')
    flappyX, flappyY = 0, VIRTUAL_HEIGHT / 2 - 8

    timer = 0

    endX = VIRTUAL_WIDTH - flappySprite:getWidth()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    if timer < MOVE_DURATION then
        timer = timer + dt
        flappyX = math.min(endX, endX * timer / MOVE_DURATION)
    end
end

function love.draw()
    push:start()
    love.graphics.draw(flappySprite, flappyX, flappyY)
    love.graphics.print(tostring(timer), 4, 4)
    push:finish()
end
