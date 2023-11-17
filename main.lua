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
fixtureData = {}
hitted_obstacles = nil

function love.load()
  world = love.physics.newWorld(0, 0, true)
  world:setCallbacks(BeginContact, EndContact, nil, nil)

  love.window.setMode(1920, 1080)
  height = love.graphics.getHeight()
  width = love.graphics.getWidth()

  --Call "load" function of every script
  CreatePlayer(world)
  LoadCompanion(world, PlayerPosition())
end

function BeginContact(fixtureA, fixtureB)
  if fixtureA:getUserData().name == "wall" and fixtureB:getUserData().name == "companion" then
    print("hit wall")
  end

  if fixtureA:getUserData().name == "obstacles" and fixtureB:getUserData().name == "companion" then
    fixtureData = fixtureA:getUserData()
    hitted_obstacles = true
    print("hit obstacles")
  end

  if fixtureA:getUserData().name == "companion" and fixtureB:getUserData().name == "wall" then
    print("hit wall")
  end

  if fixtureA:getUserData().name == "companion" and fixtureB:getUserData().name == "obstacles" then
    hitted_obstacles = true
    print("hit obstacles")
  end
end

function EndContact(fixtureA, fixtureB)
  
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