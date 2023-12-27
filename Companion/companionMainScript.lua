function PrintTable( tbl )
    for k, v in pairs( tbl ) do
        print( k, v )
    end
end

local map = {}

local mapSize = 240
local tileSize = 32

local pathAstar = nil
local start = Vector( 1, 1 )
local finish = Vector( mapSize, mapSize )

local clickedTile = nil
local deltaTime = 0
walking = false
local i = 1
local companionPath = {}
local p = 2 --p de path (que path é que o companion irá fazer)

local destino
local companionRealPosition


local function updatePath()
    pathAstar = Luafinding( start, finish, map ):GetPath()
end

local runPerformanceTest = true
local printEveryTest = false
local profileFromProfiler = false
local timesToRun = 100

function LoadMap()
    mapData = originalData

    for x = 1, #mapData, 1 do
        map[x] = {}
        for y = 1, 240, 1 do
            map[x][y] = mapData[(y - 1) * 240 + (x%240)]
            if map[x][y] ~= 0 then
                map[x][y] = true
            elseif map[x][y] == 0 then
                map[x][y] = false
            end
        end
    end
    updatePath()
end

function LoadCompanion(world) --AiLoad()
    LoadMap()

    if runPerformanceTest then
        if profileFromProfiler then profile.start() end
        local startTime = os.clock()
        local oneTime = os.clock()

        local precalculatedPoints = {}
        for _ = 1, timesToRun * 2 do
            table.insert( precalculatedPoints, Vector( math.random( 1, mapSize ), math.random( 1, mapSize ) ) )
        end

        for i = 1, timesToRun do
            if printEveryTest then
                local startPos = table.remove( precalculatedPoints )
                local endPos = table.remove( precalculatedPoints )
                local foundPath = Luafinding( startPos, endPos, map ):GetPath()
                local newOneTime = os.clock()
                --print( "Test #" .. i .. " took " .. newOneTime - oneTime .. " seconds.\nPath found: " .. tostring( type( foundPath ) == "table" ) .. "\nStart Position: " .. tostring( startPos ) .. "\nEnd Position: " .. tostring( endPos ) .. "\n\n" )
                oneTime = newOneTime
            else
                Luafinding( table.remove( precalculatedPoints ), table.remove( precalculatedPoints ), map ):GetPath()
            end
        end

        local timeTaken = os.clock() - startTime
        --print( "It took " .. timeTaken .. " seconds to run the pathfinding test " .. timesToRun .. " times." )
        if profileFromProfiler then
            profile.stop()
            --print( "\n\nprofile.lua report:\n" .. profile.report( 10 ) )
        end
    end

    --Loading with preset coordinates for the companion

    companionPath[1] = Vector(28, 37)
    companionPath[2] = Vector(112, 42)
    companionPath[3] = Vector(137, 46)
    companionPath[4] = Vector(55, 68)
    companionPath[5] = Vector(73, 143)
    companionPath[6] = Vector(144, 127)
    companionPath[7] = Vector(153, 147)
    companionPath[8] = Vector(189, 104)
    companionPath[9] = Vector(190, 92)
    companionPath[10] = Vector(98, 80)
    companionPath[11] = Vector(100, 122)
    companionPath[12] = Vector(26, 153)
    companionPath[13] = Vector(184, 71)
    companionPath[14] = Vector(211, 113)
    companionPath[15] = Vector(203, 146)

    start = companionPath[1]
    finish = companionPath[p]

    --companion.position = vector.new((start.x * 32) - 16, (start.y * 32) - 16)
    LoadCompanionBody(world, vector.new((start.x * 32) - 16, (start.y * 32) - 16))
end


