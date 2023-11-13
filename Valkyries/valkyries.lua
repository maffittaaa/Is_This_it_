local valquiria
require "vector"

local world
local enemy
local enemyRange
local ex
local variavel
local lastPposition
local time = 0

function LoadValquiria()

  world = love.physics.newWorld(0, 0, true)
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
  enemyRange.range = enemy.shape:getRadius()
end

function UpdateValquiria(dt, playerPosition)

  world:update(dt)
  enemy.position = vector.new(enemy.body:getPosition())

  enemyRange.body:destroy()
  enemyRange.body = love.physics.newBody(world, enemy.body:getX(), enemy.body:getY(),"dynamic")

  enemy.range = vector.magnitude(vector.sub(enemy.position, playerPosition))

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
    if enemy.range < enemyRange.range and enemy.range > (enemyRange.range - 100) then
      enemy.isChasing = true
    elseif enemy.range > enemyRange.range then
      enemy.isChasing = false
    end

    if enemy.isChasing == false then
      --go to last location of player
      local lastPos = vector.magnitude(vector.sub(enemy.position, lastPposition))

      if lastPos < 1 then
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
      lastPposition = playerPosition
      local playerDiretion = vector.sub(playerPosition, vector.new(enemy.body:getPosition()))
      playerDiretion = vector.normalize(playerDiretion)
      local force = vector.mult(playerDiretion, 200)
      enemy.body:setLinearVelocity(force.x, force.y)
    end
  end
end

function DrawValquiria()
  
  love.graphics.setColor(1,1,1)
  love.graphics.polygon("fill", enemy.body:getWorldPoints(enemy.shape:getPoints()))
  
  love.graphics.circle("line", enemyRange.body:getX(), enemyRange.body:getY(), enemyRange.shape:getRadius())
end

function GetValquiriaPosition()
    return enemy.body:getPosition()
end