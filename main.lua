Vector = require ("Companion/vector")
profile = require ("Companion/profile")
Luafinding = require ("Companion/luafinding")
require "Companion/companionMainScript"
require "MainCharacter/mainCharacter"
require "vector"

local world
local lowest_number


function love.load()
    world = love.physics.newWorld(0, 0, true)
    love.window.setMode(screenSize, screenSize )
    --(screenSize * 9)/16
    LoadCompanion()
    CreatePlayer(world)
end

function love.update(dt)
    UpdatePlayer(dt)
    UpdateCompanion(dt)

    local playerVelocity = vector.new(0, 0)

    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
    playerVelocity.x = playerVelocity.x + 250
    end

    if love.keyboard.isDown("left") or love.keyboard.isDown("a")then
    playerVelocity.x = playerVelocity.x - 250
    end

    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
    playerVelocity.y = playerVelocity.y - 250
    end

    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
    playerVelocity.y = playerVelocity.y + 250
    end

    player.body:setLinearVelocity(playerVelocity.x, playerVelocity.y)

end

function love.draw()
    DrawCompanion()
    DrawPlayer()
end

function BeginContact(fixtureA, fixtureB)

end

function EndContact(fixtureA, fixtureB)

end