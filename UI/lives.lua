
function DrawHearts()
<<<<<<< HEAD
    -- if gary.health == 5 then
    --     heartSprites = love.graphics.newImage("Sprites/full_heart.png")
    -- end
    -- if gary.health == 4.5 then
    --     heartSprites = love.graphics.newImage("Sprites/heart_anim_1.png")
    -- end
    -- if gary.health == 4 then
    --     heartSprites = love.graphics.newImage("Sprites/heart_anim_2.png")
    -- end
    -- if gary.health == 3.5 then
    --     heartSprites = love.graphics.newImage("Sprites/heart_anim_3.png")
    -- end
    -- if gary.health == 3 then
    --     heartSprites = love.graphics.newImage("Sprites/heart_anim_4.png")
    -- end
    -- if gary.health == 2.5 then
    --     heartSprites = love.graphics.newImage("Sprites/heart_anim_5.png") -- half life
    -- end
    -- if gary.health == 2 then
    --     heartSprites = love.graphics.newImage("Sprites/heart_anim_6.png")
    -- end
    -- if gary.health == 1.5 then
    --     heartSprites = love.graphics.newImage("Sprites/heart_anim_7.png")
    -- end
    -- if gary.health == 1 then
    --     heartSprites = love.graphics.newImage("Sprites/heart_anim_8.png")
    -- end
    -- if gary.health == 0.5 then
    --     heartSprites = love.graphics.newImage("Sprites/heart_anim_9.png")
    -- end
    -- if gary.health == 0 then
    --     heartSprites = love.graphics.newImage("Sprites/empty_heart.png")
    -- end
    -- love.graphics.draw(heartSprites, camera.x - 600, camera.y - 350)
=======
    if gary.health == 5 then
        heartSprites = love.graphics.newImage("Sprites/heart_anim_1.png")
    end
    if gary.health == 4.5 then
        heartSprites = love.graphics.newImage("Sprites/heart_anim_2.png")
    end
    if gary.health == 4 then
        heartSprites = love.graphics.newImage("Sprites/heart_anim_3.png")
    end
    if gary.health == 3.5 then
        heartSprites = love.graphics.newImage("Sprites/heart_anim_4.png")
    end
    if gary.health == 3 then
        heartSprites = love.graphics.newImage("Sprites/heart_anim_5.png")
    end
    if gary.health == 2.5 then
        heartSprites = love.graphics.newImage("Sprites/heart_anim_6.png") -- half life
    end
    if gary.health == 2 then
        heartSprites = love.graphics.newImage("Sprites/heart_anim_7.png")
    end
    if gary.health == 1.5 then
        heartSprites = love.graphics.newImage("Sprites/heart_anim_8.png")
    end
    if gary.health == 1 then
        heartSprites = love.graphics.newImage("Sprites/heart_anim_9.png")
    end
    if gary.health == 0.5 then
        heartSprites = love.graphics.newImage("Sprites/heart_anim_10.png")
    end
    if gary.health == 0 then
        heartSprites = love.graphics.newImage("Sprites/heart_anim_11.png")
    end
    love.graphics.draw(heartSprites, camera.x - 600, camera.y - 350)
>>>>>>> 59d33192452054e9e621c31fd4ecf06293fbeeef
end
