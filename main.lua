Camera = require "Camera/Camera"
Vector = require("Companion/vector")
profile = require("Companion/profile")
Luafinding = require("Companion/luafinding")

require "vector2"
require "vector"
require "MainCharacter/gary"
require "Ghosts/ghost"
require "MainCharacter/healthbar"
require "Sprites/sprites"
require "MainCharacter/gary_sword"
require "MainCharacter/collectibles"
require "Valkyries/valkyrie"
require "Valkyries/arrow"
require "Valkyries/melee_attack"
require "Death/death"
require "Death/chargeAttack"
require "MainCharacter/message"
require "UI/lives"
require "UI/diary"

require "Companion/companionMainScript"
require "Companion/map"
require "Companion/companionBody"
require "Ghosts.loadEnemies"
require "MainFiles.mainFunctions"
require "Mapa.LoadMap"
require "Menus.mainMenu"
require "Menus.inGameMenu"
require "Menus.deadMenu"
require "Menus.winMenu"
require "MainFiles.soundManager"
--require "Ghosts.mapaGhostAi"
--require "Ghosts.ghostsAiScript"

MainMenu = 1
GamePlay = 2
InGameMenu = 3
Loading = 4
DeadMenu = 5
WinMenu = 6
Restarting = 7
Dungeon = 8

local world

function love.load()
    gameState = MainMenu

    love.physics.setMeter(30)
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(BeginContact, EndContact, nil, nil)

    -- -- love.window.setMode(1920, 1080)
    love.window.setFullscreen(true)
    height = love.graphics.getHeight()
    width = love.graphics.getWidth()

    --Loading Menus
    LoadMainMenu()
    LoadInGameMenu()
    LoadDeadMenu()
    LoadWinMenu()
    LoadSounds()

end

function love.update(dt)
    world:update(dt)
    if gameState == Restarting then
        RestartingGame(world)
    elseif gameState == MainMenu then
        UpdateMainMenu(dt)
    elseif gameState == InGameMenu then

    elseif gameState == GamePlay then
        UpdateMain(dt, world)
    elseif gameState == DeadMenu then
        UpdateMain(dt, world)
    elseif gameState == WinMenu then

    end

    UpdateSounds(dt)
end

function love.draw()
    --Call draw function of every script

    if gameState == MainMenu then
        DrawMainMenu()
    elseif gameState == InGameMenu then
        DrawMain()
        DrawInGameMenu()
    elseif gameState == GamePlay then
        DrawMain()
    elseif gameState == DeadMenu then
        DrawMain()
        DrawDeadMenu()
    elseif gameState == WinMenu then
        DrawWinMenu()
    end
end

function love.keypressed(e)
    if e == 'delete' then
        love.event.quit()
    end

    if e == "0" then
        gameState = WinMenu
    end

    if gameState == MainMenu then
        --Keys MainMenu
    elseif gameState == InGameMenu then
        KeyPressed(e)
        if e == 'escape' then
            gameState = GamePlay
        end
    elseif gameState == GamePlay then
        KeyPressed(e)
        if e == 'escape' then
            gameState = InGameMenu
        end
    elseif gameState == DeadMenu then
        --Keys DeadMenu
    elseif gameState == WinMenu then
        --Keys WinMenu
    end
end

function love.mousepressed(x, y, button)
    if gameState == GamePlay then
        MousePressed(x, y, button)
    end
end

function BeginContact(fixtureA, fixtureB)
    BeginContactMain(fixtureA, fixtureB)
end

function EndContact(fixtureA, fixtureB)
    EndContactMain(fixtureA, fixtureB)
end
