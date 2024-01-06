
WINDOW = {
    WIDTH = 1280,
    HEIGHT = 640,
    VIRTUAL_WIDTH = 256,
    VIRTUAL_HEIGHT = 128
}

TILE = {
    SIZE = 16,
    SCREEN_WIDTH = WINDOW.VIRTUAL_WIDTH / 16,
    SCREEN_HEIGHT = WINDOW.VIRTUAL_HEIGHT / 16,
    SET_WIDTH = 5,
    SET_HEIGHT = 4,
    SETS_WIDE = 6,
    SETS_TALL = 10,
    SETS = 6 * 10,
}

TOPPER = {
    SETS_WIDE = 6,
    SETS_TALL = 18,
    SETS = 6 * 18,
}

-- tile ID constants
SKY = 5
GROUND = 3

COLLIDABLE_TILES = {
    GROUND
}

CHARACTER = {
    WIDTH = 16,
    HEIGHT = 20,
    JUMP_SPEED = -250,
    JUMP_HEIGHT = 150,
    WALK_SPEED = 50
}

SNAIL = {
    WALK_SPEED = 10
}


GRAVITY = 6

--
-- game object IDs
--
BUSH_IDS = {
    1, 2, 5, 6, 7
}

COIN_IDS = {
    1, 2, 3
}

CRATES = {
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
}

GEMS = {
    1, 2, 3, 4, 5, 6, 7, 8
}

JUMP_BLOCKS = {}

for i = 1, 12 do
    table.insert(JUMP_BLOCKS, i)
end