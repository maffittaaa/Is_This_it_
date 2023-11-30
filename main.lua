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

    love.window.setMode(1920, 1080)
    height = love.graphics.getHeight()
    width = love.graphics.getWidth()
    love.window.setFullscreen(true)


    sti = require "Mapa/sti"
    gameMap = sti("Mapa/map.lua")
    --Call "load" function of every script

    for i = 1, 7, 1 do
        posicoes[1] = {vector.new(3464, 1782)}
        posicoes[2] = {vector.new(4149, 1782)}
        posicoes[3] = {vector.new(3561, 1643)}
        posicoes[4] = {vector.new(4149, 1643)}
        posicoes[5] = {vector.new(3633, 1526)}
        posicoes[6] = {vector.new(4174, 1526)}
        posicoes[7] = {vector.new(2960, 3138)}
        posicoes[8] = {vector.new(3373, 3138)}
        posicoes[9] = {vector.new(3574, 2968)}
        posicoes[10] = {vector.new(2919, 2968)}
        posicoes[11] = {vector.new(3142, 2796)}
        posicoes[12] = {vector.new(3747, 2796)}
        posicoes[13] = {vector.new(3645, 2710)}
        posicoes[14] = {vector.new(3194, 2710)}
        
        table.insert(enemyPostions, i, posicoes)
    end

    LoadSprites()
    LoadGary(world, 900, 1000)
    LoadGaryAttack(world)
    LoadGhost(world, 1600, 800)
    LoadHealthBars()
    LoadValquiria(world, 700, 500, 1100, 1200, valkeries_quantity)
    LoadValkyrieRangedAttack(world)
    LoadValquiria(world, posicoes, #posicoes/ 2)
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

    camera = Camera(gary.body:getX(), gary.body:getY(), width, height, 1.5)
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
    end

    if ghost.isChasing == true and ghost.garyInSight == true then
        if fixtureA:getUserData() == "player" and fixtureB:getUserData() == "attack" and gary.health <= 5 and gary.health > 0 then
            print(fixtureA:getUserData(), fixtureB:getUserData())
            ghost.timer = 1 -- tempo de cooldown para perseguir outra vez
            gary.health = gary.health - 1
            print("Gary health = " .. gary.health)
            PushGaryBack()
            if gary.health <= 0 then
                ghost.isChasing = false
                gary.patroling = true
            end
        end
    end
    if ghost.health <= 4 and ghost.health > 0 then
        if fixtureA:getUserData() == "attack" and fixtureB:getUserData() == "melee weapon" then
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
    if fixtureB:getUserData() == "key" and fixtureA:getUserData() == "player" then
        if collectible_key.counter == 0 then
            success = love.window.showMessageBox(title, message)
            collectible_key.counter = 1
        end
    end
    if fixtureB:getUserData() == "life" and fixtureA:getUserData() == "player" then
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
  UpdateValquiria(dt, GetPlayerPosition(), 1)
  UpdateValkyrieRangedAttack(dt)
  UpdateValquiria(dt, GetPlayerPosition(), #posicoes/2)
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
    DrawValquiria(#posicoes/2)
    DrawCollectibles()
    DrawValkyrieAttack()
    camera:detach()
end
