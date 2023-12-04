valkyries = {}
local time = 0
local melee = false


function printTable(t)
  local printTable_cache = {}

  local function sub_printTable(t, indent)
    if (printTable_cache[tostring(t)]) then
      print(indent .. "*" .. tostring(t))
    else
      printTable_cache[tostring(t)] = true
      if (type(t) == "table") then
        for pos, val in pairs(t) do
          if (type(val) == "table") then
            print(indent .. "[" .. pos .. "] => " .. tostring(t) .. " {")
            sub_printTable(val, indent .. string.rep(" ", string.len(pos) + 8))
            print(indent .. string.rep(" ", string.len(pos) + 6) .. "}")
          elseif (type(val) == "string") then
            print(indent .. "[" .. pos .. '] => "' .. val .. '"')
          else
            print(indent .. "[" .. pos .. "] => " .. tostring(val))
          end
        end
      else
        print(indent .. tostring(t))
      end
    end
  end

  if (type(t) == "table") then
    print(tostring(t) .. " {")
    sub_printTable(t, "  ")
    print("}")
  else
    sub_printTable(t, "  ")
  end
end

function LoadValquiria(world, quantity)
  for i = 1, quantity, 1 do
    valkyrie = {}

    valkyrie.body = love.physics.newBody(world, posicoes[i].x, posicoes[i].y, "dynamic")
    valkyrie.shape = love.physics.newRectangleShape(sprites.valkyrie:getWidth(), sprites.valkyrie:getHeight())
    valkyrie.fixture = love.physics.newFixture(valkyrie.body, valkyrie.shape, 1)
    valkyrie.maxvelocity = 200
    valkyrie.isMeleeing = false
    valkyrie.isRanging = false
    valkyrie.patroling = true
    valkyrie.playerInSight = false
    valkyrie.is_forward_backwards = 1
    valkyrie.valkyriex_patrolling = 1
    valkyrie.lastPposition = vector.new(0, 0)
    valkyrie.fixture:setFriction(10)
    valkyrie.body:setFixedRotation(true)
    valkyrie.position = vector2.new(valkyrie.body:getPosition())
    valkyrie.health = 7
    valkyrie.type = "valkyrie"
    valkyrie.fixture:setUserData(valkyrie)

    valkyrie.meleeRange = {}
    valkyrie.meleeRange.body = love.physics.newBody(world, valkyrie.body:getX(), valkyrie.body:getY(), "dynamic")
    valkyrie.meleeRange.shape = love.physics.newCircleShape(150)
    valkyrie.meleeRange.fixture = love.physics.newFixture(valkyrie.meleeRange.body, valkyrie.meleeRange.shape, 2)
    valkyrie.meleeRange.range = valkyrie.meleeRange.shape:getRadius()
    valkyrie.meleeRange.fixture:setSensor(true)
    valkyrie.meleeRange.type = "MelleAttack"
    valkyrie.meleeRange.fixture:setUserData(valkyrie.meleeRange)
    valkyrie.meleeRange.parent = i

    valkyrie.rangedAttack = {}
    valkyrie.rangedAttack.body = love.physics.newBody(world, valkyrie.body:getX(), valkyrie.body:getY(), "dynamic")
    valkyrie.rangedAttack.shape = love.physics.newCircleShape(300)
    valkyrie.rangedAttack.fixture = love.physics.newFixture(valkyrie.rangedAttack.body, valkyrie.rangedAttack.shape, 2)
    valkyrie.rangedAttack.range = valkyrie.rangedAttack.shape:getRadius()
    valkyrie.rangedAttack.fixture:setSensor(true)
    valkyrie.rangedAttack.type = "RangedAttack"
    valkyrie.rangedAttack.fixture:setUserData(valkyrie.rangedAttack)
    valkyrie.rangedAttack.parent = i

    table.insert(valkyries, i, valkyrie)

    -- for x, y in pairs(valkyries) do
    --   print(x, y)
    -- end
  end
end

