mouse_range = {}
mouse_range.startPos = {}
mouse_range.endPos = {}

local function getTile(x, y)
    local tileX = math.floor(x / map.tileWidth)
    local tileY = math.floor(y / map.tileHeight)
    return {tileX, tileY}
end

function mouse_range:StartDrag(x, y, button, istouch, presses)
    mouse_range.startPos = getTile(x, y)
end

function mouse_range:StopDrag(x, y, button, istouch, presses)
    mouse_range.endPos = getTile(x, y)
    --print(mouse_range.endPos.x, mouse_range.endPos.y)
    if --[[ mouse_range.startPos == mouse_range.endPos or ]] true then
        if button == 1 then
            map:SetTile(mouse_range.endPos[1], mouse_range.endPos[2])
        end
    else
        --[[ Calculate all selected tiles ]]
        --[[ local x_range =  ]]

    end

    mouse_range.startPos = {}
    mouse_range.endPos = {}
end

function mouse_range:Draw()
    local mouseX, mouseY = love.mouse.getPosition()
    for k,v in pairs(mouse_range.startPos) do
        print(v)
    end
    if not mouse_range.startPos == {} then
        love.graphics.setColor(tile.color)
        love.graphics.rectangle("fill", mouse_range.startPos[1] * map.tileWidth, mouse_range.startPos[2] * map.tileHeight, mouseX* 64, mouseY * 64)
        love.graphics.setColor(1, 1, 1)
        --love.graphics.rectangle("line", map.tileWidth * countCol, map.tileHeight * countRow, map.tileWidth, map.tileHeight)
    end
end