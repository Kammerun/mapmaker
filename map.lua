map = {}

map.mapWidth = 10
map.mapHeight = 12
map.tileWidth = 64
map.tileHeight = 64

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
    for i = 1, map.mapHeight do
        local row = {}
        for j = 1, map.mapWidth do
            table.insert(row, border)
        end
        table.insert(map_tiles, row)
    end
end

function map:Show()
    for countRow, tileRow in pairs(map_tiles) do
        for countCol, tile in pairs(tileRow) do
            love.graphics.setColor(tile.color)
            love.graphics.rectangle("fill", map.tileWidth * countCol, map.tileHeight * countRow, map.tileWidth, map.tileHeight)
            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("line", map.tileWidth * countCol, map.tileHeight * countRow, map.tileWidth, map.tileHeight)
        end
    end
end

function map:SetTile(x, y)
    if not curTypeTile then
        print("no Tile Type selected")
        return
    end

    local tileX = math.floor(x)
    local tileY = math.floor(y)

    if tileX < 0 or tileX > map.mapWidth then
        error("X Wrong", tileX)
        return
    end

    if tileY < 0 or tileY > map.mapHeight then
        error("Y Wrong", tileY)
        return
    end

    map_tiles[tileY][tileX] = curTypeTile
end

function map:PrintCode()
    print("\n\n")
    print("map = {")

    for i = 1, map.mapHeight do
        local currentRow = "{"
        for j = 1, map.mapWidth do
            if j == map.mapWidth then
                currentRow = currentRow .. map_tiles[i][j].name .. "},"
            elseif j == 1 then
                currentRow = "\t" .. currentRow .. map_tiles[i][j].name .. ","
            else
                currentRow = currentRow .. map_tiles[i][j].name .. ","
            end
        end
        print(currentRow)
    end
    print("}")
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