require "vector2"
require "vector"
require "MainCharacter/gary"
require "Ghosts/ghost"
require "MainCharacter/healthbar"
require "Sprites/sprites"
require "MainCharacter/gary_sword"
require "MainCharacter/lives"
require "Valkyries/valkyrie"
require "Valkyries/arrow"
require "Valkyries/melee_attack"
require "MainCharacter/message"
Camera = require "Camera/Camera"
Vector = require("Companion/vector")
profile = require("Companion/profile")
Luafinding = require("Companion/luafinding")
require "Companion/companionMainScript"
require "Companion/map"
require "Companion/companionBody"

local world
local message
local k = 1
local onoff = true
invencible = false
drawCheats = true
posicoes = {}
ghosts = {}

function love.keypressed(e)
    if e == 'escape' then
        love.event.quit()
    end

    if e == 'e' then
        if gary_sword.body:isActive() then
            gary_sword.body:setActive(false)
        else
            gary_sword.body:setActive(true)
        end
    end

    --Cheats
    if e == "tab" then
        if drawCheats == true then
            drawCheats = false
            return
        elseif drawCheats == false then
            drawCheats = true
        end
    end

    if e == "q" then
        if player_velocity < 1000 then
            player_velocity = player_velocity + 250
        elseif player_velocity >= 1000 then
            player_velocity = 250
        end
    end

    if e == "p" then
        local strategicPositions = {}
        strategicPositions[1] = { x = 3349, y = 1152 }
        strategicPositions[2] = { x = 2497, y = 2791 }
        strategicPositions[3] = { x = 6482, y = 4538 }
        strategicPositions[4] = { x = 900, y = 1000 }

        gary.body:setPosition(strategicPositions[k].x, strategicPositions[k].y)

        k = k + 1

        if k > 4 then
            k = 1
        end
    end

    if e == "f" then
        if onoff == true then
            gary.fixture:setSensor(false)
            onoff = false
            return
        elseif onoff == false then
            gary.fixture:setSensor(true)
            onoff = true
        end
    end

    if e == "+" then
        if invencible == false then
            invencible = true
        elseif invencible == true then
            invencible = false
        end
    end

    if e == "space" and walking == false then
        CompanionPath()
    end
end

function love.load()
    love.physics.setMeter(30)
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(BeginContact, EndContact, nil, nil)

    love.window.setMode(1920, 1080)
    height = love.graphics.getHeight()
    width = love.graphics.getWidth()

    message = CreateMessage(
        "Cheat Codes \n [q] = quick/change velocity \n [f] = fixture/deactivate player fixture \n [p] = position/change position \n [+] = more/invencible mode")

    sti = require "Mapa/sti"
    gameMap = sti("Mapa/map.lua")
    --Call "load" function of every script

    --valquirias first Patroling Position
    posicoes[1] = { x = 3464, y = 1782 }
    posicoes[2] = { x = 2960, y = 3138 }

    --ghosts first Patroling Position
    posicoes[3] = { x = 3561, y = 1643 }
    posicoes[4] = { x = 3633, y = 1526 }
    posicoes[5] = { x = 2919, y = 2968 }
    posicoes[6] = { x = 3142, y = 2796 }
    posicoes[7] = { x = 3194, y = 2710 }

    --valquirias final Patroling Position
    posicoes[8] = { x = 4149, y = 1782 }
    posicoes[9] = { x = 3373, y = 3138 }

    --ghosts final Patroling Position
    posicoes[10] = { x = 4149, y = 1643 }
    posicoes[11] = { x = 4174, y = 1526 }
    posicoes[12] = { x = 3574, y = 2968 }
    posicoes[13] = { x = 3747, y = 2796 }
    posicoes[14] = { x = 3645, y = 2710 }

    valkeries_quantity = 2


    LoadSprites()
    LoadGary(world, 900, 1000)
    LoadGaryAttack(world)

    ghosts[1] = LoadGhost(world, posicoes[3].x, posicoes[3].y, 1)
    ghosts[2] = LoadGhost(world, posicoes[4].x, posicoes[4].y, 2)
    ghosts[3] = LoadGhost(world, posicoes[5].x, posicoes[5].y, 3)
    ghosts[4] = LoadGhost(world, posicoes[6].x, posicoes[6].y, 4)
    ghosts[5] = LoadGhost(world, posicoes[7].x, posicoes[7].y, 5)

    LoadValquiria(world, valkeries_quantity)
    LoadHealthBars()
    LoadCollectibles(world)
    LoadCompanion(world)

    -- make a table where the colitions will be stored --
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

    camera = Camera(gary.body:getX(), gary.body:getY(), width, height, 1.2)
end

function BeginContact(fixtureA, fixtureB)
    BeginContactGary(fixtureA, fixtureB)
    BeginContactValkyrieSword(fixtureA, fixtureB)
    BeginContactValkyrie(fixtureA, fixtureB)
    BeginContactGhost(fixtureA, fixtureB)
    BeginContactCollectibles(fixtureA, fixtureB)
    BeginContactArrows(fixtureA, fixtureB)
end

function EndContact(fixtureA, fixtureB)
    EndContactValkyrie(fixtureA, fixtureB)
end

function love.update(dt)
    world:update(dt)
    camera:update(dt)
    camera:follow(gary.body:getX(), gary.body:getY())
    camera:setFollowLerp(0.2)
    camera:setFollowLead(0)

    camera:setFollowStyle('TOPDOWN')

    if timer_camera > 1 then
        camera:setFollowStyle('LOCKON')
    end

    UpdateCompanion(dt)
    UpdateHealthBars()
    UpdateGary(dt)
    UpdateGaryAttack(dt)
    UpdateGhost(dt, world)
    UpdateValkyrieRangedAttack(world, dt)
    UpdateValquiria(dt, GetPlayerPosition(), posicoes, valkeries_quantity)
    UpdateValkyrieSword(world, dt)
    UpdateCollectibles(dt)
end

function love.draw()
    --Call draw function of every script
    camera:attach()

    gameMap:drawLayer(gameMap.layers["Relva"])
    gameMap:drawLayer(gameMap.layers["Rio"])
    gameMap:drawLayer(gameMap.layers["Path"])
    gameMap:drawLayer(gameMap.layers["BUshes"])
    gameMap:drawLayer(gameMap.layers["Arvores"])

    gameMap:drawLayer(gameMap.layers["WoodenCabinShadow"])

    if collectible_key.counter == 1 then
        gameMap:drawLayer(gameMap.layers["MasmorraOpen"])
        gameMap:drawLayer(gameMap.layers["WoodenCabinOpen"])
    else
        gameMap:drawLayer(gameMap.layers["MasmorraClosed"])
        gameMap:drawLayer(gameMap.layers["WoodenCabinClosed"])
    end

    DrawGary()
    DrawHealthBars()
    DrawCompanion()
    DrawGaryAttack()
    DrawGhost()
    DrawValquiria(valkeries_quantity)
    DrawValkyrieAttack()
    DrawValkyrieSword()
    gameMap:drawLayer(gameMap.layers["WoodenCabinAbovePlayer"])

    DrawCollectibles()

    if drawCheats == true then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(sprites.inventory, camera.x - 750, camera.y - 60, 0, 4, 3)
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(love.graphics.newFont(12))
        love.graphics.print(message.message, camera.x - 730, camera.y - 25)
        love.graphics.setColor(1, 1, 1)
    end

    camera:detach()
    camera:draw() -- Must call this to use camera:fade!
end
