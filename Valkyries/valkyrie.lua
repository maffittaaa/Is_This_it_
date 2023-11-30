valkyries = {}
local valkyriex_patrolling
local is_forward_backwards
local lastPposition
local time = 0

function LoadValquiria(world, x, y, x2, x3, quantity)
  for i = 1, quantity, 1 do
    if i == 1 then
      x = x
    elseif i == 2 then
      x = x2
    elseif i == 3 then
      x = x3
    end

    valkyriex_patrolling = x

    local valkyrie = {}

    valkyrie.body = love.physics.newBody(world, valkyriex_patrolling, y, "dynamic")
    valkyrie.shape = love.physics.newRectangleShape(30, 60)
    valkyrie.fixture = love.physics.newFixture(valkyrie.body, valkyrie.shape, 1)
    valkyrie.maxvelocity = 200
    valkyrie.isMeleeing = false
    valkyrie.isRanging = false
    valkyrie.patroling = true
    valkyrie.playerInSight = false
    valkyrie.fixture:setFriction(10)
    valkyrie.body:setFixedRotation(true)
    valkyrie.position = vector2.new(valkyrie.body:getPosition())

    
    local meleeRange = {}
    meleeRange.body = love.physics.newBody(world, valkyrie.body:getX(), valkyrie.body:getY(), "dynamic")
    meleeRange.shape = love.physics.newCircleShape(150)
    meleeRange.fixture = love.physics.newFixture(meleeRange.body, meleeRange.shape, 2)
    meleeRange.range = meleeRange.shape:getRadius()
    meleeRange.fixture:setSensor(true)
    meleeRange.fixture:setUserData("MelleAttack")

    local rangedAttack = {}
    rangedAttack.body = love.physics.newBody(world, valkyrie.body:getX(), valkyrie.body:getY(), "dynamic")
    rangedAttack.shape = love.physics.newCircleShape(300)
    rangedAttack.fixture = love.physics.newFixture(rangedAttack.body, rangedAttack.shape, 2)
    rangedAttack.range = rangedAttack.shape:getRadius()
    rangedAttack.fixture:setSensor(true)
    rangedAttack.fixture:setUserData("RangedAttack")
  rangedAttack.cooldown = 2

    if i == 1  then
      table.insert(valkyries, i, valkyrie)
      table.insert(valkyries, i + 1, meleeRange)
      table.insert(valkyries, i + 2, rangedAttack)
    else
      table.insert(valkyries, i * 2, valkyrie)
      table.insert(valkyries, i * 2 + 1, meleeRange)
      table.insert(valkyries, i * 2 + 2, rangedAttack)
    end

    for x, y in pairs(valkyries) do
      print(x, y)
    end
    print("done")
  end
end

function UpdateValquiria(dt, playerPosition, quantity)
  for i = 1, quantity, 1 do

    local iup

    if i == 1 then
      iup = 1
    else
      iup = i * 2
    end

    valkyries[iup].position = vector2.new(valkyries[iup].body:getPosition())

    valkyries[iup + 1].body:setPosition(valkyries[iup].body:getX(), valkyries[iup].body:getY())
    valkyries[iup + 2].body:setPosition(valkyries[iup].body:getX(), valkyries[iup].body:getY())

    valkyries[iup].range = vector2.mag(vector2.sub(valkyries[iup].position, playerPosition))

    if valkyries[iup].patroling == true then
      --If not in Sight, Patrol
      valkyriex_patrolling = valkyries[iup].body:getX()

      if valkyriex_patrolling >= 1900 then
        is_forward_backwards = -1
      elseif valkyriex_patrolling <= 100 then
        is_forward_backwards = 1
      elseif valkyriex_patrolling > 100 and valkyriex_patrolling < 1900 then
        is_forward_backwards = 1
      end

      valkyriex_patrolling = valkyriex_patrolling + (dt * 200 * is_forward_backwards)

      if 95 < valkyries[iup].body:getY() and valkyries[iup].body:getY() < 105 then
        valkyries[iup].body:setPosition(valkyries[iup].position.x, 100)
      elseif valkyries[iup].body:getY() > 100 then
        valkyries[iup].body:setLinearVelocity(0, -200)
      elseif valkyries[iup].body:getY() < 100 then
        valkyries[iup].body:setLinearVelocity(0, 200)
      end

      valkyries[iup].body:setPosition(valkyriex_patrolling, valkyries[iup].body:getY())
    elseif valkyries[iup].playerInSight == true then
      if valkyries[iup].isRanging == true then
        --stop velocity, while in rangedAttack
        time = 0
        lastPposition = playerPosition

        if valkyries[iup].isMeleeing == true then
          local playerDiretion = vector2.sub(playerPosition, vector2.new(valkyries[iup].body:getPosition()))
          playerDiretion = vector2.norm(playerDiretion)
          local force = vector2.mult(playerDiretion, 200)
          valkyries[iup].body:setLinearVelocity(force.x, force.y)
          return
        end
        valkyries[iup].body:setLinearVelocity(0, 0)
        --if not meleeAttacking, do rangedAttack
      elseif valkyries[iup].isRanging == false then
        --go to last location of player
        local lastPos = vector2.mag(vector2.sub(valkyries[iup].position, lastPposition))

        if lastPos < 1 then
          time = time + dt
          valkyries[iup].body:setLinearVelocity(0, 0)
          if time > 2 then
            valkyries[iup].patroling = true
            valkyries[iup].playerInSight = false
            time = 0
            return
          end
          return
        elseif lastPos > 1 then
          local playerDiretion = vector2.sub(lastPposition, vector2.new(valkyries[iup].body:getPosition()))
          playerDiretion = vector2.norm(playerDiretion)
          local force = vector2.mult(playerDiretion, 200)
          valkyries[iup].body:setLinearVelocity(force.x, force.y)
        end
      end
    end
  end 
end

function DrawValquiria(quantity)
  for i = 1, quantity, 1 do

    local iup

    if i == 1 then
      iup = 1
    else
      iup = i * 2
    end

    print(i)
    love.graphics.setColor(1, 1, 1)
    love.graphics.polygon("fill", valkyries[iup].body:getWorldPoints(valkyries[iup].shape:getPoints()))
    love.graphics.circle("line", valkyries[iup + 1].body:getX(), valkyries[iup + 1].body:getY(), valkyries[iup + 1].shape:getRadius())
    love.graphics.circle("line", valkyries[iup + 2].body:getX(), valkyries[iup + 2].body:getY(), valkyries[iup + 2].shape:getRadius())

    if valkyries[iup].isChasing == false and lastPposition ~= nil and valkyries[iup].patroling == false then
      love.graphics.line(valkyries[iup].body:getX(), valkyries[iup].body:getY(), lastPposition.x, lastPposition.y)
    end
  end
end

function GetValquiriaPosition(quantity)
  for i = 1, quantity, 1 do

    local iup

    if i == 1 then
      iup = 1
    else
      iup = i * 2
    end
    
    return vector2.new(valkyries[iup].body:getX(), valkyries[iup].body:getY())
  end
end