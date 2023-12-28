gary_sword = {}

function LoadGaryAttack(world)
    gary_sword.body = love.physics.newBody(world, gary.body:getX() + 40, 100, "dynamic")
    gary_sword.shape = love.physics.newRectangleShape(sprites.sword_right:getWidth(), sprites.sword_right:getHeight())
    gary_sword.fixture = love.physics.newFixture(gary_sword.body, gary_sword.shape, 2)
    gary_sword.body:setFixedRotation(true)
    gary_sword.type = "melee weapon"
    gary_sword.fixture:setUserData(gary_sword)
    gary_sword.body:setActive(false)
    gary_sword.fixture:setCategory(2)
    gary_sword.fixture:setMask(2)
    gary_sword.timer = 0
    gary_sword.attacktime = 1
end

function UpdateGaryAttack(dt)
    gary_sword.position = vector2.new(gary.body:getPosition())
    gary_sword.body:setPosition(gary.position.x + 40, gary.position.y)
    
    local attacking = gary_sword.body:isActive() -- setting a timer for the sword activated
    if attacking then
        gary_sword.timer = gary_sword.timer + dt
        if gary_sword.timer >= gary_sword.attacktime then
            attacking = false
            gary_sword.timer = 0
            gary_sword.body:setActive(false)
        end
    end
end


function DrawGaryAttack()
    love.graphics.setColor(1, 1, 1)
    if gary_sword.body:isActive() and gary.health <= 5 and gary.health > 0 then
        local swordSprites = sprites.sword_right
        local velx, vely = gary.body:getLinearVelocity()

        if velx > 0 then
            swordSprites = sprites.sword_right
        elseif velx < 0 then
            swordSprites = sprites.sword
            gary_sword.body:setPosition(gary.position.x - 40, gary.position.y)
        elseif vely > 0 then
            swordSprites = sprites.sword_down
            gary_sword.body:setPosition(gary.position.x, gary.position.y + 40)
        elseif vely < 0 then
            swordSprites = sprites.sword_up
            gary_sword.body:setPosition(gary.position.x, gary.position.y - 40)
        end

        love.graphics.draw(swordSprites, gary_sword.body:getX(), gary_sword.body:getY(), gary.body:getAngle(),
            1, 1, swordSprites:getWidth() / 2, swordSprites:getHeight() / 2)
    end
end