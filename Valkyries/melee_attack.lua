require "Valkyries/valkyrie"
require "MainCharacter/gary"

valkyrie_sword = {}

function LoadSword(world, valkyrie)
    valkyrie_sword.body = love.physics.newBody(world, valkyrie.body:getX() + 500, valkyrie.body:getY(), "dynamic")
    valkyrie_sword.shape = love.physics.newRectangleShape(sprites.sword_right:getWidth(), sprites.sword_right:getHeight())
    valkyrie_sword.fixture = love.physics.newFixture(valkyrie_sword.body, valkyrie_sword.shape, 2)
    valkyrie_sword.body:setFixedRotation(true)
    valkyrie_sword.type = "melee weapon valkyrie"
    valkyrie_sword.fixture:setUserData(sword)
    valkyrie_sword.body:setActive(false)
end

function UpdateValkyrieSword()
    for key, valkyrie in ipairs(valkyries) do
        valkyrie_sword.position = vector2.new(valkyrie.body:getPosition())
        valkyrie_sword.body:setPosition(valkyrie.position.x + 500, valkyrie.position.y)
        if valkyrie.isRanging == false and valkyrie.isMeleeing == true then
            valkyrie_sword.body:setActive(true)
        end
    end
end

function DrawValkyrieSword()
    print("blewwwwwww")
    -- if valkyrie.health > 0 and valkyrie.isMeleeing == true then
    love.graphics.draw(sprites.sword, valkyrie_sword.body:getX(), valkyrie_sword.body:getY(),
        valkyrie_sword.body:getAngle(),
        1, 1, sprites.sword_right:getWidth() / 2, sprites.sword_right:getHeight() / 2)
    -- end
end

function BeginContactValkyrieSword(fixtureA, fixtureB)
    print(fixtureA:getUserData().type, fixtureB:getUserData().type)
    if valkyrie.isMeleeing == true and valkyrie_sword.body:isActive() then
        if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "melee weapon valkyrie" then
            gary.health = gary.health - 1
        end
    end
    if valkyrie.isMeleeing == true and valkyrie_sword:isActive() then
        if fixtureA:getUserData().type == "melee weapon valkyrie" and fixtureB:getUserData().type == "player" then
            gary.health = gary.health - 1
        end
    end
end
