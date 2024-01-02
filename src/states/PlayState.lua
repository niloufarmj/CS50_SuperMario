
PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.camX = 0
    self.camY = 0

    self.level  = LevelMaker.generate(100, 10)
    self.tileMap = self.level.tileMap
    self.background = params.background
    self.backgroundX = 0

    self.gravityOn = true

    self.player = Player({
        x = 0, y = 0,
        width = 16, height = 20,
        texture = 'green-alien',
        stateMachine = StateMachine {
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walking'] = function() return PlayerWalkingState(self.player) end,
            ['jump'] = function() return PlayerJumpState(self.player) end,
            ['falling'] = function() return PlayerFallingState(self.player) end
        },
        map = self.tileMap,
        level = self.level
    })

    self.player:changeState('falling')
end

function PlayState:update(dt)
    Timer.update(dt)

    -- remove any nils from pickups, etc.
    self.level:clear()

    -- update player and level
    self.player:update(dt)
    self.level:update(dt)
    self:updateCamera()

    -- constrain player X no matter which state
    if self.player.x <= 0 then
        self.player.x = 0
    elseif self.player.x > TILE.SIZE * self.tileMap.width - self.player.width then
        self.player.x = TILE.SIZE * self.tileMap.width - self.player.width
    end
end

function PlayState:render()
    love.graphics.push()
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX), 0)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX),
        gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX + 256), 0)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX + 256),
        gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
    
    -- translate the entire view of the scene to emulate a camera
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    
    self.level:render()

    self.player:render()
    love.graphics.pop()
    
    -- render score
    -- love.graphics.setColor(0, 0, 0, 1)
    -- love.graphics.print(tostring(self.player.score), 5, 5)
    -- love.graphics.setColor(1, 1, 1, 1)
    -- love.graphics.print(tostring(self.player.score), 4, 4)
    
end

function PlayState:updateCamera()
    -- clamp movement of the camera's X between 0 and the map bounds - virtual width,
    -- setting it half the screen to the left of the player so they are in the center
    self.camX = math.max(0,
        math.min(TILE.SIZE * self.tileMap.width - WINDOW.VIRTUAL_WIDTH,
        self.player.x - (WINDOW.VIRTUAL_WIDTH / 2 - 8)))

    -- adjust background X to move a third the rate of the camera for parallax
    self.backgroundX = (self.camX / 3) % 256
end
