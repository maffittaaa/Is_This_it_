require "Valkyries/valkyrie"
require "MainCharacter/gary"

function CreateSword(world, valkyrie)
    sword.body = love.physics.newBody(world, valkyrie.body:getX() + 40, valkyrie.position.y - 40, "dynamic")
    sword.shape = love.physics.newRectangleShape(sprites.sword:getWidth(), sprites.sword:getHeight())
    sword.fixture = love.physics.newFixture(sword.body, sword.shape, 2)
    sword.body:setFixedRotation(true)
    sword.type = "melee weapon valkyrie"
    sword.fixture:setUserData(sword)
    sword.body:setActive(false)
    sword.fixture:setCategory(2)
    sword.fixture:setMask(2)
    sword.timer = 0.5
    sword.attacktime = 0.5
end

function PushGaryBack()
    garyDiretion = vector2.sub(gary.position, vector2.new(ghost.body:getPosition()))
    garyDiretion = vector2.norm(garyDiretion)

    local force = vector2.mult(garyDiretion, force)
    gary.knockX = force.x
    gary.knockY = force.y
end
