require "vector"

companion = {}
local book = {}
local gotBook

function LoadCompanion(world)
  gotBook = false
  companion.body = love.physics.newBody(world, 1800, 100,"dynamic")
  companion.shape = love.physics.newCircleShape(30)
  companion.fixture = love.physics.newFixture(companion.body, companion.shape, 1)
  companion.position = vector.new(companion.body:getPosition())

  book.body = love.physics.newBody(world, 1000, 100,"dynamic")
  book.shape = love.physics.newCircleShape(30)
  book.position = vector.new(book.body:getPosition())
end

function UpdateCompanion(dt, playerPosition)
  -- O companion vai para a posição do livro, se o player ainda não tiver ido lá
  companion.position = vector.new(companion.body:getPosition())
  book.position = vector.new(book.body:getPosition())

  if gotBook == false then
    --luz muda-se para a posição do livro


    local playerDiretion = vector.sub(book.position, vector.new(companion.body:getPosition()))
    playerDiretion = vector.normalize(playerDiretion)
    local force = vector.mult(playerDiretion, 200)
    companion.body:setLinearVelocity(force.x, force.y)
    print("a mafalda cheira mal")
  elseif gotBook == true then
    
  end
  --Se o player já tiver pegado no livro, então a luz vai para a porta e espera pelo player
end

function DrawCompanion()
  love.graphics.circle("fill", companion.position.x, companion.position.y, companion.shape:getRadius())
end