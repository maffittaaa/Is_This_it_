require "/MainCharacter/mainCharacter"
require "/Ghosts/ghosts"
require "/Death/death"
require "/Valkyries/valkyries"
require "/InGameMenu/inGameMenu"
require "/MainMenu/mainMenu"

local world

function love.load()
  world = love.physics.newWorld(0, 0, true)
  love.window.setMode(1920, 1080)
  --Call "load" function of every script
  CreatePlayer()
  LoadValquiria()
end

function love.update(dt)
  world:update(dt)

  GetWorld()

  UpdatePlayer(dt)
  UpdateValquiria(dt, GetPlayerPosition())
  --Call update function of every script
end

function love.draw()
  --Call draw function of every script
  DrawPlayer()
  DrawValquiria()
end

function GetWorld()
  return world
end