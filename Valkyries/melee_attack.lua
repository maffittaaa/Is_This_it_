require "Valkyries/valkyrie"


function CreateSword(world, valkyrie)
    local trigger = {}
    trigger.body = love.physics.newBody(world, valkyrie.body:getX() - 30, valkyrie.body:getY(), "static")
    trigger.shape = love.physics.newRectangleShape(40, 70)
    trigger.fixture = love.physics.newFixture(trigger.body, trigger.shape, 2)
    trigger.valkyrie = valkyrie
    --trigger.id = i
    trigger.body:setActive(false)
    trigger.fixture:setSensor(true)
    trigger.type = "melee weapon valkyrie"
    trigger.fixture:setUserData(trigger)
    trigger.timer = 0
    return trigger
end

function UpdateValkyrieSword(world, dt)
    for i, valkyrie in ipairs(valkyries) do
        if valkyrie.isMeleeing and valkyrie.health > 0 then
            --sword = CreateSword(world, i)
            local valkyriePosition = vector2.new(valkyrie.body:getPosition())
            valkyrie.trigger.body:setPosition(valkyriePosition.x - 30, valkyriePosition.y)
           -- if valkyrie.sword.timer > 0 then
           --     valkyrie.sword.timer = valkyrie.sword.timer - dt
                if valkyrie.animation_frame_a == 3 then
                    valkyrie.trigger.body:setActive(true)
                else
                    valkyrie.trigger.body:setActive(false)
                end
        elseif not valkyrie.isMeleeing then
            valkyrie.trigger.body:setActive(false)
        end
    end
end

function DrawValkyrieSword()
    for key, valkyrie in ipairs(valkyries) do
        if valkyrie.health > 0 and valkyrie.isMeleeing == true then
            love.graphics.rectangle("line", valkyrie.body:getX() - 30, valkyrie.body:getY(), 40, 50)
        end
    end
end

function ProcessSwordOnPlayer(gary, trigger)
   -- if trigger.timer <= 0 then
        gary.health = gary.health - 0.5
        PushGaryBackValkyries(trigger.valkyrie)
   -- end
end

function BeginContactValkyrieSword(fixtureA, fixtureB)
    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "melee weapon valkyrie" then
        if fixtureB:getUserData().valkyrie.isMeleeing == true then
            ProcessSwordOnPlayer(fixtureA:getUserData(), fixtureB:getUserData())
        end
    end

    if fixtureA:getUserData().type == "melee weapon valkyrie" and fixtureB:getUserData().type == "player" then
        if fixtureA:getUserData().valkyrie.isMeleeing == true then
            ProcessSwordOnPlayer(fixtureB:getUserData(), fixtureA:getUserData())
        end
    end
end
