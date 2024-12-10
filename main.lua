require("map")

function love.load()
    love.window.setTitle("Mapmaker")
    ScrW, ScrH = love.window.getMode()
    newFont = love.graphics.newFont(60)


    math.randomseed(os.time())
    game_active = true
    map:Create()
end

function love.update(dt)
    if not game_active then
        goto GAMEEND
    end

    if love.keyboard.isDown("c") then
        game_paused = not game_paused
        return
    end

    if game_paused then
        return
    end

    ::GAMEEND::
end

function drawCenteredText(rectX, rectY, text)
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(text)
    local textHeight = font:getHeight()
    love.graphics.print(text, rectX, rectY, 0, 1, 1, textWidth / 2, textHeight / 2)
end

function love.draw()
    if not game_active then
        drawCenteredText(ScrW / 2, ScrH / 2, "DU HAST VERLOREN")
    end

    map:Show()
end

function love.keypressed(k)
    if k == "r" then
        love.event.quit "restart"
    end

    if k == "1" then
        map:SelectedType("border")
    end

    if k == "2" then
        map:SelectedType("grass")
    end

    if k == "3" then
        map:SelectedType("desert")
    end

    if k == "4" then
        map:SelectedType("water")
    end

    if k == "5" then
        map:SelectedType("bridge")
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        map:SetTile(x, y)
    end
end