gary = {}
local force = 500

destroy_gary_fixture = false
local inCabin = false
local inMasmorra = false
local trigger_door = false
local trigger_door_mas = false
timer_camera = 0
local repeatOnce = true

function LoadGary(world, x, y)
    gary.body = love.physics.newBody(world, x, y, "dynamic")
    gary.shape = love.physics.newRectangleShape(sprites.gary:getWidth() - 10, sprites.gary:getHeight() - 50)
    gary.fixture = love.physics.newFixture(gary.body, gary.shape, 1)
    gary.maxvelocity = 200
    gary.fixture:setFriction(1)
    gary.body:setFixedRotation(true)
    gary.fixture:setCategory(2)
    gary.fixture:setMask(2)
    gary.health = 5
    gary.knockX = 0
    gary.knockY = 0
    gary.type = "player"
    gary.fixture:setUserData(gary)
end

function UpdateGary(dt)
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


    gary.position = vector2.new(gary.body:getPosition())

    local garyVelocity = vector2.new(0, 0)

    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        garyVelocity.x = garyVelocity.x + 250
    end

    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        garyVelocity.x = garyVelocity.x - 250
    end

    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        garyVelocity.y = garyVelocity.y - 250
    end

    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        garyVelocity.y = garyVelocity.y + 250
    end
    GaryKnock(dt)
    gary.body:setLinearVelocity(gary.knockX + garyVelocity.x, gary.knockY + garyVelocity.y)
end

function DrawGary()
    if gary.health <= 5 and gary.health > 0 then
        local velx, vely = gary.body:getLinearVelocity()
        if velx >= 0 then
            love.graphics.draw(sprites.gary, gary.body:getX(), gary.body:getY(), gary.body:getAngle(),
                1, 1, sprites.gary:getWidth() / 2, sprites.gary:getHeight() / 2)
            love.graphics.setColor(1, 0, 0)
            love.graphics.polygon("line", gary.body:getWorldPoints(gary.shape:getPoints()))
        else
            love.graphics.draw(sprites.gary, gary.body:getX(), gary.body:getY(), gary.body:getAngle(),
                -1, 1, sprites.gary:getWidth() / 2, sprites.gary:getHeight() / 2)
        end
    elseif gary.health <= 0 then
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("LOSER! YOU ARE DEAD", 500, 500)
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

function PushGaryBack(id)
    garyDiretion = vector2.sub(gary.position, vector2.new(ghosts[id].body:getPosition()))
    garyDiretion = vector2.norm(garyDiretion)

    local force = vector2.mult(garyDiretion, force)
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

function EndContactGary(fixtureA, fixtureB)
    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "triggerCbn" then

    end
end
