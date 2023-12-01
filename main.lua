require "vector2"
require "vector"
require "MainCharacter/gary"
require "Ghosts/ghost"
require "MainCharacter/healthbar"
require "Sprites/sprites"
require "MainCharacter/gary_sword"
require "MainCharacter/lives"
require "Valkyries/valkyrie"
require "Valkyries/valkyrie_bow_and_arrow"
Camera = require "Camera/Camera"

local world
local ground
local speed
local success
local wf
local valkeries_quantity = 1
local ghosts_quantity
local posicoes = {}

local enemyPostions = {}

function love.keypressed(e)
    if e == 'escape' then
        love.event.quit()
    end
    if e == 'e' then
        if sword.body:isActive() then
            sword.body:setActive(false)
        else
            sword.body:setActive(true)
        end
    end
end

function love.load()
    love.physics.setMeter(30)
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(BeginContact, EndContact, nil, nil)

    -- love.window.setMode(1920, 1080)
    height = love.graphics.getHeight()
    width = love.graphics.getWidth()
    -- love.window.setFullscreen(true)


    sti = require "Mapa/sti"
    gameMap = sti("Mapa/map.lua")
    --Call "load" function of every script

    posicoes[1] = { x = 3800, y = 1400 }
    posicoes[2] = { x = 3800, y = 1500 }
    posicoes[3] = { x = 3800, y = 1600 }
    posicoes[4] = { x = 3800, y = 1700 }
    posicoes[5] = { x = 3800, y = 1800 }
    posicoes[6] = { x = 3800, y = 1900 }
    posicoes[7] = { x = 3800, y = 2000 }
    posicoes[8] = { x = 4149, y = 1782 }
    posicoes[9] = { x = 4149, y = 1643 }
    posicoes[10] = { x = 4174, y = 1526 }
    posicoes[11] = { x = 3373, y = 3138 }
    posicoes[12] = { x = 2919, y = 2968 }
    posicoes[13] = { x = 3747, y = 2796 }
    posicoes[14] = { x = 3194, y = 2710 }

    LoadSprites()
    LoadGary(world, 900, 1000)
    LoadGaryAttack(world)
    LoadGhost(world, 1600, 800)
    LoadHealthBars()
    LoadValquiria(world, posicoes, 1)
    LoadValkyrieRangedAttack(world)
    LoadCollectibles(world)

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
                table.insert(walls, wall)
            end
        end
    end

    camera = Camera(gary.body:getX(), gary.body:getY(), width, height, 1)
end

