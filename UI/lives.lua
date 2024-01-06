
function DrawHearts()
    heartSprites = {}

    local full_sprite = love.graphics.newImage("Sprites/heart_anim_1.png")
    local half_sprite = love.graphics.newImage("Sprites/heart_anim_6.png")
    local empty_sprite = love.graphics.newImage("Sprites/heart_anim_11.png")

    if gary.health == 5 then
        heartSprites[1] = full_sprite
        heartSprites[2] = full_sprite
        heartSprites[3] = full_sprite
        heartSprites[4] = full_sprite
        heartSprites[5] = full_sprite
    end
    if gary.health == 4.5 then
        heartSprites[1] = half_sprite
        heartSprites[2] = full_sprite
        heartSprites[3] = full_sprite
        heartSprites[4] = full_sprite
        heartSprites[5] = full_sprite
    end
    if gary.health == 4 then
        heartSprites[1] = empty_sprite
        heartSprites[2] = full_sprite
        heartSprites[3] = full_sprite
        heartSprites[4] = full_sprite
        heartSprites[5] = full_sprite
    end
    if gary.health == 3.5 then
        heartSprites[1] = empty_sprite
        heartSprites[2] = half_sprite
        heartSprites[3] = full_sprite
        heartSprites[4] = full_sprite
        heartSprites[5] = full_sprite
    end
    if gary.health == 3 then
        heartSprites[1] = empty_sprite
        heartSprites[2] = empty_sprite
        heartSprites[3] = full_sprite
        heartSprites[4] = full_sprite
        heartSprites[5] = full_sprite
    end
    if gary.health == 2.5 then -- half life
        heartSprites[1] = empty_sprite
        heartSprites[2] = empty_sprite
        heartSprites[3] = half_sprite
        heartSprites[4] = full_sprite
        heartSprites[5] = full_sprite
    end
    if gary.health == 2 then
        heartSprites[1] = empty_sprite
        heartSprites[2] = empty_sprite
        heartSprites[3] = empty_sprite
        heartSprites[4] = full_sprite
        heartSprites[5] = full_sprite
    end
    if gary.health == 1.5 then
        heartSprites[1] = empty_sprite
        heartSprites[2] = empty_sprite
        heartSprites[3] = empty_sprite
        heartSprites[4] = half_sprite
        heartSprites[5] = full_sprite
    end
    if gary.health == 1 then
        heartSprites[1] = empty_sprite
        heartSprites[2] = empty_sprite
        heartSprites[3] = empty_sprite
        heartSprites[4] = empty_sprite
        heartSprites[5] = full_sprite
    end
    if gary.health == 0.5 then
        heartSprites[1] = empty_sprite
        heartSprites[2] = empty_sprite
        heartSprites[3] = empty_sprite
        heartSprites[4] = empty_sprite
        heartSprites[5] = half_sprite
    end
    if gary.health == 0 then
        heartSprites[1] = empty_sprite
        heartSprites[2] = empty_sprite
        heartSprites[3] = empty_sprite
        heartSprites[4] = empty_sprite
        heartSprites[5] = empty_sprite
    end

    local posX = 0.8 - (4 * 0.07)

    for i = 1, 5, 1 do
        love.graphics.draw(heartSprites[i], camera.x - (width/2 * posX), camera.y - (height/2 * 0.8))
        posX = posX + 0.07
    end
end
