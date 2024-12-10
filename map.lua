local inspect = require("inspect")
map = {}

local mapWidth = 10
local mapHeight = 10
local tileWidth = 64
local tileHeight = 64

local curTypeTile = nil

local border = {
    name = "border",
    color = {0.5, 0.5, 0.5},
    noWalk = true
}

local grass = {
    name = "grass",
    color = {0, 1, 0},
}

local desert = {
    name = "desert",
    color = {1, 1, 0},
}

local water = {
    name = "water",
    color = {0, 0, 1},
    noWalk = true
}

local bridge = {
    name = "bridge",
    color = {0.87, 1.72, 0.52}
}

local map_tiles = {}
function map:Create()
    local row = {}
    for j = 1, mapWidth do
        table.insert(row, border)
        --print(inspect(row))
    end

    for i = 1, mapHeight do
        table.insert(map_tiles, row)
    end
    --print(inspect(map_tiles))
end

function map:Show()
    for countRow, tileRow in pairs(map_tiles) do
        for countCol, tile in pairs(tileRow) do
            love.graphics.setColor(tile.color)
            love.graphics.rectangle("fill", tileWidth * (countCol - 1), tileHeight * (countRow - 1), tileWidth, tileHeight)
        end
    end
end

function map:SetTile(x, y)
    if not curTypeTile then
        print("no Tile Type selected")
        return
    end

    local tileX = math.floor(x / tileWidth)
    local tileY = math.floor(y / tileHeight)

    if tileX < 0 or tileX > mapWidth then
        print("X Wrong", tileX)
        return
    end

    if tileY < 0 or tileY > mapHeight then
        print("Y Wrong", tileY)
        return
    end

    map_tiles[tileY][tileX] = curTypeTile
end

function map:PrintCode()

end

local typeTranslation = {
    ["border"] = border,
    ["grass"] = grass,
    ["desert"] = desert,
    ["water"] = water,
    ["bridge"] = bridge
}
function map:SelectedType(type)
    curTypeTile = typeTranslation[type] or nil
    print("Setting TileType: ", curTypeTile.name)
end