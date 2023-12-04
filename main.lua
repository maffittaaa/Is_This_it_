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
Camera = require "Camera/Camera"

local world
local ground
local speed
local success
local wf
local ghosts_quantity
posicoes = {}

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

    posicoes[1] = { x = 3464, y = 1782 }
    posicoes[2] = { x = 3561, y = 1643 }
    posicoes[3] = { x = 3633, y = 1526 }
    posicoes[4] = { x = 2960, y = 3138 }
    posicoes[5] = { x = 2919, y = 2968 }
    posicoes[6] = { x = 3142, y = 2796 }
    posicoes[7] = { x = 3194, y = 2710 }

    posicoes[8] = { x = 4149, y = 1782 }
    posicoes[9] = { x = 4149, y = 1643 }
    posicoes[10] = { x = 4174, y = 1526 }
    posicoes[11] = { x = 3373, y = 3138 }
    posicoes[12] = { x = 3574, y = 2968 }
    posicoes[13] = { x = 3747, y = 2796 }
    posicoes[14] = { x = 3645, y = 2710 }

    valkeries_quantity = #posicoes / 2

    LoadSprites()
    LoadGary(world, 900, 1000)
    LoadGaryAttack(world)
    LoadGhost(world, 1300, 800)
    LoadHealthBars()
    LoadValquiria(world, valkeries_quantity)
    LoadSword(world, valkyrie)
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
                wall.type = "wall"
                wall.fixture:setUserData(wall)
                wall.fixture:setCategory(7)
                wall.fixture:setMask(5)
                table.insert(walls, wall)
            end
        end
    end

    camera = Camera(gary.body:getX(), gary.body:getY(), width, height, 1)
end

function BeginContact(fixtureA, fixtureB) -- player, lista de arrow, lista valquirias, lista ghhosts, lista de todos os colisiveis separados
    BeginContactGhost(fixtureA, fixtureB)
    BeginContactValkyrie(fixtureA, fixtureB)
    BeginContactValkyrieSword(fixtureA, fixtureB)
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
    UpdateHealthBars()
    UpdateGary(dt)
    UpdateGaryAttack(dt)
    UpdateGhost(dt, world)
    UpdateValkyrieRangedAttack(world, dt)
    UpdateValquiria(dt, GetPlayerPosition(), posicoes, valkeries_quantity)
    UpdateValkyrieSword()
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
    DrawValquiria(valkeries_quantity)
    DrawCollectibles()
    DrawValkyrieAttack()
    DrawValkyrieSword()

    for i = 1, valkeries_quantity, 1 do
        love.graphics.setColor(1, 0, 0)
        love.graphics.circle("line", posicoes[i].x, posicoes[i].y, 30)
        love.graphics.setColor(1, 1, 1)
    end
    camera:detach()
end
