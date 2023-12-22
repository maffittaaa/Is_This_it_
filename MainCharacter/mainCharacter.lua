player = {}
local height
local width
local playerVelocity = vector.new(0, 0)

function CreatePlayer(world)
  player.body = love.physics.newBody(world, 0, 0,"dynamic")
  player.shape = love.physics.newRectangleShape(30, 60)
  player.fixture = love.physics.newFixture(player.body, player.shape, 1)
  player.maxvelocity = 200
  player.fixture:setFriction(1)
  player.body:setFixedRotation(true)
  player.position = vector.new(player.body:getPosition())
end

function UpdatePlayer(dt)
  player.position = vector.new(player.body:getPosition())

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

  player.body:applyForce(playerVelocity.x, playerVelocity.y)
  --PrintTable(player.position)
  --PrintTable(playerVelocity)
  playerVelocity = vector.new(0, 0)
end

function DrawPlayer()
  love.graphics.setColor(1,1,1)
  love.graphics.polygon("fill", player.body:getWorldPoints(player.shape:getPoints()))
end

function PlayerPosition()
  return player.position
end