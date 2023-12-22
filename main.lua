require "vector"
Vector = require ("Companion/vector")
profile = require ("Companion/profile")
Luafinding = require ("Companion/luafinding")
require "Companion/companionMainScript"
require "MainCharacter/mainCharacter"
require "Companion/map"

local world

function love.load()
    world = love.physics.newWorld(0, 0, true)
    --love.window.setMode(screenSize, (screenSize * 9)/16)
    --(screenSize * 9)/16
    CreatePlayer(world)
    LoadCompanion()
end

function love.update(dt)
    UpdatePlayer(dt)
    UpdateCompanion(dt)
end

function love.draw()
    DrawCompanion()
    DrawPlayer()
end

function BeginContact(fixtureA, fixtureB)

end

function EndContact(fixtureA, fixtureB)

end