require "/MainCharacter/mainCharacter"
require "/Companion/companionBehavior"
require "/Ghosts/ghosts"
require "/Death/death"
require "/Valkyries/valkyries"
require "/InGameMenu/inGameMenu"
require "/MainMenu/mainMenu"

local world
local height
local width

function love.load()
  world = love.physics.newWorld(0, 0, true)
  
  love.window.setMode(1920, 1080)
  height = love.graphics.getHeight()
  width = love.graphics.getWidth()

  --Call "load" function of every script
  CreatePlayer(world)
  LoadCompanion(world, PlayerPosition())
end

function love.update(dt)
  world:update(dt)
  UpdatePlayer(dt)
  UpdateCompanion(dt, PlayerPosition())
  --Call update function of every script
end

function love.draw()
  --Call draw function of every script
  DrawPlayer()
  DrawCompanion()
end