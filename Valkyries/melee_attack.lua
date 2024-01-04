require "Valkyries/valkyrie"


function CreateSword(world, i)
    local trigger = {}
    trigger.body = love.physics.newBody(world, valkyrie.body:getX() - 30, valkyrie.body:getY(), "static")
    trigger.shape = love.physics.newRectangleShape(40, 70)
    trigger.fixture = love.physics.newFixture(trigger.body, trigger.shape, 2)
    trigger.valkyrie = valkyrie
    trigger.id = i
    trigger.fixture:setSensor(true)
    trigger.type = "melee weapon valkyrie"
    trigger.fixture:setUserData(trigger)
    trigger.timer = 0
    return trigger
end

function UpdateValkyrieSword(world, dt)
    for i, valkyrie in ipairs(valkyries) do
        if valkyrie.isMeleeing == true and valkyrie.health > 0 and valkyrie.animation_timer_a > 0.1 then
            sword = CreateSword(world, i)
            valkyrie.sword.position = vector2.new(valkyrie.body:getPosition())
            valkyrie.sword.body:setPosition(valkyrie.position.x - 30, valkyrie.position.y)
        end
        if valkyrie.sword.timer > 0 then
            valkyrie.sword.timer = valkyrie.sword.timer - dt
        end
    end
end

function DrawValkyrieSword()
    for key, valkyrie in ipairs(valkyries) do
        if valkyrie.health > 0 and valkyrie.isMeleeing == true and valkyrie.animation_frame_a == 3 then
            love.graphics.rectangle("line", valkyrie.body:getX() - 30, valkyrie.body:getY(), 40, 50)
        end
    end
end

function ProcessSwordOnPlayer(gary, trigger)
    if trigger.timer <= 0 then
        gary.health = gary.health - 0.5
        PushGaryBackValkyries(trigger.id)
        trigger.timer = 1
    end
end

function BeginContactValkyrieSword(fixtureA, fixtureB)
    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "melee weapon valkyrie" then
        if valkyries[fixtureB:getUserData().id].isMeleeing == true then
            ProcessSwordOnPlayer(fixtureA:getUserData(), fixtureB:getUserData())
        end
    end

    if fixtureA:getUserData().type == "melee weapon valkyrie" and fixtureB:getUserData().type == "player" then
        if valkyries[fixtureA:getUserData().id].isMeleeing == true then
            ProcessSwordOnPlayer(fixtureB:getUserData(), fixtureA:getUserData())
        end
    end
end
