require "/MainCharacter/mainCharacter"
require "/Ghosts/ghosts"
require "/Death/death"
require "/Valkyries/valkyries"
require "/InGameMenu/inGameMenu"
require "/MainMenu/mainMenu"

local world

function love.load()
  world = love.physics.newWorld(0, 0, true)
  sti = require "Mapa/sti"
  gameMap = sti("Mapa/mapaProjeto2D.lua", {"box2d"})
  --Call "load" function of every script
  CreatePlayer()
end

function love.update(dt)
  world:update(dt)
  UpdatePlayer(dt)
  --Call update function of every script
end

function love.draw()
  gameMap:draw()
  --Call draw function of every script
  DrawPlayer()
end