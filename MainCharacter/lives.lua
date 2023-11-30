collectible_key = {}
collectible_lifes = { life1 = {}, life2 = {}, life3 = {} }
title = "inventory: "
message = "1 key"
message2 = "x1 life"
message3 = "full health"

function LoadCollectibles(world)
    collectible_lifes.counter = 0

    collectible_key.body = love.physics.newBody(world, 1000, 1000, "static") -- KEY
    collectible_key.shape = love.physics.newRectangleShape(sprites.key:getWidth(), sprites.key:getHeight())
    collectible_key.fixture = love.physics.newFixture(collectible_key.body, collectible_key.shape, 1)
    collectible_key.counter = 0
    collectible_key.fixture:setSensor(true)
    collectible_key.fixture:setUserData("key")

    collectible_lifes.life1.body = love.physics.newBody(world, 300, 700, "static") -- LIVES
    collectible_lifes.life1.shape = love.physics.newRectangleShape(sprites.life:getWidth(), sprites.life:getHeight())
    collectible_lifes.life1.fixture = love.physics.newFixture(collectible_lifes.life1.body, collectible_lifes.life1
        .shape, 2)
    collectible_lifes.life1.fixture:setSensor(true)
    collectible_lifes.life1.fixture:setUserData("life")

    collectible_lifes.life2.body = love.physics.newBody(world, 500, 1000, "static")
    collectible_lifes.life2.shape = love.physics.newRectangleShape(sprites.life:getWidth(), sprites.life:getHeight())
    collectible_lifes.life2.fixture = love.physics.newFixture(collectible_lifes.life2.body, collectible_lifes.life2
        .shape, 2)
    collectible_lifes.life2.fixture:setSensor(true)
    -- collectibles.fixture:setUserData("life2")

    collectible_lifes.life3.body = love.physics.newBody(world, 800, 1300, "static")
    collectible_lifes.life3.shape = love.physics.newRectangleShape(sprites.life:getWidth(), sprites.life:getHeight())
    collectible_lifes.life3.fixture = love.physics.newFixture(collectible_lifes.life3.body, collectible_lifes.life3
        .shape, 2)
    collectible_lifes.life3.fixture:setSensor(true)
    -- collectibles.fixture:setUserData("life3")
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
end
