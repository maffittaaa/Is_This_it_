sword = {}

function LoadGaryAttack(world)
    sword.body = love.physics.newBody(world, gary.body:getX() - 40, 100, "dynamic")
    sword.shape = love.physics.newRectangleShape(sprites.sword:getWidth(), sprites.sword:getHeight())
    sword.fixture = love.physics.newFixture(sword.body, sword.shape, 2)
    sword.body:setFixedRotation(true)
    sword.fixture:setUserData("melee weapon")
    sword.body:setActive(false)
    sword.fixture:setCategory(2)
    sword.fixture:setMask(2)
    sword.timer = 10
end

function UpdateGaryAttack()
    sword.position = vector2.new(gary.body:getPosition())
    sword.body:setPosition(gary.position.x - 40, gary.position.y)

    -- if sword.body:isActive() then
    --     sword.timer = sword.timer - 1
    --     if sword.timer <= 10 and sword.timer > 0 then
    --         sword.body:setActive(true)
    --     elseif sword.timer <= 0 then
    --         sword.body:setActive(false)
    --     end
    -- end
end

function DrawGaryAttack()
    if sword.body:isActive() and gary.health <= 5 and gary.health > 0 then
        love.graphics.draw(sprites.sword, sword.body:getX(), sword.body:getY(), sword.body:getAngle(),
            1, 1, sprites.sword:getWidth() / 2, sprites.sword:getHeight() / 2)
    end
end
