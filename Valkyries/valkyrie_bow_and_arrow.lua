require "Valkyrie/valkyrie"
require "MainCharacter/gary"
require "Sprites/sprites"

function LoadValkyrieRangedAttack()
    bullets = {}
    if valkyrie.cooldown <= 0 then
    bullets.img = sprites.arrow
    bullets.x = valkyrie.body:getX() / 2
    bullets.y = valkyrie.body:getY()
    bullets.width = bullets.img:getWidth()
    bullets.height = bullets.img:getHeight()
    canShoot = false
    bullets.timer = 0.4
    table.insert(bullets)
    end
end

function UpdateValkyrieRangedAttack(dt)
    if valkyrie.playerInSight == true then
        bullets.timer = bullets.timer + dt
        canShoot= true

        
    end
end
