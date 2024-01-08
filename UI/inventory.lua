inventorySprites = {}

function UpdateInventory()
    local inventoryRectangleSprite = love.graphics.newImage("Sprites/inventoryRectangle.png")
    local inventoryWithKey = love.graphics.newImage("Sprites/inventoryWithKey.png")
    local inventoryWithPage = love.graphics.newImage("Sprites/inventoryWithPage.png")
    local inventoryWithPages_2 = love.graphics.newImage("Sprites/inventoryWithPages_2.png")
    local inventoryWithPages_3 = love.graphics.newImage("Sprites/inventoryWithPages_3.png")
    local inventoryWithPages_4 = love.graphics.newImage("Sprites/inventoryWithPages_4.png")
    if collectible_key.counter == 1 then
        inventorySprites[1] = inventoryWithKey
        inventorySprites[2] = inventoryRectangleSprite
    else
        inventorySprites[1] = inventoryRectangleSprite
        inventorySprites[2] = inventoryRectangleSprite
    end

    if collectible_key.counter == 0 and collectiblePages.counter == 1 then
        inventorySprites[1] = inventoryWithPage
        inventorySprites[2] = inventoryRectangleSprite
    elseif collectible_key.counter == 1 and collectiblePages.counter == 1 then
        inventorySprites[1] = inventoryWithPage
        inventorySprites[2] = inventoryWithKey
    elseif collectible_key.counter == 1 and collectiblePages.counter == 2 then
        inventorySprites[1] = inventoryWithPages_2
        inventorySprites[2] = inventoryWithKey
    elseif collectible_key.counter == 1 and collectiblePages.counter == 3 then
        inventorySprites[1] = inventoryWithPages_3
        inventorySprites[2] = inventoryWithKey
    elseif collectible_key.counter == 1 and collectiblePages.counter == 4 then
        inventorySprites[1] = inventoryWithPages_3
        inventorySprites[2] = inventoryWithKey
    end
end

function DrawInventory()
    local posX = 0.85 - (4 * 0.08)

    for i = 1, #inventorySprites, 1 do
        print(inventorySprites[i])
        love.graphics.draw(inventorySprites[i], camera.x + (width / 2 * posX), camera.y + (height / 2 * 0.65))
        posX = posX + 0.08
    end
end
