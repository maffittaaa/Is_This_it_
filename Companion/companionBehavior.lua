companion = {}

function LoadCompanion(world)
  companion.body = love.physics.newBody(world, 400, 100,"dynamic")
  companion.shape = love.physics.newRectangleShape(30, 60)
  companion.fixture = love.physics.newFixture(companion.body, companion.shape, 1)
  companion.maxvelocity = 200
  companion.fixture:setFriction(1)
  companion.body:setFixedRotation(true)
  companion.position = vector.new(companion.body:getPosition())
end

function UpdateCompanion(dt, playerPosition)
    
end

function DrawCompanion()
    
end