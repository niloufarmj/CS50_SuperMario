
WINDOW = {
    WIDTH = 1280,
    HEIGHT = 720,
    VIRTUAL_WIDTH = 256,
    VIRTUAL_HEIGHT = 144
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

CHARACTER_WIDTH = 16
CHARACTER_HEIGHT = 20
CHARACTER_MOVE_SPEED = 40

CHARACTER = {
    JUMP_SPEED = -150,
    JUMP_HEIGHT = 40,
    WALK_SPEED = 60
}


GRAVITY = 400

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

for i = 1, 30 do
    table.insert(JUMP_BLOCKS, i)
end