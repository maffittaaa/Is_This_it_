function DrawInventory()
    inventorySprites = {}
    local posX = camera.x + 580
    for i = 1, 5, 1 do
        local inventorySprite = love.graphics.newImage("Sprites/inventoryRectangle.png")
        inventorySprites[i] = inventorySprite
        love.graphics.draw(inventorySprites[i], camera.x + 580, camera.y + 350)
        posX = posX - 50
    end
end
