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
  gameMap = sti("Mapa/map.lua")
  --Call "load" function of every script
  CreatePlayer()
end

function love.update(dt)
  world:update(dt)
  UpdatePlayer(dt)
  --Call update function of every script
end

function love.draw()
  gameMap:drawLayer(gameMap.layers["Relva"])
  gameMap:drawLayer(gameMap.layers["Rio"])
  gameMap:drawLayer(gameMap.layers["Path"])
  gameMap:drawLayer(gameMap.layers["Arvores"])
  gameMap:drawLayer(gameMap.layers["BUshes"])
  --Call draw function of every script
  DrawPlayer()
end