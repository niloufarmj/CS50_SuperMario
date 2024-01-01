StartState = Class{__includes = BaseState}

function StartState:init()
    self.map = LevelMaker.generate(100, 10)
    self.background = math.random(5)
end

function StartState:update(dt)
    if love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] then
        gStateMachine:change('play', {
            background = self.background
        })
    end
end

function StartState:render()
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0, 0)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0,
        gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
    
    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Mario CS 50', 1, WINDOW.VIRTUAL_HEIGHT / 2 - 40 + 1, WINDOW.VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Mario CS 50', 0, WINDOW.VIRTUAL_HEIGHT / 2 - 40, WINDOW.VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Press Enter', 1, WINDOW.VIRTUAL_HEIGHT / 2 + 17, WINDOW.VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Press Enter', 0, WINDOW.VIRTUAL_HEIGHT / 2 + 16, WINDOW.VIRTUAL_WIDTH, 'center')
end