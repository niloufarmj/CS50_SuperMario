Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Util'
require 'src/Animation'
require 'src/Constants'
require 'src/Entity'
require 'src/StateMachine'
require 'src/Tile'
require 'src/TileMap'
require 'src/Player'
require 'src/GameObject'
require 'src/GameLevel'
require 'src/LevelMaker'
require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/states/PlayerFallingState'
require 'src/states/PlayerIdleState'
require 'src/states/PlayerJumpState'
require 'src/states/PlayerWalkingState'

gTextures = {
    ['tiles'] = love.graphics.newImage('assets/tiles.png'),
    ['toppers'] = love.graphics.newImage('assets/tile_tops.png'),
    ['character'] = love.graphics.newImage('assets/character.png'),
    ['bushes'] = love.graphics.newImage('assets/bushes_and_cacti.png'),
    ['jump-blocks'] = love.graphics.newImage('assets/jump_blocks.png'),
    ['gems'] = love.graphics.newImage('assets/gems.png'),
    ['backgrounds'] = love.graphics.newImage('assets/backgrounds.png'),
    ['green-alien'] = love.graphics.newImage('assets/green_alien.png'),
    ['creatures'] = love.graphics.newImage('assets/creatures.png')
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], TILE.SIZE, TILE.SIZE),
    ['toppers'] = GenerateQuads(gTextures['toppers'], TILE.SIZE, TILE.SIZE),
    ['character']   = GenerateQuads(gTextures['character'], CHARACTER.WIDTH, CHARACTER.HEIGHT),
    ['bushes'] = GenerateQuads(gTextures['bushes'], 16, 16),
    ['jump-blocks'] = GenerateQuads(gTextures['jump-blocks'], 16, 16),
    ['gems'] = GenerateQuads(gTextures['gems'], 16, 16),
    ['backgrounds'] = GenerateQuads(gTextures['backgrounds'], 256, 128),
    ['green-alien'] = GenerateQuads(gTextures['green-alien'], 16, 20),
    ['creatures'] = GenerateQuads(gTextures['creatures'], 16, 16)
}


-- divide quad tables into tile sets
gFrames['tilesets'] = GenerateTileSets(gFrames['tiles'], TILE.SETS_WIDE, TILE.SETS_TALL, TILE.SET_WIDTH, TILE.SET_HEIGHT)
gFrames['toppersets'] = GenerateTileSets(gFrames['toppers'], TOPPER.SETS_WIDE, TOPPER.SETS_TALL, TILE.SET_WIDTH, TILE.SET_HEIGHT)


gFonts = {
    ['small'] = love.graphics.newFont('assets/font.ttf', 6),
    ['medium'] = love.graphics.newFont('assets/font.ttf', 12),
    ['large'] = love.graphics.newFont('assets/font.ttf', 24)
}

