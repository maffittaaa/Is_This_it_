require "vector"
require "/MainCharacter/mainCharacter"

enemy = {}
local meleeRange
local rangedAttack
local ex
local variavel
local lastPposition
local time = 0

function LoadValquiria(world)

  ex = 50

  enemy.body = love.physics.newBody(world, ex, 100,"dynamic")
  enemy.shape = love.physics.newRectangleShape(30, 60)
  enemy.fixture = love.physics.newFixture(enemy.body, enemy.shape, 1)
  enemy.maxvelocity = 200
  enemy.isMeleeing = false
  enemy.isRanging = false
  enemy.patroling = true
  enemy.playerInSight = false
  enemy.fixture:setFriction(10)
  enemy.body:setFixedRotation(true)
  enemy.position = vector.new(enemy.body:getPosition())

  meleeRange = {}
  meleeRange.body = love.physics.newBody(GetWorld(), enemy.body:getX(), enemy.body:getY(),"dynamic")
  meleeRange.shape = love.physics.newCircleShape(300)
  meleeRange.fixture = love.physics.newFixture(meleeRange.body, meleeRange.shape, 2)
  meleeRange.range = meleeRange.shape:getRadius()
  meleeRange.fixture:setSensor(true)
  meleeRange.fixture:setUserData("MelleAttack")

  rangedAttack = {}
  rangedAttack.body = love.physics.newBody(GetWorld(), enemy.body:getX(), enemy.body:getY(),"dynamic")
  rangedAttack.shape = love.physics.newCircleShape(150)
  rangedAttack.fixture = love.physics.newFixture(rangedAttack.body, rangedAttack.shape, 2)
  rangedAttack.range = rangedAttack.shape:getRadius()
  rangedAttack.fixture:setSensor(true)
  rangedAttack.fixture:setUserData("RangedAttack")
end



function UpdateValquiria(dt, playerPosition)

  enemy.position = vector.new(enemy.body:getPosition())

  meleeRange.body:setPosition(enemy.body:getX(), enemy.body:getY())
  rangedAttack.body:setPosition(enemy.body:getX(), enemy.body:getY())

  enemy.range = vector.magnitude(vector.sub(enemy.position, playerPosition))

  if enemy.patroling == true then
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
      enemy.body:setLinearVelocity(0, -100)
    elseif enemy.body:getY() < 100 then
      enemy.body:setLinearVelocity(0, 100)
    end

    enemy.body:setPosition(ex, enemy.body:getY())

  elseif enemy.playerInSight == true  then

    if enemy.isRanging == false then
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
        local force = vector.mult(playerDiretion, 100)
        enemy.body:setLinearVelocity(force.x, force.y)
      end
      
    elseif enemy.isRanging == true then
      --Follow player
      time = 0
      lastPposition = playerPosition
      local playerDiretion = vector.sub(playerPosition, vector.new(enemy.body:getPosition()))
      playerDiretion = vector.normalize(playerDiretion)
      local force = vector.mult(playerDiretion, 100)
      enemy.body:setLinearVelocity(force.x, force.y)
    end
  end
end

function DrawValquiria()
  
  love.graphics.setColor(1,1,1)
  love.graphics.polygon("fill", enemy.body:getWorldPoints(enemy.shape:getPoints()))
  


  love.graphics.circle("line", meleeRange.body:getX(), meleeRange.body:getY(), meleeRange.shape:getRadius())
  love.graphics.circle("line", rangedAttack.body:getX(), rangedAttack.body:getY(), rangedAttack.shape:getRadius())
  
  if enemy.isChasing == false and lastPposition ~= nil and enemy.patroling == false then
    love.graphics.line(enemy.body:getX(), enemy.body:getY(), lastPposition.x, lastPposition.y)
  end
end

function GetValquiriaPosition()
    return vector.new(enemy.body:getX(), enemy.body:getY())
end