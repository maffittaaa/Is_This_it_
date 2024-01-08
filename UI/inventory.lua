function DrawInventory()
    local inventorySprite = love.graphics.newImage("Sprites/inventoryRectangle.png")
    local posX = 0.6 - (4 * 0.08)

    for i = 1, 5, 1 do
        love.graphics.draw(inventorySprite, camera.x + (width/2 * posX), camera.y + (height/2 * 0.65))
        posX = posX + 0.08
    end
end
