function DrawHearts()
    for i = 0, gary.health do
        local heartSprites = love.graphics.newImage("Sprites/full_heart.png")
        if gary.health == i - 0.5 then
            heartSprites = love.graphics.newImage("Sprites/half_heart.png")
        end
        if gary.health == i - 1 or gary.health == 0 then
            heartSprites = love.graphics.newImage("Sprites/empty_heart.png")
        end
        love.graphics.draw(heartSprites, camera.x - 700, camera.y - 400)
    end
end
