require "Valkyries/valkyrie"
require "MainCharacter/gary"

function LoadSword(world, valkyrie)
    for key, valkyrie in ipairs(valkyries) do
        valkyrie.sword = {}
        valkyrie.sword.body = love.physics.newBody(world, valkyrie.body:getX() - 60, valkyrie.body:getY(), "dynamic")
        valkyrie.sword.shape = love.physics.newRectangleShape(sprites.sword_right:getWidth(),
            sprites.sword_right:getHeight())
        valkyrie.sword.fixture = love.physics.newFixture(valkyrie.sword.body, valkyrie.sword.shape, 2)
        valkyrie.sword.body:setFixedRotation(true)
        valkyrie.sword.type = "melee weapon valkyrie"
        valkyrie.sword.fixture:setUserData(valkyrie.sword)
        valkyrie.sword.body:setActive(false)
    end
end

function UpdateValkyrieSword()
    for key, valkyrie in ipairs(valkyries) do
        valkyrie.sword.position = vector2.new(valkyrie.body:getPosition())
        valkyrie.sword.body:setPosition(valkyrie.position.x - 60, valkyrie.position.y)
        if valkyrie.isRanging == false and valkyrie.isMeleeing == true then
            valkyrie.sword.body:setActive(true)
        else
            valkyrie.sword.body:setActive(false)
        end
    end
end

function DrawValkyrieSword()
    for key, valkyrie in ipairs(valkyries) do
        if valkyrie.health > 0 and valkyrie.isMeleeing == true then
            love.graphics.draw(sprites.sword, valkyrie.sword.body:getX(), valkyrie.sword.body:getY(),
                valkyrie.sword.body:getAngle(),
                1, 1, sprites.sword_right:getWidth() / 2, sprites.sword_right:getHeight() / 2)
        end
    end
end

function BeginContactValkyrieSword(fixtureA, fixtureB)
    print(fixtureA:getUserData().type, fixtureB:getUserData().type)
    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "melee weapon valkyrie" then
        for key, valkyrie in ipairs(valkyries) do
            valkyrie.sword = fixtureB:getUserData()
            if sword.valkyrie.isMeleeing == true and sword.valkyrie.body:isActive() then
                gary.health = gary.health - 1
            end
        end
    end
    if fixtureA:getUserData().type == "melee weapon valkyrie" and fixtureB:getUserData().type == "player" then
        for key, valkyrie in ipairs(valkyries) do
            valkyrie.sword = fixtureB:getUserData()
            if sword.valkyrie.isMeleeing == true and sword.valkyrie.body:isActive() then
                gary.health = gary.health - 1
            end
        end
    end
end
