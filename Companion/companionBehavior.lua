require "vector"

companion = {}
local book = {}
local gotBook
local inicialPlayerPosition

function LoadCompanion(world, playerPosition)
  inicialPlayerPosition = playerPosition
  gotBook = false
  companion.body = love.physics.newBody(world, 1800, 100,"dynamic")
  companion.shape = love.physics.newCircleShape(30)
  companion.position = vector.new(companion.body:getPosition())

  book.body = love.physics.newBody(world, 1000, 100,"dynamic")
  book.shape = love.physics.newRectangleShape(30, 30)
  book.position = vector.new(book.body:getPosition())
end

function UpdateCompanion(dt, playerPosition)
  -- O companion vai para a posição do livro, se o player ainda não tiver ido lá
  companion.position = vector.new(companion.body:getPosition())
  book.position = vector.new(book.body:getPosition())

  if gotBook == false then
    --luz muda-se para a posição do livro
    local bookdistance = vector.magnitude(vector.sub(book.position, companion.position))
    local playerdistance = vector.magnitude(vector.sub(playerPosition, companion.position))

    if bookdistance < 2 then
      companion.body:setLinearVelocity(0, 0)
      if playerdistance < 40 then
        gotBook = true
      end
      return
    end

    local playerDiretion = vector.sub(book.position, vector.new(companion.body:getPosition()))
    playerDiretion = vector.normalize(playerDiretion)
    local force = vector.mult(playerDiretion, 200)
    companion.body:setLinearVelocity(force.x, force.y)
    print("a mafalda cheira mal")
  elseif gotBook == true then
    local playerDiretion = vector.sub(inicialPlayerPosition.position, vector.new(companion.body:getPosition()))
    playerDiretion = vector.normalize(playerDiretion)
    local force = vector.mult(playerDiretion, 200)
    companion.body:setLinearVelocity(force.x, force.y)
  end
  --Se o player já tiver pegado no livro, então a luz vai para a porta e espera pelo player
end

function DrawCompanion()
  love.graphics.circle("line", companion.position.x, companion.position.y, companion.shape:getRadius())
  if gotBook == false then
    love.graphics.polygon("line", book.body:getWorldPoints(book.shape:getPoints()))
  end 
end