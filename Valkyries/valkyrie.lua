valkyries = {}
valkyriex_patrolling = 1
local is_forward_backwards
local lastPposition
local time = 0


local function printTable(t)
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

function LoadValquiria(world, posicoes, quantity)
  for i = 1, quantity, 1 do
    x = posicoes[i].x
    y = posicoes[i].y

    print(x, y)
    is_forward_backwards = 1

    valkyrie = {}

    valkyrie.body = love.physics.newBody(world, x, y, "dynamic")
    valkyrie.shape = love.physics.newRectangleShape(30, 60)
    valkyrie.fixture = love.physics.newFixture(valkyrie.body, valkyrie.shape, 1)
    valkyrie.maxvelocity = 200
    valkyrie.isMeleeing = false
    valkyrie.isRanging = false
    valkyrie.patroling = true
    valkyrie.playerInSight = false
    valkyrie.fixture:setFriction(10)
    valkyrie.body:setFixedRotation(true)
    -- valkyrie.arrow = CreateArrow()
    valkyrie.position = vector2.new(valkyrie.body:getPosition())
    valkyrie.health = 7

    meleeRange = {}
    meleeRange.body = love.physics.newBody(world, valkyrie.body:getX(), valkyrie.body:getY(), "dynamic")
    meleeRange.shape = love.physics.newCircleShape(150)
    meleeRange.fixture = love.physics.newFixture(meleeRange.body, meleeRange.shape, 2)
    meleeRange.range = meleeRange.shape:getRadius()
    meleeRange.fixture:setSensor(true)
    meleeRange.name = "enemy"
    meleeRange.fixture:setUserData({type = "MelleAttack"})

    rangedAttack = {}
    rangedAttack.body = love.physics.newBody(world, valkyrie.body:getX(), valkyrie.body:getY(), "dynamic")
    rangedAttack.shape = love.physics.newCircleShape(300)
    rangedAttack.fixture = love.physics.newFixture(rangedAttack.body, rangedAttack.shape, 2)
    rangedAttack.range = rangedAttack.shape:getRadius()
    rangedAttack.fixture:setSensor(true)
    rangedAttack.fixture:setUserData({type = "RangedAttack"})

    -- if i == 1 then
    --   table.insert(valkyries, i, valkyrie) --1
    --   table.insert(valkyries, i + 1, meleeRange) -- 2
    --   table.insert(valkyries, i + 2, rangedAttack) -- 3
    -- else
    --   table.insert(valkyries, i * 2, valkyrie) -- 4, 6, 8, 10
    --   table.insert(valkyries, i * 2 + 1, meleeRange) -- 5, 7, 9
    --   table.insert(valkyries, i * 2 + 2, rangedAttack) -- 6, 8, 10
    -- end
    table.insert(valkyries, i * 3 - 2, valkyrie)   -- 1, 4, 7
    table.insert(valkyries, i * 3 - 1, meleeRange) -- 2, 5, 8
    table.insert(valkyries, i * 3, rangedAttack)   -- 3, 6, 9

    -- for x, y in pairs(valkyries) do
    --   print(x, y)
    -- end

    printTable(GetValquiriaPosition(quantity))
    print("done")
  end
end

function UpdateValquiria(dt, playerPosition, posicoes, quantity)
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

    -- print(valkyriex_patrolling)
    if valkyries[iup].patroling == true then
      --If not in Sight, Patrol
      valkyriex_patrolling = valkyries[iup].body:getX()


      if valkyriex_patrolling >= 4149 then
        is_forward_backwards = -1
      elseif valkyriex_patrolling <= 100 then
        is_forward_backwards = 1
      elseif valkyriex_patrolling > 3464 and valkyriex_patrolling < 4149 then
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

    love.graphics.setColor(1, 1, 1)
    love.graphics.polygon("fill", valkyries[iup].body:getWorldPoints(valkyries[iup].shape:getPoints()))
    love.graphics.circle("line", valkyries[iup + 1].body:getX(), valkyries[iup + 1].body:getY(),
      valkyries[iup + 1].shape:getRadius())
    love.graphics.circle("line", valkyries[iup + 2].body:getX(), valkyries[iup + 2].body:getY(),
      valkyries[iup + 2].shape:getRadius())

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
