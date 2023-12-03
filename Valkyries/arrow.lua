require "Valkyries/valkyrie"
require "MainCharacter/gary"
require "Sprites/sprites"

bullets = {}
local cooldown_sec = 2
local cooldown_intervalo = 0

function CreateArrow(world, i, valkyrie)
    arrow = {}
    arrow.body = love.physics.newBody(world, valkyrie.position.x + 20, valkyrie.position.y - 20, "dynamic")
    arrow.shape = love.physics.newRectangleShape(sprites.arrow:getWidth(), sprites.arrow:getHeight())
    arrow.fixture = love.physics.newFixture(arrow.body, arrow.shape, 1)
    arrow.maxvelocity = 200
    arrow.body:setFixedRotation(true)
    arrow.position = vector2.new(valkyrie.body:getPosition())
    arrow.body:setActive(false)
    arrow.fixture:setSensor(true)
    arrow.type = "ArrowAttack"
    arrow.fixture:setUserData({ arrow, id = i })
    return arrow
end

function RemoveFromBulletsArray(id)
    local keyToRemove = -1
    for key, arrow in ipairs(bullets) do
        if (arrow.fixture:getUserData().id == id) then
            keyToRemove = key
        end
    end
    if (keyToRemove > -1) then
        table.remove(bullets, keyToRemove)
    end
end

function UpdateValkyrieRangedAttack(world, dt)
    cooldown_intervalo = cooldown_intervalo + dt
    if cooldown_intervalo > cooldown_sec then
        canShoot = true
        cooldown_intervalo = 0
    else
        canShoot = false
    end
    --print(" ", cooldown_intervalo, ", can shoot? ", canShoot)
    for key, valkyrie in ipairs(valkyries) do
        if canShoot and valkyrie.health > 0 and valkyrie.playerInSight == true and valkyrie.isRanging == true then
            arrow = CreateArrow(world, #bullets + 1, valkyrie)
            local playerDirection = vector2.sub(gary.position, vector2.new(valkyrie.body:getPosition()))
            playerDirection = vector2.norm(playerDirection)
            force = vector2.mult(playerDirection, 200)
            arrow.body:setActive(true)
            arrow.body:setAngle(math.atan2(force.y, force.x))
            arrow.body:setLinearVelocity(force.x, force.y)
            table.insert(bullets, arrow)
        end
    end
end

function DrawValkyrieAttack()
    for i, c in ipairs(bullets) do
        love.graphics.draw(sprites.arrow, c.body:getX(), c.body:getY(),
            c.body:getAngle(), 1, 1, sprites.arrow:getWidth() / 2, sprites.arrow:getHeight() / 2)
    end
end

function BeginContactArrows(fixtureA, fixtureB)
    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "ArrowAttack" then
        gary.health = gary.health - 1
        print(fixtureB:getUserData().id)
        RemoveFromBulletsArray(fixtureB:getUserData().id)
    end
    if fixtureA:getUserData().type == "ArrowAttack" and fixtureB:getUserData().type == "player" then
        gary.health = gary.health - 1
        print(fixtureB:getUserData().id)
        RemoveFromBulletsArray(fixtureB:getUserData().id)
    end
end
