collectible_key = {}
collectible_lifes = { life1 = {}, life2 = {}, life3 = {} }
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

    collectible_lifes.life1.body = love.physics.newBody(world, 300, 700, "static") -- LIVES
    collectible_lifes.life1.shape = love.physics.newRectangleShape(sprites.life:getWidth(), sprites.life:getHeight())
    collectible_lifes.life1.fixture = love.physics.newFixture(collectible_lifes.life1.body, collectible_lifes.life1
        .shape, 2)
    collectible_lifes.life1.fixture:setSensor(true)
    collectible_lifes.life1.type = "life"
    collectible_lifes.life1.fixture:setUserData(collectible_lifes.life1)

    collectible_lifes.life2.body = love.physics.newBody(world, 500, 1000, "static")
    collectible_lifes.life2.shape = love.physics.newRectangleShape(sprites.life:getWidth(), sprites.life:getHeight())
    collectible_lifes.life2.fixture = love.physics.newFixture(collectible_lifes.life2.body, collectible_lifes.life2
        .shape, 2)
    collectible_lifes.life2.fixture:setSensor(true)
    collectible_lifes.life2.type = "life2"
    collectible_lifes.life2.fixture:setUserData(collectible_lifes.life2)

    collectible_lifes.life3.body = love.physics.newBody(world, 800, 1300, "static")
    collectible_lifes.life3.shape = love.physics.newRectangleShape(sprites.life:getWidth(), sprites.life:getHeight())
    collectible_lifes.life3.fixture = love.physics.newFixture(collectible_lifes.life3.body, collectible_lifes.life3
        .shape, 2)
    collectible_lifes.life3.fixture:setSensor(true)
    collectible_lifes.life3.type = "life3"
    collectible_lifes.life3.fixture:setUserData(collectible_lifes.life3)
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
    if collectible_lifes.counter == 0 and collectible_lifes.counter <= 3 then
        love.graphics.draw(sprites.life, collectible_lifes.life1.body:getX(), collectible_lifes.life1.body:getY(),
            collectible_lifes.life1.body:getAngle(),
            1, 1, sprites.life:getWidth() / 2, sprites.life:getHeight() / 2)

        love.graphics.draw(sprites.life, collectible_lifes.life2.body:getX(), collectible_lifes.life2.body:getY(),
            collectible_lifes.life2.body:getAngle(),
            1, 1, sprites.life:getWidth() / 2, sprites.life:getHeight() / 2)

        love.graphics.draw(sprites.life, collectible_lifes.life3.body:getX(), collectible_lifes.life3.body:getY(),
            collectible_lifes.life3.body:getAngle(),
            1, 1, sprites.life:getWidth() / 2, sprites.life:getHeight() / 2)
    end
    if collectible_key.counter == 0 then
        love.graphics.draw(sprites.key, collectible_key.body:getX(), collectible_key.body:getY(),
            collectible_key.body:getAngle(), 1, 1, sprites.key:getWidth() / 2, sprites.key:getHeight() / 2)
    end
    if message ~= nil then
        love.graphics.draw(sprites.inventory, camera.x, camera.y - 600, 0, 3, 3)
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(love.graphics.newFont(15))
        love.graphics.print(message.message, camera.x + 35, camera.y - 539)
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
            success = love.window.showMessageBox(title, message)
            collectible_key.counter = 1
        end
    end
    if fixtureB:getUserData().type == "life" and fixtureA:getUserData().type == "player" then -- colision for collectibles(lives)
        if gary.health == 5 then
            success = love.window.showMessageBox(title, message3, "error")
            collectible_lifes.counter = collectible_lifes.counter
        elseif gary.health < 5 and gary.health >= 0 and collectible_lifes.counter <= 3 then
            success = love.window.showMessageBox(title, message2)
            collectible_lifes.counter = collectible_lifes.counter + 1
            gary.health = gary.health + 1
        end
    end
    if fixtureB:getUserData().type == "player" and fixtureA:getUserData().type == "life" then -- colision for collectibles(lives)
        if gary.health == 5 then
            success = love.window.showMessageBox(title, message3, "error")
            collectible_lifes.counter = collectible_lifes.counter
        elseif gary.health < 5 and gary.health >= 0 and collectible_lifes.counter <= 3 then
            success = love.window.showMessageBox(title, message2)
            collectible_lifes.counter = collectible_lifes.counter + 1
            gary.health = gary.health + 1
        end
    end
end
