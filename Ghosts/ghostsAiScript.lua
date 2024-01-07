function PrintTable( tbl )
    for k, v in pairs( tbl ) do
        print( k, v )
    end
end

local map = {}

local mapSize = 240
local tileSize = 32

local pathAstar = nil
local start = Vector(1, 1)
local finish = Vector( mapSize, mapSize )

local clickedTile = nil
local deltaTime = 0
walking = false
local i = 1
local tilesPath = {}

local destino

-- local function updatePath()
--     pathAstar = Luafinding( start, finish, map ):GetPath()
-- end

local runPerformanceTest = true
local printEveryTest = false
local profileFromProfiler = false
local timesToRun = 100

function LoadGhostsMap()
    mapData = ghostsMap

    local walkablePath = {
        40
    }
    
    for x = 1, #mapData, 1 do
        map[x] = {}
        for y = 1, mapSize, 1 do
            map[x][y] = mapData[(y - 1) * mapSize + (x%mapSize)]
            v = 1
            while v > 0 do
                if map[x][y] == walkablePath[v] then
                    map[x][y] = true
                    tilesPath[i] = vector.new(x%mapSize, y)
                    i = i + 1
                    v = 0
                
                elseif map[x][y] ~= walkablePath[v] then
                    v = v + 1

                    if v > #walkablePath then
                        map[x][y] = false
                        v = 0
                    end
                end
            end
        end
    end

    print(#mapData * mapSize)
    print(#tilesPath)
    updatePath()
end

function LoadGhostsAi() --AiLoad()
    LoadGhostsMap()



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


    start = tilesPath[math.random(1, #tilesPath)]
    finish = tilesPath[math.random(1, #tilesPath)]

end


function UpdateGhostsMap(dt)
    deltaTime = deltaTime + dt

    if deltaTime > 2 then
        local noPath = true
        --start = finish

        --while noPath == true do
            --PrintTable(finish)
            --if pathAstar ~= nil then
                --noPath = false
            --end
            
            --finish = tilesPath[math.random(1, #tilesPath)]
            --updatePath()
        --end
        --PrintTable(start)
        --PrintTable(finish)
        deltaTime = 0
    end
    for i = 1, #ghosts, 1 do
        
        ghostRealPosition = vector.new(ghosts[i].body:getPosition())

        -- if deltaTime > 0.22 and walking == true then
            
        --     destino = Luafinding(start, finish, map ):GetPath()[i]

        --     local destinoDistance = vector.magnitude(vector.sub(ghosts[i], ghostRealPosition))

        --     local normForce = vector.normalize(vector.sub(ghosts[i], ghostRealPosition))
        --     local force = vector.mult(normForce, 150)

        --     if i == #Luafinding(start, finish, map ):GetPath() then
        --         if destinoDistance < 16 then
        --             ghosts[i].body:setLinearVelocity(0, 0)
        --             i = i + 1
        --         elseif i <= #Luafinding(start, finish, map ):GetPath() then
        --             ghosts[i].body:setLinearVelocity(force.x, force.y)
        --         end
        --     else
        --         ghosts[i].body:setLinearVelocity(force.x, force.y)
        --         i = i + 1
        --     end

        --     deltaTime = 0
            
        --     if i > #Luafinding(start, finish, map):GetPath() then
        --         i = 1
        --         start = finish
        --         finish = companionPath[p]
                
        --         deltaTime = 0
        --         walking = false
        --     end
        -- end
    end
end

function CompanionPath()
    walking = true
    -- ghost position = vector.new(start.x, start.y)
end


function DrawGhostsMap() --Aidraw()
    for x = 1, mapSize do -- iterates through the matrix and draw the elements
        for y = 1, mapSize do
            local fillStyle = "line"

            if map[x][y] == false then
                fillStyle = "fill"
                love.graphics.setColor(1, 0, 0)
                love.graphics.rectangle(fillStyle, (x - 1) * tileSize, (y - 1) * tileSize, tileSize, tileSize)
            else
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle(fillStyle, (x - 1) * tileSize, (y - 1) * tileSize, tileSize, tileSize)
            end
        end
    end

    if pathAstar then
        love.graphics.setColor( 0, 0.8, 0 )
        for _, v in ipairs( pathAstar ) do
            love.graphics.circle( "fill", ( v.x - 0.5) * tileSize, ( v.y - 0.5 ) * tileSize, 5)
        end
        love.graphics.setColor( 0, 0, 0 )
    end

    -- for i = 1, #companionPath, 1 do
    --     love.graphics.circle( "fill", (companionPath[i].x - 0.5) * tileSize, (companionPath[i].y - 0.5 ) * tileSize, 5)
    -- end

    DrawCompanionBody()
    -- if destino then
    --     love.graphics.circle( "fill", (destino.x - 0.5) * tileSize, (destino.y - 0.5 ) * tileSize, 5)
    -- end
    -- love.graphics.setColor(0, 0, 1)
    -- love.graphics.circle("fill", companion.position.x, companion.position.y, 20)
end