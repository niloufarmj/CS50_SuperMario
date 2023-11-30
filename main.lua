require 'src/Dependencies'


local mapWidth = 20
local mapHeight = 20

local cameraX = 0  -- Initial camera position

local currentAnimation

local isJumping = false
local jumpVelocity = -200
local jumpHeight = 30
local gravity = 800

function love.load()
    math.randomseed(os.time())

    -- random tile set and topper set for the level
    tileset = math.random(#tilesets)
    topperset = math.random(#toppersets)

    backgroundR = math.random(255) / 255
    backgroundG = math.random(255) / 255
    backgroundB = math.random(255) / 255

    tiles = generateLevel()

    -- texture for the character
    characterSheet = love.graphics.newImage('assets/character.png')
    characterQuads = GenerateQuads(characterSheet, CHARACTER_WIDTH, CHARACTER_HEIGHT)

    -- Create idle and moving animations
    idleAnimation = Animation({frames = {1}, interval = 1})
    movingAnimation = Animation({frames = {10, 11}, interval = 0.2})
    jumpAnimation = Animation({frames = {3}, interval = 1})

    direction = 'right'
    currentAnimation = idleAnimation

    -- place character in middle of the screen, above the top ground tile
    characterX = WINDOW.VIRTUAL_WIDTH / 2 - (CHARACTER_WIDTH / 2)
    characterY = ((6 - 1) * TILE_SIZE) - CHARACTER_HEIGHT



    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(WINDOW.VIRTUAL_WIDTH, WINDOW.VIRTUAL_HEIGHT, WINDOW.WIDTH, WINDOW.HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
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
    currentAnimation:update(dt)

    -- Check if the character is on the ground
    local onGround = characterY >= ((6 - 1) * TILE_SIZE) - CHARACTER_HEIGHT

    -- Update player position based on input

    if isJumping then
        if love.keyboard.isDown('right') then
            characterX = characterX + CHARACTER_MOVE_SPEED * dt
            direction = 'right'
            currentAnimation = jumpAnimation
        elseif love.keyboard.isDown('left') then
            characterX = characterX - CHARACTER_MOVE_SPEED * dt
            direction = 'left'
            currentAnimation = jumpAnimation
        else
            currentAnimation = idleAnimation
        end

        characterY = characterY + jumpVelocity * dt
        jumpVelocity = jumpVelocity + gravity * dt

        -- Check if the character has landed
        if characterY >= ((6 - 1) * TILE_SIZE) - CHARACTER_HEIGHT then
            characterY = ((6 - 1) * TILE_SIZE) - CHARACTER_HEIGHT
            isJumping = false
            currentAnimation = idleAnimation
        end
    else
        -- Jumping logic
        if love.keyboard.isDown('space') and onGround then
            isJumping = true
            jumpVelocity = -math.sqrt(2 * gravity * jumpHeight)
            currentAnimation = jumpAnimation
        elseif love.keyboard.isDown('right') then
            characterX = characterX + CHARACTER_MOVE_SPEED * dt
            direction = 'right'
            currentAnimation = movingAnimation
        elseif love.keyboard.isDown('left') then
            characterX = characterX - CHARACTER_MOVE_SPEED * dt
            direction = 'left'
            currentAnimation = movingAnimation
        else
            currentAnimation = idleAnimation
        end
    end


    -- Round camera position to whole numbers
    cameraX = math.floor(characterX - (WINDOW.VIRTUAL_WIDTH / 2) + (CHARACTER_WIDTH / 2))

    -- ...
end

function love.draw()
    push:start()
    
    
    -- Apply camera translation
    love.graphics.translate(-cameraX, 0)
    love.graphics.clear(backgroundR, backgroundG, backgroundB, 1)
    
    for y = 1, mapHeight do
        for x = 1, mapWidth do
            local tile = tiles[y][x]
            love.graphics.draw(tilesheet, tilesets[tileset][tile.id], (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)

            if tile.topper then
                love.graphics.draw(topperSheet, toppersets[topperset][tile.id], (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
            end
        end
    end
    
    
    -- Draw character
    love.graphics.draw(
        characterSheet,
        characterQuads[currentAnimation:getCurrentFrame()],

        -- X and Y we draw at need to be shifted by half our width and height because we're setting the origin
        -- to that amount for proper scaling, which reverse-shifts rendering
        math.floor(characterX) + CHARACTER_WIDTH / 2,
        math.floor(characterY) + CHARACTER_HEIGHT / 2,

        -- 0 rotation, then the X and Y scales
        0,
        direction == 'left' and -1 or 1,
        1,

        -- Lastly, the origin offsets relative to 0,0 on the sprite (set here to the sprite's center)
        CHARACTER_WIDTH / 2,
        CHARACTER_HEIGHT / 2
    )
    
    push:finish()
end

function generateLevel()
    local tiles = {}

    for y = 1, mapHeight do
        table.insert(tiles, {})
        
        for x = 1, mapWidth do
            
            -- sky and bricks; this ID directly maps to whatever quad we want to render
            table.insert(tiles[y], {
                id = y < 6 and SKY or GROUND,
                topper = y == 6 and true or false
            })
        end
    end

    return tiles
end