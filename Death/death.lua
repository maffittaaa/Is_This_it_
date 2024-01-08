death = {}

function LoadDeath(world)
    death.body = love.physics.newBody(world, 95 * 32, 263 * 32, "dynamic")

    death.idle = {}
    for i = 1, 4, 1 do
        death.idle[i] = love.graphics.newImage("Sprites/death_idle_" .. i .. ".png")
    end

    death.right = {}
    for i = 1, 4, 1 do
        death.right[i] = love.graphics.newImage("Sprites/death_right_" .. i .. ".png")
    end

    death.left = {}
    for i = 1, 4, 1 do
        death.left[i] = love.graphics.newImage("Sprites/death_left_" .. i .. ".png")
    end

    death.shape = love.physics.newRectangleShape(30, 60)
    death.fixture = love.physics.newFixture(death.body, death.shape, 1)
    death.maxvelocity = 200
    death.fixture:setFriction(10)
    death.garyInSight = true
    death.body:setFixedRotation(true)
    death.animation_frame = 1
    death.animation_timer = 0
    death.health = 10
    death.timer = 2
    death.type = "boss"
    death.fixture:setUserData(death)

    death.trigger = {}
    death.trigger.body = love.physics.newBody(world, death.body:getX() - 30, 263 * 32, "static")
    death.trigger.shape = love.physics.newRectangleShape(40, 70)
    death.trigger.fixture = love.physics.newFixture(death.trigger.body, death.trigger.shape, 2)
    death.trigger.fixture:setSensor(true)
    death.trigger.type = "death attack"
    death.trigger.fixture:setUserData(death) -- trigger de lado
end

function UpdateDeath(dt)
    death.animation_timer = death.animation_timer + dt
    if death.animation_timer > 0.1 then
        death.animation_frame = death.animation_frame + 1
        if death.animation_frame > 4 then
            death.animation_frame = 1
        end
        death.animation_timer = 0
    end
end
