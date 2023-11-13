require "/MainCharacter/vector"

local world
local player
local ground
local height
local width

function CreatePlayer()
  love.physics.setMeter(35)
  -- 9.81 * love.physics.getMeter()
  world = love.physics.newWorld(0, 0, true)

  love.window.setMode(1920, 1080)
  height = love.graphics.getHeight()
  width = love.graphics.getWidth()

  ground = {}
  ground.body = love.physics.newBody(world, 400, 575,"static")
  ground.shape = love.physics.newRectangleShape(800, 50)
  ground.fixture = love.physics.newFixture(ground.body, ground.shape, 1)

  player = {}
  player.body = love.physics.newBody(world, 400, 100,"dynamic")
  player.shape = love.physics.newRectangleShape(30, 60)
  player.fixture = love.physics.newFixture(player.body, player.shape, 1)
  player.maxvelocity = 200
  player.fixture:setFriction(1)
  player.body:setFixedRotation(true)
  player.position = vector.new(player.body:getPosition())

end

function UpdatePlayer(dt)
  
  world:update(dt)
  player.position = vector.new(player.body:getPosition())

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

function DrawPlayer()
  love.graphics.setColor(1,1,1)
  love.graphics.polygon("fill", player.body:getWorldPoints(player.shape:getPoints()))
  
  love.graphics.setColor(0,1,0)
  love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints()))
  
end