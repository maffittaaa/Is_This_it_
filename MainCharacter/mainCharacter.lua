require "/MainCharacter/vector"

local world
local player
local enemy
local enemyRange
local ground
local height
local width
local ex
local variavel
local lastPposition
local time

function CreatePlayer()
      love.physics.setMeter(35)
      -- 9.81 * love.physics.getMeter()
      world = love.physics.newWorld(0, 0, true)
    
      love.window.setMode(1920, 1080)
      height = love.graphics.getHeight()
      width = love.graphics.getWidth()
    
      time = 0

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
    
      ex = 50
    
      enemy = {}
      enemy.body = love.physics.newBody(world, ex, 100,"dynamic")
      enemy.shape = love.physics.newRectangleShape(30, 60)
      enemy.fixture = love.physics.newFixture(enemy.body, enemy.shape, 1)
      enemy.maxvelocity = 200
      enemy.isChasing = false
      enemy.lostPlayer = false
      enemy.patroling = true
      enemy.playerInSight = true
      enemy.fixture:setFriction(10)
      enemy.body:setFixedRotation(true)
      enemy.position = vector.new(enemy.body:getPosition())
    
      enemyRange = {}
      enemyRange.body = love.physics.newBody(world, enemy.body:getX(), enemy.body:getY(),"dynamic")
      enemyRange.shape = love.physics.newCircleShape(300)

end

function UpdatePlayer(dt)
  
  world:update(dt)
  player.position = vector.new(player.body:getPosition())
  enemy.position = vector.new(enemy.body:getPosition())

  enemyRange.body:destroy()
  enemyRange.body = love.physics.newBody(world, enemy.body:getX(), enemy.body:getY(),"dynamic")

  enemy.range = vector.magnitude(vector.sub(enemy.position, player.position))

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

  if enemy.patroling == true then
    --Check if Player in sight
    if enemy.range < 300 then
      enemy.playerInSight = true
      enemy.patroling = false
    end
    --If not in Sight, Patrol
    ex = enemy.body:getX()

    if ex >= 1900 then
      variavel = -1
    end

    if ex <= 100 then
      variavel = 1
    end
    ex = ex + (dt * 200 * variavel)

    if 95 < enemy.body:getY() and enemy.body:getY() < 105 then
      enemy.body:setPosition(enemy.position.x, 100)
    elseif enemy.body:getY() > 100 then
      enemy.body:setLinearVelocity(0, -200)
    elseif enemy.body:getY() < 100 then
      enemy.body:setLinearVelocity(0, 200)
    end

    enemy.body:setPosition(ex, enemy.body:getY())

  elseif enemy.playerInSight == true  then
    --check again if player in sight
    if enemy.range > 300 then
      enemy.isChasing = false
    else
      enemy.isChasing = true
    end

    if enemy.isChasing == false then
      --go to last location of player
      local lastPos = vector.magnitude(vector.sub(enemy.position, lastPposition))

      if lastPos < 2 then
        time = time + dt
        enemy.body:setLinearVelocity(0, 0)
        if time > 2 then
          enemy.patroling = true
          enemy.playerInSight =false
          time = 0
          return
        end
        return
      elseif lastPos > 1 then
        local playerDiretion = vector.sub(lastPposition, vector.new(enemy.body:getPosition()))
        playerDiretion = vector.normalize(playerDiretion)
        local force = vector.mult(playerDiretion, 200)
        enemy.body:setLinearVelocity(force.x, force.y)
      end
      
    elseif enemy.isChasing == true then
      --Follow player
      time = 0
      lastPposition = player.position
      local playerDiretion = vector.sub(player.position, vector.new(enemy.body:getPosition()))
      playerDiretion = vector.normalize(playerDiretion)
      local force = vector.mult(playerDiretion, 200)
      enemy.body:setLinearVelocity(force.x, force.y)
    end
  end
end

function DrawPlayer()
  love.graphics.setColor(1,1,1)
  love.graphics.polygon("fill", player.body:getWorldPoints(player.shape:getPoints()))
  
  love.graphics.setColor(1,1,1)
  love.graphics.polygon("fill", enemy.body:getWorldPoints(enemy.shape:getPoints()))

  love.graphics.setColor(0,1,0)
  love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints()))
  
  love.graphics.circle("line", enemyRange.body:getX(), enemyRange.body:getY(), enemyRange.shape:getRadius())
end