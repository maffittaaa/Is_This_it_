require "Valkyries/valkyrie"
require "MainCharacter/gary"
require "Sprites/sprites"

bullets = {}

function LoadValkyrieRangedAttack(world)
    bullets.body = love.physics.newBody(world, valkyries[1].position.x + 20, 500, "dynamic")
    bullets.shape = love.physics.newRectangleShape(sprites.arrow:getWidth(), sprites.arrow:getHeight())
    bullets.fixture = love.physics.newFixture(bullets.body, bullets.shape, 1)
    bullets.maxvelocity = 200
    bullets.body:setFixedRotation(true)
    bullets.position = vector2.new(valkyries[1].body:getPosition())
    bullets.timer = 0.5
    bullets.cooldown = 60
    bullets.body:setActive(false)
    canShoot = false
    bullets.fixture:setSensor(true)
    bullets.fixture:setUserData("ArrowAttack")
end

function UpdateValkyrieRangedAttack(dt)
    print(valkyries[1].playerInSight)

    if bullets.body:isActive() and bullets.cooldown > 0 then
        bullets.cooldown = bullets.cooldown - 1
    else
        bullets.body:setActive(false)
        bullets.cooldown = 60
    end

    if valkyries[1].playerInSight == true and valkyries[1].isRanging == true then
        canShoot = true
        bullets.timer = bullets.timer + dt
        -- bullets.cooldown = bullets.cooldown - 1
        if not bullets.body:isActive() then
            local playerDirection = vector2.sub(gary.position, vector2.new(valkyries[1].body:getPosition()))
            playerDirection = vector2.norm(playerDirection)
            force = vector2.mult(playerDirection, 200)
        end
        bullets.body:setActive(true)
        local rotation = math.atan2(gary.position.y, gary.position.x)
        bullets.body:setAngle(rotation)
        bullets.body:setLinearVelocity(force.x, force.y)
    else
        bullets.position = vector2.new(valkyries[1].body:getPosition())
        bullets.body:setPosition(valkyries[1].position.x + 20, valkyries[1].position.y)
    end
end

function DrawValkyrieAttack()
    if valkyries[1].health > 0 and valkyries[1].playerInSight == true then
        love.graphics.draw(sprites.arrow, bullets.body:getX(), bullets.body:getY(),
            bullets.body:getAngle(), 1, 1, sprites.arrow:getWidth() / 2, sprites.arrow:getHeight() / 2)
    end
end
