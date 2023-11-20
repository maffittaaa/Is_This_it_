require "vector"

local world
local companion = {}
local book = {}
local wall = {}
local wall1 = {}
local wall2 = {}
local wall3 = {}
local obstacle1 = {}
local gotBook
local inicialPlayerPosition
hitted_obstacles = false

function LoadCompanion(world, playerPosition)

  inicialPlayerPosition = playerPosition
  gotBook = false
  companion.body = love.physics.newBody(world, 100, 200,"dynamic")
  companion.shape = love.physics.newCircleShape(30)
  companion.fixture = love.physics.newFixture(companion.body, companion.shape, 1)
  companion.position = vector.new(companion.body:getPosition())
  companion.name = "companion"
  companion.fixture:setUserData(companion)

  book.body = love.physics.newBody(world, 1800, 540,"dynamic")
  book.shape = love.physics.newRectangleShape(30, 30)
  book.position = vector.new(book.body:getPosition())

  wall = {}
  wall.body = love.physics.newBody(world, 960, 15,"static")
  wall.shape = love.physics.newRectangleShape(1920, 30)
  wall.fixture = love.physics.newFixture(wall.body, wall.shape, 1)
  wall.name = "wall"
  wall.fixture:setUserData(wall)
  
  wall1 = {}
  wall1.body = love.physics.newBody(world, 960, 1065,"static")
  wall1.shape = love.physics.newRectangleShape(1920, 30)
  wall1.fixture = love.physics.newFixture(wall1.body, wall1.shape, 1)
  wall1.name = "wall"
  wall1.fixture:setUserData(wall1)

  wall2 = {}
  wall2.body = love.physics.newBody(world, 15, 540,"static")
  wall2.shape = love.physics.newRectangleShape(30, 1080)
  wall2.fixture = love.physics.newFixture(wall2.body, wall2.shape, 1)
  wall2.name = "wall"
  wall2.fixture:setUserData(wall2)

  wall3 = {}
  wall3.body = love.physics.newBody(world, 1905, 540,"static")
  wall3.shape = love.physics.newRectangleShape(30, 1080)
  wall3.fixture = love.physics.newFixture(wall3.body, wall3.shape, 1)
  wall3.name = "wall"
  wall3.fixture:setUserData(wall3)

  obstacle1 = {}
  obstacle1.body = love.physics.newBody(world, 960, 750,"static")
  obstacle1.shape = love.physics.newRectangleShape(30, 1080)
  obstacle1.fixture = love.physics.newFixture(obstacle1.body, obstacle1.shape, 1)
  obstacle1.name = "obstacles"
  obstacle1.fixture:setUserData(obstacle1)
end

function PrintTable( tbl )
  for k, v in pairs( tbl ) do
      print( k, v )
  end
end

function UpdateCompanion(dt, playerPosition)
  -- O companion vai para a posição do livro, se o player ainda não tiver ido lá
  companion.position = vector.new(companion.body:getPosition())
  book.position = vector.new(book.body:getPosition())

  local playerDiretion = vector.sub(book.position, companion.position)
  playerDiretion = vector.normalize(playerDiretion)
  local force = vector.mult(playerDiretion, 50)
  local variable = 1

  if hitted_obstacles == true then
    if fixtureData.name == "obstacles" then

      -- shape_point1 = vector.new(fixtureData.shape:getPoints()[1])
      -- shape_point2 = vector.new(fixtureData.shape:getPoints()[2])
      -- shape_point3 = vector.new(fixtureData.shape:getPoints()[3])
      -- shape_point4 = vector.new(fixtureData.shape:getPoints()[4])

      print(fixtureData.body:getWorldPoints(fixtureData.shape:getPoints()))
    end
  end

  companion.body:setLinearVelocity(force.x * variable, force.y * variable)
  PrintTable(force)
  

  -- if gotBook == false then
  --   --luz muda-se para a posição do livro
  --   local bookdistance = vector.magnitude(vector.sub(book.position, companion.position))
  --   local playerdistance = vector.magnitude(vector.sub(playerPosition, companion.position))

  --   if bookdistance < 2 then
  --     companion.body:setLinearVelocity(0, 0)
  --     if playerdistance < 40 then
  --       gotBook = true
  --     end
  --     return
  --   end

  --   local playerDiretion = vector.sub(book.position, companion.position)
  --   playerDiretion = vector.normalize(playerDiretion)
  --   local force = vector.mult(playerDiretion, 200)
  --   companion.body:setLinearVelocity(force.x, force.y)
  --   print("a mafalda cheira mal")
    
  -- elseif gotBook == true then
  -- --Se o player já tiver pegado no livro, então a luz vai para a porta e espera pelo player
  --   local doorDistance = vector.magnitude(vector.sub(inicialPlayerPosition, companion.position))
  --   if doorDistance < 1 then
  --     companion.body:setLinearVelocity(0, 0)
  --     return
  --   end

  --   local playerDiretion = vector.sub(inicialPlayerPosition, companion.position)
  --   playerDiretion = vector.normalize(playerDiretion)
  --   local force = vector.mult(playerDiretion, 200)
  --   companion.body:setLinearVelocity(force.x, force.y)
  -- end
end

function DrawCompanion()
  love.graphics.circle("line", companion.position.x, companion.position.y, companion.shape:getRadius())
  love.graphics.polygon("line", wall.body:getWorldPoints(wall.shape:getPoints()))
  love.graphics.polygon("line", wall1.body:getWorldPoints(wall1.shape:getPoints()))
  love.graphics.polygon("line", wall2.body:getWorldPoints(wall2.shape:getPoints()))
  love.graphics.polygon("line", wall3.body:getWorldPoints(wall3.shape:getPoints()))

  love.graphics.polygon("line", obstacle1.body:getWorldPoints(obstacle1.shape:getPoints()))
  if gotBook == false then
    love.graphics.polygon("line", book.body:getWorldPoints(book.shape:getPoints()))
  end 
end