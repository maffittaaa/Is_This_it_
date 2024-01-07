
function LoadMainMap(world)
    walls = {}

    if gameMap.layers['Arvores e bushes'] then
        -- iterate for every colition shapes you made in tiled --

        for i, obj in pairs(gameMap.layers['Arvores e bushes'].objects) do
            -- check what type of shape it is --
            -- check for each rectangle shape --
            if obj.shape == "rectangle" then
                -- the center of the colition box will be on the top left of where it is suposed to be --
                -- so i added its width devided by 2 on the x pos and did the same for its y pos with height here --
                local wall = {}
                wall.body = love.physics.newBody(world, obj.x + obj.width / 2, obj.y + obj.height / 2, "static")
                wall.shape = love.physics.newRectangleShape(obj.width, obj.height)
                wall.fixture = love.physics.newFixture(wall.body, wall.shape, 1)
                wall.type = "wall"
                wall.fixture:setUserData(wall)
                wall.fixture:setCategory(7)
                wall.fixture:setMask(5)
                table.insert(walls, wall)
            end
        end
    end

    if gameMap.layers['RioColliders'] then
        -- iterate for every colition shapes you made in tiled --

        for i, obj in pairs(gameMap.layers['RioColliders'].objects) do
            -- check what type of shape it is --
            -- check for each rectangle shape --
            if obj.shape == "rectangle" then
                -- the center of the colition box will be on the top left of where it is suposed to be --
                -- so i added its width devided by 2 on the x pos and did the same for its y pos with height here --
                local river = {}
                river.body = love.physics.newBody(world, obj.x + obj.width / 2, obj.y + obj.height / 2, "static")
                river.shape = love.physics.newRectangleShape(obj.width, obj.height)
                river.fixture = love.physics.newFixture(river.body, river.shape, 1)
                river.type = "wall"
                river.fixture:setUserData(river)
                river.fixture:setCategory(7)
                river.fixture:setMask(5)
                table.insert(walls, river)
            end
        end
    end

    doors = {}

    if gameMap.layers['TriggerCabana'] then
        -- iterate for every colition shapes you made in tiled --

        for i, obj in pairs(gameMap.layers['TriggerCabana'].objects) do
            -- check what type of shape it is --
            -- check for each rectangle shape --
            if obj.shape == "rectangle" then
                -- the center of the colition box will be on the top left of where it is suposed to be --
                -- so i added its width devided by 2 on the x pos and did the same for its y pos with height here --
                local triggerCbn = {}
                triggerCbn.body = love.physics.newBody(world, obj.x + obj.width / 2, obj.y + obj.height / 2, "static")
                triggerCbn.shape = love.physics.newRectangleShape(obj.width, obj.height)
                triggerCbn.fixture = love.physics.newFixture(triggerCbn.body, triggerCbn.shape, 1)
                triggerCbn.type = "triggerCbn"
                triggerCbn.fixture:setSensor(true)
                triggerCbn.fixture:setUserData(triggerCbn)
                triggerCbn.fixture:setCategory(7)
                triggerCbn.fixture:setMask(5)
                table.insert(doors, triggerCbn)
            end
        end
    end

    doorsMasmorra = {}

    if gameMap.layers['TriggerMasmorra'] then
        -- iterate for every colition shapes you made in tiled --

        for i, obj in pairs(gameMap.layers['TriggerMasmorra'].objects) do
            -- check what type of shape it is --
            -- check for each rectangle shape --
            if obj.shape == "rectangle" then
                -- the center of the colition box will be on the top left of where it is suposed to be --
                -- so i added its width devided by 2 on the x pos and did the same for its y pos with height here --
                local triggerMas = {}
                triggerMas.body = love.physics.newBody(world, obj.x + obj.width / 2, obj.y + obj.height / 2, "static")
                triggerMas.shape = love.physics.newRectangleShape(obj.width, obj.height)
                triggerMas.fixture = love.physics.newFixture(triggerMas.body, triggerMas.shape, 1)
                triggerMas.type = "triggerMas"
                triggerMas.fixture:setSensor(true)
                triggerMas.fixture:setUserData(triggerMas)
                triggerMas.fixture:setCategory(7)
                triggerMas.fixture:setMask(5)
                table.insert(doorsMasmorra, triggerMas)
            end
        end
    end

    bigDoorMas = {}

    if gameMap.layers['BigDoorMasmorra'] then
        -- iterate for every colition shapes you made in tiled --

        for i, obj in pairs(gameMap.layers['BigDoorMasmorra'].objects) do
            -- check what type of shape it is --
            -- check for each rectangle shape --
            if obj.shape == "rectangle" then
                -- the center of the colition box will be on the top left of where it is suposed to be --
                -- so i added its width devided by 2 on the x pos and did the same for its y pos with height here --
                local bigDoor = {}
                bigDoor.body = love.physics.newBody(world, obj.x + obj.width / 2, obj.y + obj.height / 2, "static")
                bigDoor.shape = love.physics.newRectangleShape(obj.width, obj.height)
                bigDoor.fixture = love.physics.newFixture(bigDoor.body, bigDoor.shape, 1)
                bigDoor.type = "bigDoor"
                bigDoor.fixture:setSensor(false)
                bigDoor.fixture:setUserData(bigDoor)
                table.insert(bigDoorMas, bigDoor)
            end
        end
    end

    darkSide = {}

    if gameMap.layers['DarkSide'] then
        -- iterate for every colition shapes you made in tiled --

        for i, obj in pairs(gameMap.layers['DarkSide'].objects) do
            -- check what type of shape it is --
            -- check for each rectangle shape --
            if obj.shape == "rectangle" then
                -- the center of the colition box will be on the top left of where it is suposed to be --
                -- so i added its width devided by 2 on the x pos and did the same for its y pos with height here --
                local coll = {}
                coll.body = love.physics.newBody(world, obj.x + obj.width / 2, obj.y + obj.height / 2, "static")
                coll.shape = love.physics.newRectangleShape(obj.width, obj.height)
                coll.fixture = love.physics.newFixture(coll.body, coll.shape, 1)
                coll.type = "collDark"
                coll.fixture:setSensor(true)
                coll.fixture:setUserData(coll)
                table.insert(darkSide, coll)
            end
        end
    end

    brightSide = {}

    if gameMap.layers['BrightSide'] then
        -- iterate for every colition shapes you made in tiled --

        for i, obj in pairs(gameMap.layers['BrightSide'].objects) do
            -- check what type of shape it is --
            -- check for each rectangle shape --
            if obj.shape == "rectangle" then
                -- the center of the colition box will be on the top left of where it is suposed to be --
                -- so i added its width devided by 2 on the x pos and did the same for its y pos with height here --
                local coll = {}
                coll.body = love.physics.newBody(world, obj.x + obj.width / 2, obj.y + obj.height / 2, "static")
                coll.shape = love.physics.newRectangleShape(obj.width, obj.height)
                coll.fixture = love.physics.newFixture(coll.body, coll.shape, 1)
                coll.type = "collBright"
                coll.fixture:setSensor(true)
                coll.fixture:setUserData(coll)
                table.insert(brightSide, coll)
            end
        end
    end
end