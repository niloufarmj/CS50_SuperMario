push = require 'lib/push'

require 'src/Util'


WINDOW = {
    WIDTH = 1280, 
    HEIGHT = 720,
    VIRTUAL_WIDTH = 256,
    VIRTUAL_HEIGHT = 144
}

TILE_SIZE = 16

-- tile ID constants
SKY = 2
GROUND = 1

local mapWidth = 20
local mapHeight = 20

function love.load()
    math.randomseed(os.time())
    
    tiles = {}
    
    -- tilesheet image and quads for it, which will map to our IDs
    tilesheet = love.graphics.newImage('assets/tiles.png')
    quads = GenerateQuads(tilesheet, TILE_SIZE, TILE_SIZE)
    

    backgroundR = math.random(255) / 255 
    backgroundG = math.random(255) / 255 
    backgroundB = math.random(255) / 255 

    for y = 1, mapHeight do
        table.insert(tiles, {})
        
        for x = 1, mapWidth do
            -- sky and bricks; this ID directly maps to whatever quad we want to render
            table.insert(tiles[y], {
                id = y < 6 and SKY or GROUND
            })
        end
    end

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

function love.draw()
    push:start()
        love.graphics.clear(backgroundR, backgroundG, backgroundB, 1)
        
        for y = 1, mapHeight do
            for x = 1, mapWidth do
                local tile = tiles[y][x]
                love.graphics.draw(tilesheet, quads[tile.id], (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
            end
        end
    push:finish()
end