function UpdateValquiria(dt, playerPosition, posicoes, quantity)
  for i = 1, quantity, 1 do

    valkyries[i].position = vector2.new(valkyries[i].body:getPosition())

    valkyries[i].meleeRange.body:setPosition(valkyries[i].body:getX(), valkyries[i].body:getY())
    valkyries[i].rangedAttack.body:setPosition(valkyries[i].body:getX(), valkyries[i].body:getY())

    valkyries[i].range = vector2.mag(vector2.sub(valkyries[i].position, playerPosition))

    -- print(valkyriex_patrolling)
    if valkyries[i].patroling == true then
      --If not in Sight, Patrol
      valkyries[i].valkyriex_patrolling = valkyries[i].body:getX()

      if valkyries[i].valkyriex_patrolling >= posicoes[i + 7].x then
        valkyries[i].is_forward_backwards = -1
      elseif valkyries[i].valkyriex_patrolling <= posicoes[i].x then
        valkyries[i].is_forward_backwards = 1
      end

      if valkyries[i].valkyriex_patrolling < posicoes[i + 7].x and valkyries[i].valkyriex_patrolling > posicoes[i].x then
        valkyries[i].fixture:setSensor(true)
      end

      valkyries[i].valkyriex_patrolling = valkyries[i].valkyriex_patrolling +
          (dt * 200 * valkyries[i].is_forward_backwards)

      if posicoes[i].y - 5 < valkyries[i].body:getY() and valkyries[i].body:getY() < posicoes[i].y + 5 then
        valkyries[i].body:setPosition(valkyries[i].position.x, posicoes[i].y)
      elseif valkyries[i].body:getY() > posicoes[i].y then
        valkyries[i].body:setLinearVelocity(0, -200)
      elseif valkyries[i].body:getY() < posicoes[i].y then
        valkyries[i].body:setLinearVelocity(0, 200)
      end

      valkyries[i].body:setPosition(valkyries[i].valkyriex_patrolling, valkyries[i].body:getY())
    elseif valkyries[i].playerInSight == true then
      if valkyries[i].isRanging == true then
        valkyries[i].fixture:setSensor(true)

        --stop velocity, while in rangedAttack
        time = 0
        valkyries[i].lastPposition = playerPosition

        if valkyries[i].isMeleeing == true then
          local playerDiretion = vector2.sub(playerPosition, vector2.new(valkyries[i].body:getPosition()))
          playerDiretion = vector2.norm(playerDiretion)
          local force = vector2.mult(playerDiretion, 200)
          valkyries[i].body:setLinearVelocity(force.x, force.y)
          return
        end
        valkyries[i].body:setLinearVelocity(0, 0)
        --if not meleeAttacking, do rangedAttack
      elseif valkyries[i].isRanging == false then
        --go to last location of player

        local lastPos = vector2.mag(vector2.sub(valkyries[i].position, valkyries[i].lastPposition))


        if lastPos < 1 then
          time = time + dt
          valkyries[i].body:setLinearVelocity(0, 0)
          if time > 2 then
            valkyries[i].patroling = true
            valkyries[i].playerInSight = false
            time = 0
            return
          end
          return
        elseif lastPos > 1 then
          local playerDiretion = vector2.sub(valkyries[i].lastPposition, vector2.new(valkyries[i].body:getPosition()))
          playerDiretion = vector2.norm(playerDiretion)
          local force = vector2.mult(playerDiretion, 200)
          valkyries[i].body:setLinearVelocity(force.x, force.y)
        end
      end
    end
  end
end

function DrawValquiria(quantity)
  for i = 1, quantity, 1 do
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(sprites.valkyrie, valkyries[i].body:getX(), valkyries[i].body:getY(), valkyries[i].body:getAngle(),
      1, 1, sprites.valkyrie:getWidth() / 2, sprites.valkyrie:getHeight() / 2)
    love.graphics.circle("line", valkyries[i].meleeRange.body:getX(), valkyries[i].meleeRange.body:getY(),
      valkyries[i].meleeRange.shape:getRadius())
    love.graphics.circle("line", valkyries[i].rangedAttack.body:getX(), valkyries[i].rangedAttack.body:getY(),
      valkyries[i].rangedAttack.shape:getRadius())

    if valkyries[i].isChasing == false and lastPposition ~= nil and valkyries[i].patroling == false then
      love.graphics.line(valkyries[i].body:getX(), valkyries[i].body:getY(), lastPposition.x, lastPposition.y)
    end
  end
end

function GetValquiriaPosition(quantity)
  for i = 1, quantity, 1 do
    return vector2.new(valkyries[i].body:getX(), valkyries[i].body:getY())
  end
end

function BeginContactValkyrie(fixtureA, fixtureB)
  for i = 1, valkeries_quantity, 1 do
    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "MelleAttack" then
      valkyries[fixtureB:getUserData().parent].isMeleeing = true
      valkyries[fixtureB:getUserData().parent].isRanging = true
    elseif fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "RangedAttack" then
      valkyries[fixtureB:getUserData().parent].playerInSight = true
      valkyries[fixtureB:getUserData().parent].isRanging = true
      valkyries[fixtureB:getUserData().parent].patroling = false
    end

    if fixtureA:getUserData().type == "MelleAttack" and fixtureB:getUserData().type == "player" then
      valkyries[fixtureA:getUserData().parent].isRanging = true
      valkyries[fixtureA:getUserData().parent].isMeleeing = true
    elseif fixtureA:getUserData().type == "RangedAttack" and fixtureB:getUserData().type == "player" then
      valkyries[fixtureA:getUserData().parent].playerInSight = true
      valkyries[fixtureA:getUserData().parent].patroling = false
      valkyries[fixtureA:getUserData().parent].isRanging = false
    end
  end
end

function EndContactValkyrie(fixtureA, fixtureB)
  for i = 1, valkeries_quantity, 1 do
    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "MelleAttack" then
      valkyries[fixtureB:getUserData().parent].isMeleeing = false
      valkyries[fixtureB:getUserData().parent].isRanging = true
    end

    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "RangedAttack" then
      valkyries[fixtureB:getUserData().parent].playerInSight = true
      valkyries[fixtureB:getUserData().parent].isRanging = false
      valkyries[fixtureB:getUserData().parent].isMeleeing = false
    end

    if fixtureA:getUserData().type == "MelleAttack" and fixtureB:getUserData().type == "player" then
      valkyries[fixtureA:getUserData().parent].isMeleeing = false
      valkyries[fixtureA:getUserData().parent].isRanging = true
    end

    if fixtureA:getUserData().type == "RangedAttack" and fixtureB:getUserData().type == "player" then
      valkyries[fixtureA:getUserData().parent].isRanging = false
      valkyries[fixtureA:getUserData().parent].isMeleeing = false
    end
  end
end
