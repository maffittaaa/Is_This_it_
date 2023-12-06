collectible_key = {}
collectible_lifes = { life1 = {} }
local message

function LoadCollectibles(world)
    collectible_lifes.counter = 0

    collectible_key.body = love.physics.newBody(world, 1000, 1000, "static") -- KEY
    collectible_key.shape = love.physics.newRectangleShape(sprites.key:getWidth(), sprites.key:getHeight())
    collectible_key.fixture = love.physics.newFixture(collectible_key.body, collectible_key.shape, 1)
    collectible_key.counter = 0
    collectible_key.fixture:setSensor(true)
    collectible_key.type = "key"
    collectible_key.fixture:setUserData(collectible_key)

    collectible_lifes.life1.body = love.physics.newBody(world, 1600, 1300, "static")
    collectible_lifes.life1.shape = love.physics.newRectangleShape(sprites.life:getWidth(), sprites.life:getHeight())
    collectible_lifes.life1.fixture = love.physics.newFixture(collectible_lifes.life1.body, collectible_lifes.life1
        .shape, 2)
    collectible_lifes.life1.fixture:setSensor(true)
    collectible_lifes.life1.type = "life1"
    collectible_lifes.life1.fixture:setUserData(collectible_lifes.life1)
end

function UpdateCollectibles(dt)
    if message ~= nil then
        message.timer = message.timer - dt
        if message.timer <= 0 then
            message = nil
        end
    end
end

function DrawCollectibles()
    if collectible_key.counter == 0 then
        love.graphics.draw(sprites.key, collectible_key.body:getX(), collectible_key.body:getY(),
            collectible_key.body:getAngle(), 1, 1, sprites.key:getWidth() / 2, sprites.key:getHeight() / 2)
    end
    if collectible_lifes.counter == 0 and collectible_lifes.counter <= 3 then
        love.graphics.draw(sprites.life, collectible_lifes.life1.body:getX(), collectible_lifes.life1.body:getY(),
            collectible_lifes.life1.body:getAngle(),
            1, 1, sprites.life:getWidth() / 2, sprites.life:getHeight() / 2)
    end
    if message ~= nil then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(sprites.inventory, camera.x - 50, camera.y - 400, 0, 2, 2)
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(love.graphics.newFont(12))
        love.graphics.print(message.message, camera.x - 35, camera.y - 360)
        love.graphics.setColor(1, 1, 1)
    end
end

function BeginContactCollectibles(fixtureA, fixtureB)
    if fixtureB:getUserData().type == "key" and fixtureA:getUserData().type == "player" then -- colision for collectibles(key)
        if collectible_key.counter == 0 then
            message = CreateMessage("inventory: 1 key")
            collectible_key.counter = 1
        end
    end
    if fixtureB:getUserData().type == "player" and fixtureA:getUserData().type == "key" then -- colision for collectibles(key)
        if collectible_key.counter == 0 then
            message = CreateMessage("inventory: 1 key")
            collectible_key.counter = 1
        end
    end
    if fixtureB:getUserData().type == "life1" and fixtureA:getUserData().type == "player" then -- colision for collectibles(lives)
        if gary.health == 5 then
            message = CreateMessage("Full Health")
            collectible_lifes.counter = collectible_lifes.counter
        elseif gary.health < 5 and gary.health >= 0 and collectible_lifes.counter <= 3 then
            message = CreateMessage("1 life")
            collectible_lifes.counter = collectible_lifes.counter + 1
            gary.health = gary.health + 1
        end
    end
    if fixtureB:getUserData().type == "player" and fixtureA:getUserData().type == "life1" then -- colision for collectibles(lives)
        if gary.health == 5 then
            message = CreateMessage("Can't pick up. Full Health")
            collectible_lifes.counter = collectible_lifes.counter
        elseif gary.health < 5 and gary.health >= 0 and collectible_lifes.counter <= 3 then
            message = CreateMessage("1 life")
            collectible_lifes.counter = collectible_lifes.counter + 1
            gary.health = gary.health + 1
        end
    end
end
