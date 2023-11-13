require "/MainCharacter/mainCharacter"
require "/Ghosts/ghosts"
require "/Death/death"
require "/Valkyries/valkyries"
require "/InGameMenu/inGameMenu"
require "/MainMenu/mainMenu"

local world

function love.load()
  world = love.physics.newWorld(0, 0, true)
  --Call "load" function of every script
end

function love.update()
    world:update()
    --Call update function of every script
end

function love.draw()
    --Call draw function of every script
end