local world
local message
local k = 1
local onoff = true
invencible = false
drawCheats = true
enemysPosicoesIniciais = {}
enemysPosicoesFinais = {}
ghosts = {}
valkyries = {}

drawOpenDiary = false
nextPage = false
forward = false
almost_the_end = false
the_end = false

local flashTimer = 0
flashing = false
flashingSpeed = math.random(2, 4)

function KeyPressed(e)
    if e == 'e' then
        if gary_sword.body:isActive() then
            gary_sword.body:setActive(false)
        else
            gary_sword.body:setActive(true)
        end
    end

    if e == 'r' then
        drawOpenDiary = not drawOpenDiary
    end
    if e == '1' then
        nextPage = false
        forward = false
        almost_the_end = false
        the_end = false
    end

    if e == '3' then
        nextPage = true
        forward = false
        almost_the_end = false
        the_end = false
    end
    if e == '5' then
        nextPage = false
        forward = true
        almost_the_end = false
        the_end = false
    end
    if e == '7' then
        nextPage = false
        forward = false
        almost_the_end = true
        the_end = false
    end
    if e == '9' then
        nextPage = false
        forward = false
        almost_the_end = false
        the_end = true
    end


    --Cheats
    if e == "tab" then
      drawCheats = not drawCheats
    end

    if e == "q" then
        if player_velocity < 1000 then
            player_velocity = player_velocity + 250
        elseif player_velocity >= 1000 then
            player_velocity = 250
        end
    end

    if e == "p" then
        local strategicPositions = {}
        strategicPositions[1] = { x = 3349, y = 1152 }
        strategicPositions[2] = { x = 2497, y = 2791 }
        strategicPositions[3] = { x = 6482, y = 4538 }
        strategicPositions[4] = { x = 900, y = 1000 }

        gary.body:setPosition(strategicPositions[k].x, strategicPositions[k].y)

        k = k + 1

        if k > 4 then
            k = 1
        end
    end

    if e == "f" then
        if onoff == true then
            gary.fixture:setSensor(false)
            onoff = false
            return
        elseif onoff == false then
            gary.fixture:setSensor(true)
            onoff = true
        end
    end

    if e == "+" then
      invencible = not invencible
    end

    if e == "space" and walking == false then
        CompanionPath()
    end
end

function LoadMain(world)
    message = CreateMessage(
        "Cheat Codes \n [q] = quick/change velocity \n [f] = fixture/deactivate player fixture \n [p] = position/change position \n [+] = more/invencible mode")

    sti = require "Mapa/sti"
    gameMap = sti("Mapa/map.lua")

    --Call "load" function of every script

    LoadAllEnmenies(world)
    LoadSprites()
    LoadGary(world, 900, 1000)
    LoadGaryAttack(world)
    LoadHealthBars()
    LoadCollectibles(world)
    LoadCompanion(world)
    --LoadGhostsAi()
    LoadMainMap(world)

    --Loading Camera
    camera = Camera(gary.body:getX(), gary.body:getY(), width, height, 1.2)
end

function BeginContactMain(fixtureA, fixtureB)
    BeginContactGary(fixtureA, fixtureB)
    BeginContactValkyrieSword(fixtureA, fixtureB)
    BeginContactValkyrie(fixtureA, fixtureB)
    BeginContactGhost(fixtureA, fixtureB)
    BeginContactCollectibles(fixtureA, fixtureB)
    BeginContactArrows(fixtureA, fixtureB)
end

function EndContactMain(fixtureA, fixtureB)
    EndContactValkyrie(fixtureA, fixtureB)
end

function UpdateMain(dt, world)
    camera:update(dt)
    camera:follow(gary.body:getX(), gary.body:getY())
    camera:setFollowLerp(0.2)
    camera:setFollowLead(0)

    camera:setFollowStyle('TOPDOWN')

    if timer_camera > 1 then
        camera:setFollowStyle('LOCKON')
    end

    UpdateCompanion(dt)
    --UpdateGhostsMap(dt)
    UpdateHealthBars()
    UpdateGary(dt)
    UpdateGaryAttack(dt)
    UpdateGhost(dt, ghostsPos)
    UpdateValkyrieRangedAttack(world, dt)
    UpdateValquiria(dt, GetPlayerPosition(), valkyriesPos, valkeries_quantity)
    UpdateValkyrieSword(world, dt)
    UpdateCollectibles(dt)

    flashTimer = flashTimer + dt
end

function DrawMain()
    --Call draw function of every script
    camera:attach()

    gameMap:drawLayer(gameMap.layers["Relva"])
    gameMap:drawLayer(gameMap.layers["Rio"])
    gameMap:drawLayer(gameMap.layers["Path"])
    gameMap:drawLayer(gameMap.layers["BUshes"])

    gameMap:drawLayer(gameMap.layers["WoodenCabinShadow"])

    if collectible_key.counter == 1 then
        gameMap:drawLayer(gameMap.layers["MasmorraOpen"])
        gameMap:drawLayer(gameMap.layers["WoodenCabinOpen"])
        for i = 1, #bigDoorMas, 1 do
            bigDoorMas[i].fixture:setSensor(true)
        end
    else
        gameMap:drawLayer(gameMap.layers["MasmorraClosed"])
        gameMap:drawLayer(gameMap.layers["WoodenCabinClosed"])
    end

    DrawCollectibles()
    DrawGary()
    DrawHealthBars()
    DrawCompanion()
    --DrawGhostsMap()
    DrawGaryAttack()
    DrawGhost()
    DrawValquiria(valkeries_quantity)
    DrawValkyrieAttack()
    DrawValkyrieSword()
    gameMap:drawLayer(gameMap.layers["Arvores"])
    gameMap:drawLayer(gameMap.layers["Lampadas"])

    flashing = FlashEffect()

    if flashing == true then
        local a = math.abs(math.cos(love.timer.getTime() * flashingSpeed % 2 * math.pi))
        love.graphics.setColor(1, 1, 1, a)
        gameMap:drawLayer(gameMap.layers["LampadasEfeito1"])
        love.graphics.setColor(1, 1, 1)
    end
    if flashing == false then
        local a = math.abs(math.cos(love.timer.getTime() * flashingSpeed % 2 * math.pi))
        love.graphics.setColor(1, 1, 1, a)
        gameMap:drawLayer(gameMap.layers["LampadasEfeito2"])
        love.graphics.setColor(1, 1, 1)
    end

    gameMap:drawLayer(gameMap.layers["WoodenCabinAbovePlayer"])
    gameMap:drawLayer(gameMap.layers["MasmorraTeto"])

    DrawHearts()
    DrawDiary()
    DrawUiCollectibles()

    if drawCheats == true then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(sprites.inventory, camera.x - (width/2 * 0.8), camera.y - 60, 0, 4, 3)
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(love.graphics.newFont(12))
        love.graphics.print(message.message, camera.x - (width/2 * 0.78), camera.y - 25)
        love.graphics.setColor(1, 1, 1)
    end

    if drawOpenDiary == true then
        DrawFirstPage()
        DrawSecondPage()
        DrawThirdPage()
        DrawForthPage()
        DrawFifthPage()
        DrawSixthPage()
        DrawSeventhPage()
        DrawPageEight()
        DrawPageNine()
        DrawPageTen()
    end

    if gary.health <= 0 then
        gameState = DeadMenu
    end

    camera:detach()
    camera:draw() -- Must call this to use camera:fade!
end

function FlashEffect()
    flashingSpeed = math.random(2,4)
    
    if flashTimer > 2 and flashTimer < 4 then
        return true
    end

    if flashTimer >= 4 then
        flashTimer = 0
    end
    return false
end