require "Valkyries/valkyrie"
require "MainCharacter/gary"

function CreateSword(world, i)
    local sword = {}
    sword.body = love.physics.newBody(world, valkyrie.body:getX() - 60, valkyrie.body:getY(), "dynamic")
    sword.shape = love.physics.newRectangleShape(sprites.sword_right:getWidth(),
        sprites.sword_right:getHeight())
    sword.fixture = love.physics.newFixture(sword.body, sword.shape, 2)
    sword.body:setFixedRotation(true)
    sword.valkyrie = valkyrie
    sword.id = i
    sword.type = "melee weapon valkyrie"
    sword.fixture:setSensor(true)
    sword.fixture:setUserData(sword)
    sword.timer = 0
    return sword
end

function UpdateValkyrieSword(world, dt)
    for i, valkyrie in ipairs(valkyries) do
        if valkyrie.isMeleeing == true and valkyrie.health > 0 then
            -- print("ooooooooooooo")
            valkyrie.sword.position = vector2.new(valkyrie.body:getPosition())
            valkyrie.sword.body:setPosition(valkyrie.position.x - 60, valkyrie.position.y)
        end
        if valkyrie.sword.timer > 0 then
            valkyrie.sword.timer = valkyrie.sword.timer - dt
        end
    end
end

function DrawValkyrieSword()
    for key, valkyrie in ipairs(valkyries) do
        if valkyrie.health > 0 and valkyrie.isMeleeing == true then
            love.graphics.draw(sprites.sword, valkyrie.body:getX() - 60, valkyrie.body:getY(),
                valkyrie.body:getAngle(), 1, 1, sprites.sword_right:getWidth() / 2, sprites.sword_right:getHeight() / 2)
            love.graphics.setColor(1, 0, 0)
            love.graphics.polygon("line", valkyrie.sword.body:getWorldPoints(valkyrie.sword.shape:getPoints()))
        end
    end
end

function ProcessSwordOnPlayer(gary, sword)
    -- printTable(gary)
    if sword.timer <= 0 then
        print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
        gary.health = gary.health - 1
        PushGaryBack(sword.id)
        sword.timer = 1
    end
end

function BeginContactValkyrieSword(fixtureA, fixtureB)
    if invencible == false then
        
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
end
