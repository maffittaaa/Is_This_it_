collectible_key = {}
collectible_lifes = { life1 = {} }
collectiblePages = { page1 = {}, page2 = {}, page3 = {}, page4 = {} }
local message

function LoadCollectibles(world)
    collectible_lifes.counter = 0

    collectible_key.body = love.physics.newBody(world, 3650, 1740, "static") -- KEY
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

    -- Missing Pages
    collectiblePages.counter = 0

    collectiblePages.page1.body = love.physics.newBody(world, 146 * 32, 34 * 32, "static") -- first page first clareira in the middle of ghosts near the top bridge
    collectiblePages.page1.shape = love.physics.newRectangleShape(sprites.missingPages:getWidth(),
        sprites.missingPages:getHeight())
    collectiblePages.page1.fixture = love.physics.newFixture(collectiblePages.page1.body, collectiblePages.page1
        .shape, 2)
    collectiblePages.page1.collected = false
    collectiblePages.page1.fixture:setSensor(true)
    collectiblePages.page1.type = "page1"
    collectiblePages.page1.fixture:setUserData(collectiblePages.page1)

    collectiblePages.page2.body = love.physics.newBody(world, 48 * 32, 63 * 32, "static") -- second page in the middle of ghosts going down on the first cruzamento near the ghosts
    collectiblePages.page2.shape = love.physics.newRectangleShape(sprites.missingPages:getWidth(),
        sprites.missingPages:getHeight())
    collectiblePages.page2.fixture = love.physics.newFixture(collectiblePages.page2.body, collectiblePages.page2
        .shape, 2)
    collectiblePages.page2.collected = false
    collectiblePages.page2.fixture:setSensor(true)
    collectiblePages.page2.type = "page2"
    collectiblePages.page2.fixture:setUserData(collectiblePages.page2)

    collectiblePages.page3.body = love.physics.newBody(world, 32 * 32, 160 * 32, "static") -- page 3 near the down bridge in the dark side
    collectiblePages.page3.shape = love.physics.newRectangleShape(sprites.missingPages:getWidth(),
        sprites.missingPages:getHeight())
    collectiblePages.page3.fixture = love.physics.newFixture(collectiblePages.page3.body, collectiblePages.page3
        .shape, 2)
    collectiblePages.page3.collected = false
    collectiblePages.page3.fixture:setSensor(true)
    collectiblePages.page3.type = "page3"
    collectiblePages.page3.fixture:setUserData(collectiblePages.page3)

    collectiblePages.page4.body = love.physics.newBody(world, 215 * 32, 121 * 32, "static") -- page 4 near the dungeon, on top of it near some ghosts
    collectiblePages.page4.shape = love.physics.newRectangleShape(sprites.missingPages:getWidth(),
        sprites.missingPages:getHeight())
    collectiblePages.page4.fixture = love.physics.newFixture(collectiblePages.page4.body, collectiblePages.page4
        .shape, 2)
    collectiblePages.page4.collected = false
    collectiblePages.page4.fixture:setSensor(true)
    collectiblePages.page4.type = "page4"
    collectiblePages.page4.fixture:setUserData(collectiblePages.page4)
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
            collectible_lifes.life1.body:getAngle(), 1, 1, sprites.life:getWidth() / 2, sprites.life:getHeight() / 2)
    end
    if collectiblePages.counter == 0 then -- if no page collected, draw all 4
        love.graphics.draw(sprites.missingPages, collectiblePages.page1.body:getX(), collectiblePages.page1.body:getY(),
            collectiblePages.page1.body:getAngle(), 1, 1, sprites.missingPages:getWidth() / 2,
            sprites.missingPages:getHeight() / 2)
        love.graphics.draw(sprites.missingPages, collectiblePages.page2.body:getX(), collectiblePages.page2.body:getY(),
            collectiblePages.page2.body:getAngle(), 1, 1, sprites.missingPages:getWidth() / 2,
            sprites.missingPages:getHeight() / 2)
        love.graphics.draw(sprites.missingPages, collectiblePages.page3.body:getX(), collectiblePages.page3.body:getY(),
            collectiblePages.page3.body:getAngle(), 1, 1, sprites.missingPages:getWidth() / 2,
            sprites.missingPages:getHeight() / 2)
        love.graphics.draw(sprites.missingPages, collectiblePages.page4.body:getX(), collectiblePages.page4.body:getY(),
            collectiblePages.page4.body:getAngle(), 1, 1, sprites.missingPages:getWidth() / 2,
            sprites.missingPages:getHeight() / 2)
    elseif collectiblePages.counter == 1 then -- if one page collected, draw just 3
        love.graphics.draw(sprites.missingPages, collectiblePages.page2.body:getX(), collectiblePages.page2.body:getY(),
            collectiblePages.page2.body:getAngle(), 1, 1, sprites.missingPages:getWidth() / 2,
            sprites.missingPages:getHeight() / 2)
        love.graphics.draw(sprites.missingPages, collectiblePages.page3.body:getX(), collectiblePages.page3.body:getY(),
            collectiblePages.page3.body:getAngle(), 1, 1, sprites.missingPages:getWidth() / 2,
            sprites.missingPages:getHeight() / 2)
        love.graphics.draw(sprites.missingPages, collectiblePages.page4.body:getX(), collectiblePages.page4.body:getY(),
            collectiblePages.page4.body:getAngle(), 1, 1, sprites.missingPages:getWidth() / 2,
            sprites.missingPages:getHeight() / 2)
    elseif collectiblePages.counter == 2 then -- if two pages collected, draw just 2
        love.graphics.draw(sprites.missingPages, collectiblePages.page3.body:getX(), collectiblePages.page3.body:getY(),
            collectiblePages.page3.body:getAngle(), 1, 1, sprites.missingPages:getWidth() / 2,
            sprites.missingPages:getHeight() / 2)
        love.graphics.draw(sprites.missingPages, collectiblePages.page4.body:getX(), collectiblePages.page4.body:getY(),
            collectiblePages.page4.body:getAngle(), 1, 1, sprites.missingPages:getWidth() / 2,
            sprites.missingPages:getHeight() / 2)
    elseif collectiblePages.counter == 3 then -- if three pages collected, draw just 1
        love.graphics.draw(sprites.missingPages, collectiblePages.page4.body:getX(), collectiblePages.page4.body:getY(),
            collectiblePages.page4.body:getAngle(), 1, 1, sprites.missingPages:getWidth() / 2,
            sprites.missingPages:getHeight() / 2)
    end
