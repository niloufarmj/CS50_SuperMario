Class = require 'lib/class'
push = require 'lib/push'

require 'src/Util'
require 'src/Animation'
require 'src/Constants'


-- tilesheet image and quads for it, which will map to our IDs
tilesheet = love.graphics.newImage('assets/tiles.png')
quads = GenerateQuads(tilesheet, TILE_SIZE, TILE_SIZE)

topperSheet = love.graphics.newImage('assets/tile_tops.png')
topperQuads = GenerateQuads(topperSheet, TILE_SIZE, TILE_SIZE)

-- divide quad tables into tile sets
tilesets = GenerateTileSets(quads, TILE_SETS_WIDE, TILE_SETS_TALL, TILE_SET_WIDTH, TILE_SET_HEIGHT)
toppersets = GenerateTileSets(topperQuads, TOPPER_SETS_WIDE, TOPPER_SETS_TALL, TILE_SET_WIDTH, TILE_SET_HEIGHT)