function UpdateCompanion(dt)
    UpdateCompanionBody(dt)

    local chosenPath

    deltaTime = deltaTime + dt
    chosenPath = math.random(100)
    companionRealPosition = vector.new(companion.body:getPosition())

    if deltaTime > 0.33 and walking == true and companion.lostGary == false then
        
        destino = Luafinding(start, finish, map ):GetPath()[i]

        companion.position = vector.sub(destino * tileSize, vector.new(tileSize/2, tileSize/2))

        local destinoDistance = vector.magnitude(vector.sub(companion.position, companionRealPosition))

        local normForce = vector.normalize(vector.sub(companion.position, companionRealPosition))
        local force = vector.mult(normForce, 100)

        --print()
        if i == #Luafinding(start, finish, map ):GetPath() then
            if destinoDistance < 15 then
                companion.body:setLinearVelocity(0, 0)
                i = i + 1  
            elseif i <= #Luafinding(start, finish, map ):GetPath() then
                companion.body:setLinearVelocity(force.x, force.y)
            end
        else
            companion.body:setLinearVelocity(force.x, force.y)
            i = i + 1
        end

        deltaTime = 0
        
        if i > #Luafinding(start, finish, map):GetPath() then
            i = 1
            start = finish

            if p == 2 then

                if chosenPath <= 50 then
                    p = 3
                elseif chosenPath > 50 then
                    p = 4
                end

            elseif p == 3 then

                if chosenPath <= 66 then
                    p = 9
                elseif chosenPath > 66 then
                    p = 6
                end

            elseif p == 4 then

                if chosenPath <= 50 then
                    p = 10
                elseif chosenPath > 50 then
                    p = 5
                end

            elseif p == 5 then

                if chosenPath <= 25 then
                    p = 11
                elseif chosenPath <= 50 then
                    p = 12
                elseif chosenPath > 50 then
                    p = 6
                end

            elseif p == 6 then

                if chosenPath <= 66 then
                    p = 7
                elseif chosenPath > 66 then
                    p = 5
                end

            elseif p == 7 then

                p = 15
            
            elseif p == 8 then

                if chosenPath <= 66 then
                    p = 7
                elseif chosenPath > 66 then
                    p = 14
                end

            elseif p == 9 then

                if chosenPath <= 50 then
                    p = 13
                elseif chosenPath > 50 then
                    p = 8
                end

            elseif p == 10 then

                p = 5

            elseif p == 11 then

                p = 6

            elseif p == 12 then

                p = 6

            elseif p == 13 then

                p = 8

            elseif p == 14 then

                p = 7

            end

            print(chosenPath)

            finish = companionPath[p]

            PrintTable(start)
            PrintTable(finish)
            deltaTime = 0
            walking = false
        end
    end
end

function CompanionPath()
    walking = true
    companion.position = vector.new(start.x, start.y)
end

function love.mousepressed( x, y, button )
    if button == 1 then
        x, y = camera:toWorldCoords(x, y)

        local hoveredTile = Vector( math.floor( x / tileSize ) + 1, math.floor( y / tileSize ) + 1 )
        if not clickedTile then
            clickedTile = hoveredTile
            companion.position = vector.new(x, y)
            return
        end

        start = clickedTile
        finish = hoveredTile
        
        PrintTable(start)
        PrintTable(finish)

        clickedTile = nil
        hoveredTile = nil

        updatePath()
    end
end

function DrawCompanion() --Aidraw()
    -- for x = 1, mapSize do -- iterates through the matrix and draw the elements
    --     for y = 1, mapSize do
    --         local fillStyle = "line"

    --         if map[x][y] == false then
    --             fillStyle = "fill"
    --             love.graphics.setColor(1, 0, 0)
    --         else
    --             love.graphics.setColor(1, 1, 1)
    --             love.graphics.rectangle(fillStyle, (x - 1) * tileSize, (y - 1) * tileSize, tileSize, tileSize)
    --         end
    --     end
    -- end

    if pathAstar then
        love.graphics.setColor( 0, 0.8, 0 )
        for _, v in ipairs( pathAstar ) do
            love.graphics.circle( "fill", ( v.x - 0.5) * tileSize, ( v.y - 0.5 ) * tileSize, 5)
        end
        love.graphics.setColor( 0, 0, 0 )
    end

    DrawCompanionBody()
    if destino then
        love.graphics.circle( "fill", (destino.x - 0.5) * tileSize, (destino.y - 0.5 ) * tileSize, 5)
    end
    -- love.graphics.setColor(0, 0, 1)
    -- love.graphics.circle("fill", companion.position.x, companion.position.y, 20)
end