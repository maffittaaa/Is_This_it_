death = {}
trigger = {}

function LoadDeath(world)
    death.body = love.physics.newBody(world, 95 * 32, 263 * 32, "dynamic")
    -- death.body = love.physics.newBody(world, 1000, 1000, "dynamic")

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
    death.garyInSight = false
    death.body:setFixedRotation(true)
    death.animation_frame = 1
    death.animation_timer = 0
    death.health = 10
    death.type = "boss"
    death.fixture:setUserData(death)
    death.facingRight = true

    CreateScythe(world, death)
    death.trigger = trigger
end

function CreateScythe(world, death)
    trigger.body = love.physics.newBody(world, death.body:getX() + 50, death.body:getY() - 20, "static")
    trigger.shape = love.physics.newRectangleShape(40, 70)
    trigger.fixture = love.physics.newFixture(trigger.body, trigger.shape, 2)
    trigger.death = death
    trigger.body:setActive(false)
    trigger.fixture:setSensor(true)
    trigger.type = "death attack"
    trigger.fixture:setUserData(trigger)
end

function UpdateDeath(dt)
    if death.health > 0 then
        if death.facingRight == true then
            death.trigger.body:setPosition(death.body:getX() + 50, death.body:getY() - 20)
        else
            death.trigger.body:setPosition(death.body:getX() - 100, death.body:getY() - 20)
        end
        death.animation_timer = death.animation_timer + dt
        if death.animation_timer > 0.1 then
            death.animation_frame = death.animation_frame + 1
            if death.animation_frame > 4 then
                death.animation_frame = 1
            end
            death.animation_timer = 0
        end
    end

    if death.health <= 0 then
        death.fixture:destroy()
    end
end

function BeginContactDeath(fixtureA, fixtureB)
    if fixtureA:getUserData().type == "melee weapon" and fixtureB:getUserData().type == "boss" then
        death = fixtureB:getUserData()
        if death.health <= 10 and valkyries[i].health > 0 then
            death.health = valkyries[i].health - 1
        end
    end

    if fixtureA:getUserData().type == "boss" and fixtureB:getUserData().type == "melee weapon" then
        death = fixtureA:getUserData()
        if death.health <= 10 and death.health > 0 then
            death.health = death.health - 1
        end
    end
end
