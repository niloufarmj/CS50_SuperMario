--[[
    GD50
    Super Mario Bros. Remake

    -- StartState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

StartState = Class{__includes = BaseState}

function StartState:init()
    self.map = LevelMaker.generate(100, 10)
    self.background = math.random(3)
end

function StartState:update(dt)
    if love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] then
        gStateMachine:change('play')
    end
end

function StartState:render()
    -- love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0, 0)
    -- love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0,
    --     gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
    -- self.map:render()
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Super 50 Bros.', 1, WINDOW.VIRTUAL_HEIGHT / 2 - 40 + 1, WINDOW.VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Super 50 Bros.', 0, WINDOW.VIRTUAL_HEIGHT / 2 - 40, WINDOW.VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Press Enter', 1, WINDOW.VIRTUAL_HEIGHT / 2 + 17, WINDOW.VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Press Enter', 0, WINDOW.VIRTUAL_HEIGHT / 2 + 16, WINDOW.VIRTUAL_WIDTH, 'center')
end