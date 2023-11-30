require 'src/Dependencies'


local mapWidth = 20
local mapHeight = 20

local cameraX = 0  -- Initial camera position

local currentAnimation

local isJumping = false
local jumpVelocity = -150
local jumpHeight = 40
local gravity = 400

function love.load()
    math.randomseed(os.time())

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
    characterY = ((7 - 1) * TILE_SIZE) - CHARACTER_HEIGHT



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

    if key == 'r' then 
        tiles = generateLevel()
    end
end



function love.update(dt)
    currentAnimation:update(dt)

    -- Check if the character is on the ground
    local onGround = characterY >= ((7 - 1) * TILE_SIZE) - CHARACTER_HEIGHT

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
        if characterY >= ((7 - 1) * TILE_SIZE) - CHARACTER_HEIGHT then
            characterY = ((7 - 1) * TILE_SIZE) - CHARACTER_HEIGHT
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
    tileset = math.random(#tilesets)
    topperset = math.random(#toppersets)
    backgroundR = math.random(255) / 255
    backgroundG = math.random(255) / 255
    backgroundB = math.random(255) / 255

    local tiles = {}

    -- create 2D array completely empty first so we can just change tiles as needed
    for y = 1, mapHeight do
        table.insert(tiles, {})

        for x = 1, mapWidth do
            table.insert(tiles[y], {
                id = 0,
                topper = false
            })
        end
    end

    -- iterate over X at the top level to generate the level in columns instead of rows
    for x = 1, mapWidth do
        -- random chance for a pillar
        local spawnPillar = math.random(5) == 1
        
        if spawnPillar then
            
            if math.random(1, 2) == 1 then
                for pillar = 5, 9 do
                    tiles[pillar][x] = {
                        id = GROUND,
                        topper = pillar == 5 and true or false
                    }
                end
            else
                for pillar = 7, 8 do
                    tiles[pillar][x] = {
                        id = SKY,
                        topper = false
                    }
                end
            end
        else
            -- always generate ground
            for ground = 7, mapHeight do
                if tiles[ground][x].id == 0 then
                    tiles[ground][x] = {
                        id = GROUND,
                        topper = ground == 7 and true or false
                    }
                end
            end
        end
    end

    -- set remaining tiles to sky
    for y = 1, mapHeight do
        for x = 1, mapWidth do
            if tiles[y][x].id == 0 then
                tiles[y][x] = {
                    id = SKY,
                    topper = false
                }
            end
        end
    end

    return tiles
end