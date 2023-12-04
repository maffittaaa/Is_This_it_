require "Valkyries/valkyrie"
require "MainCharacter/gary"

sword = {}
function CreateSword(world, i)
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
    return sword
end

function UpdateValkyrieSword(world)
    for i, valkyrie in ipairs(valkyries) do
        if valkyrie.isMeleeing == true and valkyrie.health > 0 then
            -- print("ooooooooooooo")
            sword = CreateSword(world, valkyries[i].parent)
            sword.position = vector2.new(valkyrie.body:getPosition())
            sword.body:setPosition(valkyrie.position.x - 60, valkyrie.position.y)
        end
    end
end

function DrawValkyrieSword()
    for key, valkyrie in ipairs(valkyries) do
        if valkyrie.health > 0 and valkyrie.isMeleeing == true then
            love.graphics.draw(sprites.sword, valkyrie.body:getX() - 60 , valkyrie.body:getY(),
            valkyrie.body:getAngle(), 1, 1, sprites.sword_right:getWidth() / 2, sprites.sword_right:getHeight() / 2)
            -- love.graphics.setColor (1, 0, 0)
            -- love.graphics.polygon("line", sword.body:getWorldPoints(sword.shape:getPoints()))
        end
    end
end

function ProcessSwordOnPlayer(gary,sword)
    -- sword = sword.type
    print(gary)
    if valkyrie.isMeleeing == true then
        print ("aaaaaaaa")
        gary.health = gary.health - 1
    end
end

function BeginContactValkyrieSword(fixtureA, fixtureB)
    -- print(fixtureA:getUserData().type, fixtureB:getUserData().type)
    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "melee weapon valkyrie" then
            sword = fixtureB:getUserData()
            ProcessSwordOnPlayer(fixtureA:getUserData().type, fixtureB:getUserData().type)
            -- print(ProcessSwordOnPlayer(fixtureA:getUserData().type, fixtureB:getUserData().type))

    end
    if fixtureB:getUserData().type == "melee weapon valkyrie" and fixtureA:getUserData().type == "valkyrie" then
            sword = fixtureB:getUserData()
            ProcessSwordOnPlayer(fixtureA:getUserData().type, fixtureB:getUserData().type)

    end
end
