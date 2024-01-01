
Tile = Class{}

function Tile:init(x, y, id, topper, tileset, topperset)
    self.x = x
    self.y = y

    self.width = TILE.SIZE
    self.height = TILE.SIZE

    self.id = id
    self.tileset = tileset
    self.topper = topper
    self.topperset = topperset
end

--[[
    Checks to see whether this ID is whitelisted as collidable in a global constants table.
]]
function Tile:collidable(target)
    for k, v in pairs(COLLIDABLE_TILES) do
        if v == self.id then
            return true
        end
    end

    return false
end

function Tile:render()
    love.graphics.draw(gTextures['tiles'], gFrames['tilesets'][self.tileset][self.id],
        (self.x - 1) * TILE.SIZE, (self.y - 1) * TILE.SIZE)
    
    -- tile top layer for graphical variety
    if self.topper then
        love.graphics.draw(gTextures['toppers'], gFrames['toppersets'][self.topperset][self.id],
            (self.x - 1) * TILE.SIZE, (self.y - 1) * TILE.SIZE)
    end
end