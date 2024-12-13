local inspect = require("inspect")

mouse_range = {}
mouse_range.startPos = {}
mouse_range.endPos = {}

local function getTile(pos)
    local tileX = math.floor(pos[1] / map.tileWidth)
    local tileY = math.floor(pos[2] / map.tileHeight)
    return {tileX, tileY}
end

function mouse_range:StartDrag(x, y, button, istouch, presses)
    mouse_range.startPos = {x, y}
end

function mouse_range:StopDrag(x, y, button, istouch, presses)
    mouse_range.endPos = {x, y}
    local startPos = getTile(mouse_range.startPos)
    local endPos = getTile(mouse_range.endPos)

    local differenceX = (endPos[1] - startPos[1])
    local differenceY = (endPos[2] - startPos[2])

    if (differenceX == 0 and differenceY == 0) then
        if
            (button == 1)
            and (endPos[1] >= 1 and endPos[1] <= map.mapWidth)
            and (endPos[2] >= 1 and endPos[2] <= map.mapHeight)
        then
            map:SetTile(endPos[1], endPos[2])
        end
    else
        for i = 0, math.abs(differenceY) do
            local numY = endPos[2] > startPos[2] and i or i * -1
            for j = 0, math.abs(differenceX) do
                local numX = endPos[1] > startPos[1] and j or j * -1

                if
                    (startPos[1] + numX >= 1 and startPos[1] + numX <= map.mapWidth)
                    and (startPos[2] + numY >= 1 and startPos[2] + numY <= map.mapHeight)
                then
                    map:SetTile(startPos[1] + numX, startPos[2] + numY)
                end
            end
        end
    end

    mouse_range.startPos = {}
    mouse_range.endPos = {}
end

function mouse_range:Draw()
    local mouseX, mouseY = love.mouse.getPosition()

    if mouse_range.startPos[1] and mouse_range.startPos[2] then
        love.graphics.setColor(0, 0.2, 0.8, 0.2)
        love.graphics.rectangle("fill", mouse_range.startPos[1], mouse_range.startPos[2], mouseX -mouse_range.startPos[1], mouseY - mouse_range.startPos[2])

        love.graphics.setColor(0, 0.3, 0.6, 0.8)
        love.graphics.rectangle("line", mouse_range.startPos[1], mouse_range.startPos[2], mouseX -mouse_range.startPos[1], mouseY - mouse_range.startPos[2])
    end
end