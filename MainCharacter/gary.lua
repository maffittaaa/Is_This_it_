gary = {}
local force = 500

destroy_gary_fixture = false
local inCabin = false
local inMasmorra = false
local trigger_door = false
local trigger_door_mas = false
timer_camera = 0
local repeatOnce = true

player_velocity = 200

function LoadGary(world, x, y)
    gary.body = love.physics.newBody(world, x, y, "dynamic")

    gary.idle = {}
    for i = 1, 5, 1 do
        gary.idle[i] = love.graphics.newImage("Sprites/gary_idle_" .. i .. ".png")
        gary.shape = love.physics.newRectangleShape(gary.idle[i]:getWidth(), gary.idle[i]:getHeight())
    end
    
    gary.right = {}
    for i = 1, 5, 1 do
        gary.right[i] = love.graphics.newImage("Sprites/gary_right_" .. i .. ".png")
    end
    
    gary.left = {}
    for i = 1, 5, 1 do
        gary.left[i] = love.graphics.newImage("Sprites/gary_left_" .. i .. ".png")
    end

    gary.up = {}
    for i = 1, 5, 1 do
        gary.up[i] = love.graphics.newImage("Sprites/gary_up_" .. i .. ".png")
    end
    
    gary.fixture = love.physics.newFixture(gary.body, gary.shape, 1)
    gary.maxvelocity = 200
    gary.fixture:setFriction(1)
    gary.body:setFixedRotation(true)
    gary.fixture:setCategory(2)
    gary.fixture:setMask(2)
    gary.health = 5
    gary.animation_frame = 1
    gary.animation_timer = 0
    gary.knockX = 0
    gary.knockY = 0
    gary.type = "player"
    gary.fixture:setUserData(gary)
end

function UpdateGary(dt)
    gary.position = vector2.new(gary.body:getPosition())

    if repeatOnce == true then
        timer_camera = timer_camera + dt

        if timer_camera > 1 then
            if inCabin == true and trigger_door == true then
                gary.body:setPosition(doors[1].body:getX(), doors[1].body:getY() + 100)
                inCabin = false
                trigger_door = false
                return
            elseif inCabin == false and trigger_door == true then
                gary.body:setPosition(doors[2].body:getX() + 100, doors[2].body:getY())
                inCabin = true
                trigger_door = false
                return
            end

            if inMasmorra == true and trigger_door_mas == true then
                gary.body:setPosition(doorsMasmorra[1].body:getX(), doorsMasmorra[1].body:getY() + 100)
                inMasmorra = false
                trigger_door_mas = false
                return
            elseif inMasmorra == false and trigger_door_mas == true then
                gary.body:setPosition(doorsMasmorra[2].body:getX() + 100, doorsMasmorra[2].body:getY())
                inMasmorra = true
                trigger_door_mas = false
            end
        end

        if timer_camera > 1.5 then
            camera:fade(1, { 0, 0, 0, 0 })
            timer_camera = 0
            repeatOnce = false
        end
    end



    garyVelocity = vector2.new(0, 0)

    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        garyVelocity.x = garyVelocity.x + player_velocity
        gary.animation_timer = gary.animation_timer + dt
        if gary.animation_timer > 0.1 then -- when time gets to 0.1
            gary.animation_frame = gary.animation_frame + 1 -- increases the anim. index
            if gary.animation_frame > 4 then
                gary.animation_frame = 1
            end
            gary.animation_timer = 0 -- reset the time counter
        end
    end

    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        garyVelocity.x = garyVelocity.x - player_velocity
        gary.animation_timer = gary.animation_timer + dt
        if gary.animation_timer > 0.1 then -- when time gets to 0.1
            gary.animation_frame = gary.animation_frame + 1 -- increases the anim. index
            if gary.animation_frame > 4 then
                gary.animation_frame = 1
            end -- animation loop
            gary.animation_timer = 0 -- reset the time counter
        end
    end

    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        garyVelocity.y = garyVelocity.y - player_velocity
        gary.animation_timer = gary.animation_timer + dt
        if gary.animation_timer > 0.1 then -- when time gets to 0.1
            gary.animation_frame = gary.animation_frame + 1 -- increases the anim. index
            if gary.animation_frame > 4 then
                gary.animation_frame = 1
            end -- animation loop
            gary.animation_timer = 0 -- reset the time counter
        end
    end

    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        garyVelocity.y = garyVelocity.y + player_velocity
        gary.animation_timer = gary.animation_timer + dt
        if gary.animation_timer > 0.1 then -- when time gets to 0.1
            gary.animation_frame = gary.animation_frame + 1 -- increases the anim. index
            if gary.animation_frame > 4 then
                gary.animation_frame = 1
            end -- animation loop
            gary.animation_timer = 0 -- reset the time counter
        end
    end
    GaryKnock(dt)
    gary.body:setLinearVelocity(gary.knockX + garyVelocity.x, gary.knockY + garyVelocity.y)
end

function DrawGary()
    if gary.health > 0 then
        local garySprites = gary.idle[gary.animation_frame]
        local velx, vely = gary.body:getLinearVelocity()
        if velx > 0 then
            garySprites = gary.right[gary.animation_frame]
        elseif velx < 0 then
            garySprites = gary.left[gary.animation_frame]
        elseif vely >= 0 then
            garySprites = gary.idle[gary.animation_frame]
        elseif vely < 0 then
            garySprites = gary.up[gary.animation_frame]
        end
        love.graphics.draw(garySprites, gary.body:getX(), gary.body:getY(), gary.body:getAngle(),
            1, 1, garySprites:getWidth() / 2, garySprites:getHeight() / 2)
    elseif gary.health <= 0 then
        if destroy_gary_fixture == false then
            gary.fixture:destroy()
            destroy_gary_fixture = true
        end
        gary.body:setLinearVelocity(0, 0)
    end
end

function GaryKnock(dt)
    if gary.knockX > 0 then
        gary.knockX = gary.knockX - dt * force
    elseif gary.knockY < 0 then
        gary.knockX = gary.knockX + dt * force
    end
    if gary.knockY > 0 then
        gary.knockY = gary.knockY - dt * force
    elseif gary.knockY < 0 then
        gary.knockY = gary.knockY + dt * force
    end
end

function PushGaryBack(i)
    local garyDirection = vector2.sub(gary.position, vector2.new(ghosts[i].body:getPosition()))
    garyDirection = vector2.norm(garyDirection)

    local force = vector2.mult(garyDirection, force)
    gary.knockX = force.x
    gary.knockY = force.y
end

function GetPlayerPosition()
    return vector2.new(gary.body:getX(), gary.body:getY())
end

function BeginContactGary(fixtureA, fixtureB)
    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "triggerCbn" then
        if collectible_key.counter == 1 then
            camera:fade(1, { 0, 0, 0, 1 })
            repeatOnce = true
            trigger_door = true
        end
    end

    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "triggerMas" then
        if collectible_key.counter == 1 then
            camera:fade(1, { 0, 0, 0, 1 })
            repeatOnce = true
            trigger_door_mas = true
        end
    end
end
