Class = require 'lib/class'
push = require 'lib/push'

require 'src/Util'
require 'src/Animation'
require 'src/Constants'
require 'Entity'
require 'StateMachine'
require 'Tile'
require 'TileMap'
require 'Player'
require 'states.BaseState'
require 'states.PlayState'
require 'states.PlayerFallingState'
require 'states.PlayerIdleState'
require 'states.PlayerJumpState'
require 'states.PlayerWalkingState'
require 'states.StartState'

gTextures = {
    ['tiles'] = love.graphics.newImage('assets/tiles.png'),
    ['toppers'] = love.graphics.newImage('assets/tile_tops.png'),
    ['character'] = love.graphics.newImage('assets/character.png')
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE),
    ['toppers'] = GenerateQuads(gTextures['toppers'], TILE_SIZE, TILE_SIZE),
    ['character']   = GenerateQuads(gTextures['character'], CHARACTER_WIDTH, CHARACTER_HEIGHT)
}


-- divide quad tables into tile sets
tilesets = GenerateTileSets(gFrames['tiles'], TILE_SETS_WIDE, TILE_SETS_TALL, TILE_SET_WIDTH, TILE_SET_HEIGHT)
toppersets = GenerateTileSets(gFrames['toppers'], TOPPER_SETS_WIDE, TOPPER_SETS_TALL, TILE_SET_WIDTH, TILE_SET_HEIGHT)




