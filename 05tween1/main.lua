push = require 'push'

VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

TIMER_MAX = 10

function love.load()

    flappySprite = love.graphics.newImage('flappy.png')
    birds = {}

    for i = 1, 100 do
        table.insert(birds, {
            x = 0,
            y = math.random(VIRTUAL_HEIGHT - 24),
            rate = math.random() + math.random(TIMER_MAX - 1)
            -- rate = i / 10
        })
    end

    timer = 0

    endX = VIRTUAL_WIDTH - flappySprite:getWidth()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    if timer < TIMER_MAX then
        timer = timer + dt

        for k, bird in pairs(birds) do
            bird.x = math.min(endX, endX * timer / bird.rate)
        end
    end
end

function love.draw()
    push:start()

    for k, bird in pairs(birds) do
        love.graphics.draw(flappySprite, bird.x, bird.y)
    end

    love.graphics.print(tostring(timer), 4, 4)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 4, VIRTUAL_HEIGHT - 16)
    push:finish()
end
