require "MeuVector"

local world
local companion = {}

function LoadCompanion()
  world = love.physics.newWorld(0, 0, true)

  gotBook = false
  companion.body = love.physics.newBody(world, 100, 200,"dynamic")
  companion.shape = love.physics.newCircleShape(30)
  companion.fixture = love.physics.newFixture(companion.body, companion.shape, 1)
  companion.position = vector.new(companion.body:getPosition())
  companion.name = "companion"
  companion.fixture:setUserData(companion)
end

function UpdatePosition(force)
  companion.body:setLinearVelocity(force.x, force.y)
end