end

function DrawUiCollectibles()
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
    if fixtureA:getUserData().type == "key" and fixtureB:getUserData().type == "player" then -- colision for collectibles(key)
        if collectible_key.counter == 0 then
            message = CreateMessage("inventory: 1 key")
            collectible_key.counter = 1
        end
    end
    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "key" then -- colision for collectibles(key)
        if collectible_key.counter == 0 then
            message = CreateMessage("inventory: 1 key")
            collectible_key.counter = 1
        end
    end
    if fixtureA:getUserData().type == "life1" and fixtureB:getUserData().type == "player" then -- colision for collectibles(lives)
        if gary.health == 5 then
            message = CreateMessage("Full Health")
            collectible_lifes.counter = collectible_lifes.counter
        elseif gary.health < 5 and gary.health >= 0 and collectible_lifes.counter <= 3 then
            message = CreateMessage("1 life")
            collectible_lifes.counter = collectible_lifes.counter + 1
            gary.health = gary.health + 1
        end
    end
    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "life1" then -- colision for collectibles(lives)
        if gary.health == 5 then
            message = CreateMessage("Can't pick up. Full Health")
            collectible_lifes.counter = collectible_lifes.counter
        elseif gary.health < 5 and gary.health >= 0 and collectible_lifes.counter <= 3 then
            message = CreateMessage("1 life")
            collectible_lifes.counter = collectible_lifes.counter + 1
            gary.health = gary.health + 1
        end
    end

    --collision for collectibles(pages)
    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "page1" then
        if fixtureB:getUserData().collected == false then
            fixtureB:getUserData().collected = true
            collectiblePages.counter = collectiblePages.counter + 1
            message = CreateMessage("inventory: 1 \nmissing page")
        end
        -- if collectiblePages.counter >= 0 and collectiblePages.counter <= 4 then
        --     message = CreateMessage("inventory: 1 \nmissing page")
        --     collectiblePages.counter = collectiblePages.counter + 1
        -- end
    end

    if fixtureA:getUserData().type == "page1" and fixtureB:getUserData().type == "player" then
        if fixtureA:getUserData().collected == false then
            fixtureA:getUserData().collected = true
            collectiblePages.counter = collectiblePages.counter + 1
            message = CreateMessage("inventory: 1 \nmissing page")
        end
    end

    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "page2" then
        if fixtureB:getUserData().collected == false then
            fixtureB:getUserData().collected = true
            collectiblePages.counter = collectiblePages.counter + 1
            message = CreateMessage("inventory: 1 \nmissing page")
        end
    end

    if fixtureA:getUserData().type == "page2" and fixtureB:getUserData().type == "player" then
        if fixtureA:getUserData().collected == false then
            fixtureA:getUserData().collected = true
            collectiblePages.counter = collectiblePages.counter + 1
            message = CreateMessage("inventory: 1 \nmissing page")
        end
    end

    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "page3" then
        if fixtureB:getUserData().collected == false then
            fixtureB:getUserData().collected = true
            collectiblePages.counter = collectiblePages.counter + 1
            message = CreateMessage("inventory: 1 \nmissing page")
        end
    end
    if fixtureA:getUserData().type == "page3" and fixtureB:getUserData().type == "player" then
        if fixtureA:getUserData().collected == false then
            fixtureA:getUserData().collected = true
            collectiblePages.counter = collectiblePages.counter + 1
            message = CreateMessage("inventory: 1 \nmissing page")
        end
    end
    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "page4" then
        if fixtureB:getUserData().collected == false then
            fixtureB:getUserData().collected = true
            collectiblePages.counter = collectiblePages.counter + 1
            message = CreateMessage("inventory: 1 \nmissing page")
        end
    end
    if fixtureA:getUserData().type == "page4" and fixtureB:getUserData().type == "player" then
        if fixtureA:getUserData().collected == false then
            fixtureA:getUserData().collected = true
            collectiblePages.counter = collectiblePages.counter + 1
            message = CreateMessage("inventory: 1 \nmissing page")
        end
    end
end
