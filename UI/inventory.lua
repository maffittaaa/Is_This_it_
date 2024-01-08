inventorySprites = {}

function UpdateInventory()
    local inventoryRectangleSprite = love.graphics.newImage("Sprites/inventoryRectangle.png")
    local inventoryWithKey = love.graphics.newImage("Sprites/inventoryWithKey.png")
    if collectible_key.counter == 1 then
        inventorySprites[1] = inventoryWithKey
        inventorySprites[2] = inventoryRectangleSprite
        inventorySprites[3] = inventoryRectangleSprite
        inventorySprites[4] = inventoryRectangleSprite
        inventorySprites[5] = inventoryRectangleSprite
    else
        inventorySprites[1] = inventoryRectangleSprite
        inventorySprites[2] = inventoryRectangleSprite
        inventorySprites[3] = inventoryRectangleSprite
        inventorySprites[4] = inventoryRectangleSprite
        inventorySprites[5] = inventoryRectangleSprite
    end

    if collectiblePages.counter == 2 then

    end
end

function DrawInventory()
    local posX = 0.6 - (4 * 0.08)

    for i = 1, #inventorySprites, 1 do
        print(inventorySprites[i])
        love.graphics.draw(inventorySprites[i], camera.x + (width / 2 * posX), camera.y + (height / 2 * 0.65))
        posX = posX + 0.08
    end
end