function BeginContact(fixtureA, fixtureB)
    for i = 1, valkeries_quantity, 1 do
        if fixtureA:getUserData() == "player" and fixtureB:getUserData() == "MelleAttack" then
            valkyries[i].isRanging = true
            valkyries[i].isMeleeing = true
            print("startMelee")
        elseif fixtureA:getUserData() == "player" and fixtureB:getUserData() == "RangedAttack" then
            valkyries[i].playerInSight = true
            valkyries[i].isRanging = true
            valkyries[i].patroling = false
            print("StartRanged")
        end

        if fixtureA:getUserData() == "MelleAttack" and fixtureB:getUserData() == "player" then
            valkyries[i].isRanging = true
            valkyries[i].isMeleeing = true
            print("starMelee")
        elseif fixtureA:getUserData() == "RangedAttack" and fixtureB:getUserData() == "player" then
            valkyries[i].playerInSight = true
            valkyries[i].patroling = false
            valkyries[i].isRanging = false
            print("StartRanged")
        end
        if fixtureA:getUserData() == "player" and fixtureB:getUserData() == "ArrowAttack" then
            if valkyries[1].playerInSight == true and valkyries[1].isRanging == true then
                bullets.body:isActive()
                gary.health = gary.health - 1
            else
                bullets.body:setActive(false)
            end
            if gary.health <= 0 then
                valkyries[1].isRanging = false
                valkyries[1].patroling = true
            end
        end
    end

    if ghost.isChasing == true and ghost.garyInSight == true then
        if fixtureA:getUserData() == "player" and fixtureB:getUserData() == "attack" and gary.health <= 5 and gary.health > 0 then -- attack from ghost to player
            print(fixtureA:getUserData(), fixtureB:getUserData())
            ghost.timer = 1                                                                                                        -- tempo de cooldown para perseguir outra vez
            gary.health = gary.health - 1
            print("Gary health = " .. gary.health)
            PushGaryBack()
            if gary.health <= 0 then
                ghost.isChasing = false
                ghost.patroling = true
            end
        end
    end
    if ghost.health <= 4 and ghost.health > 0 then
        if fixtureA:getUserData() == "attack" and fixtureB:getUserData() == "melee weapon" then -- attack from player to ghost
            print(fixtureA:getUserData(), fixtureB:getUserData())
            ghost.health = ghost.health - 1
            -- Testes
            if ghost.health <= 0 then
                ghost.isChasing = false
                ghost.patroling = false
                -- ghost.fixture:destroy()
                -- trigger.fixture:destroy()
                -- ghost.body:destroy()
                print('Morreu :')
            end
            -- End testes
            print("Ghost health = " .. ghost.health)
        end
    end
    if fixtureB:getUserData() == "key" and fixtureA:getUserData() == "player" then -- colision for collectibles(key)
        if collectible_key.counter == 0 then
            success = love.window.showMessageBox(title, message)
            collectible_key.counter = 1
        end
    end
    if fixtureB:getUserData() == "life" and fixtureA:getUserData() == "player" then -- colision for collectibles(lives)
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

function EndContact(fixtureA, fixtureB)
    for i = 1, valkeries_quantity, 1 do
        if fixtureA:getUserData() == "player" and fixtureB:getUserData() == "MelleAttack" then
            valkyries[i].isMeleeing = false
            valkyries[i].isRanging = true
            print("EndMelee")
        end

        if fixtureA:getUserData() == "player" and fixtureB:getUserData() == "RangedAttack" then
            valkyries[i].playerInSight = false
            valkyries[i].isRanging = false
            valkyries[i].isMeleeing = false
            print("EndRanged")
        end

        if fixtureA:getUserData() == "MelleAttack" and fixtureB:getUserData() == "player" then
            valkyries[i].isMeleeing = false
            valkyries[i].isRanging = true
            print("EndMelee")
        end

        if fixtureA:getUserData() == "RangedAttack" and fixtureB:getUserData() == "player" then
            valkyries[i].isRanging = false
            valkyries[i].isMeleeing = false
            print("EndRanged")
        end
    end
end

function love.update(dt)
    world:update(dt)
    camera:update(dt)
    camera:follow(gary.body:getX(), gary.body:getY())
    camera:setFollowLerp(0.2)
    camera:setFollowLead(0)
    camera:setFollowStyle('TOPDOWN')
    UpdateHealthBars()
    UpdateGary(dt)
    UpdateGaryAttack(dt)
    UpdateGhost(dt, world)
    UpdateValkyrieRangedAttack(dt)
    UpdateValquiria(dt, GetPlayerPosition(), posicoes, 1)
end

function love.mousepressed(x, y, button)
    if button == 1 then
        print(gary.position.x, gary.position.y)
    end
end

function love.draw()
    --Call draw function of every script
    camera:attach()

    gameMap:drawLayer(gameMap.layers["Relva"])
    gameMap:drawLayer(gameMap.layers["Rio"])
    gameMap:drawLayer(gameMap.layers["Path"])
    gameMap:drawLayer(gameMap.layers["BUshes"])
    gameMap:drawLayer(gameMap.layers["Arvores"])
    -- gameMap:drawLayer(gameMap.layers["Arvores e bushes"])

    DrawGary()
    DrawGaryAttack()
    DrawHealthBars()
    DrawGhost()
    DrawValquiria(1)
    DrawCollectibles()
    DrawValkyrieAttack()
    camera:detach()
end
