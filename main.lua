require "/MainCharacter/mainCharacter"
require "/Ghosts/ghosts"
require "/Death/death"
require "/Valkyries/valkyries"
require "/InGameMenu/inGameMenu"
require "/MainMenu/mainMenu"

local world
local sti = require "Mapa/sti"
local gameMap = require "Mapa/mapaProjeto2D.lua"

function love.load()
  world = love.physics.newWorld(0, 0, true)


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