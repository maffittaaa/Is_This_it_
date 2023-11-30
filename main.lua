function PrintTable( tbl )
    for k, v in pairs( tbl ) do
        print( k, v )
    end
end

require "loveExample/MeuVector"

Vector = require ("loveExample/vector")
profile = require ("loveExample/profile")
Luafinding = require ("loveExample/luafinding")

-- local profile = require "profile"
-- local Vector = require "vector"
-- local Luafinding = require "luafinding"

local map = {}

local mapSize = 100
local screenSize = 1500
local tileSize = screenSize / mapSize

local pathAstar = nil
local start = Vector( 1, 1 )
local finish = Vector( mapSize, mapSize )

local clickedTile = nil

local world
local companionPosition
local waitFor = 0
local deltaTime = 0
local variable = false
local i = 1
local ones = 0
local zeros = 0


local function updatePath()
    pathAstar = Luafinding( start, finish, map ):GetPath()
end

local runPerformanceTest = true
local printEveryTest = false
local profileFromProfiler = false
local timesToRun = 100
local seed = os.clock()

function LoadMap()
    -- reads the content of the file
    local file = io.open("loveExample/map.txt")

    for x = 1, mapSize do
        for line in file:lines() do
            map[x] = {}
            for y = 1, #line, 1 do
                map[x][y] = line:sub(y,y)
                if map[x][y] == "1" then
                    map[x][y] = false
                elseif map[x][y] == "0" then
                    map[x][y] = true
                end
            end
            x = x + 1
        end
    end

    file:close()
    print(ones, zeros)
    updatePath()
end


function love.load() --AiLoad()
    -- world = love.physics.newWorld(0, 0, true)

    love.window.setMode( screenSize, (screenSize * 9)/16 )
    math.randomseed( seed )

    companionPosition = start
    --LoadCompanion()


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
                print( "Test #" .. i .. " took " .. newOneTime - oneTime .. " seconds.\nPath found: " .. tostring( type( foundPath ) == "table" ) .. "\nStart Position: " .. tostring( startPos ) .. "\nEnd Position: " .. tostring( endPos ) .. "\n\n" )
                oneTime = newOneTime
            else
                Luafinding( table.remove( precalculatedPoints ), table.remove( precalculatedPoints ), map ):GetPath()
            end
        end

        local timeTaken = os.clock() - startTime
        print( "It took " .. timeTaken .. " seconds to run the pathfinding test " .. timesToRun .. " times." )
        if profileFromProfiler then
            profile.stop()
            print( "\n\nprofile.lua report:\n" .. profile.report( 10 ) )
        end
    end
end

function love.draw() --Aidraw()

    for x = 1, mapSize do -- iterates through the matrix and draw the elements
        for y = 1, mapSize do
            local fillStyle = "line"

            if map[x][y] == false then
                fillStyle = "fill"
                love.graphics.setColor(1, 0, 0)
            else
                love.graphics.setColor(1, 1, 1)
            end

            love.graphics.rectangle(fillStyle, (x - 1) * tileSize, (y - 1) * tileSize, tileSize, tileSize)
        end  
    end

    if pathAstar then
        love.graphics.setColor( 0, 0.8, 0 )
        for _, v in ipairs( pathAstar ) do
            love.graphics.rectangle( "fill", ( v.x - 1 ) * tileSize, ( v.y - 1 ) * tileSize, tileSize, tileSize )
        end
        love.graphics.setColor( 0, 0, 0 )

        --PrintTable(Luafinding( start, finish, map ):GetPath())
    end

    love.graphics.setColor(0, 0, 1)
    love.graphics.circle("fill", companionPosition.x, companionPosition.y, 20)
end

function love.update(dt)
    deltaTime = deltaTime + dt
    local destino

    if deltaTime > 0.1 and variable == true then
        destino = Luafinding(start, finish, map ):GetPath()[i]
        
        companionPosition = destino * tileSize
        deltaTime = 0
        i = i + 1
        if i > #Luafinding(start, finish, map ):GetPath() then
            i = 1
            deltaTime = 0
            variable = false
        end
    end
end

function CompanionPath()
    print("here")
    variable = true
    companionPosition = vectorMine.new(start.x, start.y)
end

function love.keypressed( key )
    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
        CompanionPath()
    end
end

function love.mousepressed( x, y, button )
    if button == 1 then
        local hoveredTile = Vector( math.floor( x / tileSize ) + 1, math.floor( y / tileSize ) + 1 )
        if not clickedTile then
            clickedTile = hoveredTile
            companionPosition = vectorMine.new(x, y)
            return
        end

        start = clickedTile
        finish = hoveredTile

        clickedTile = nil
        hoveredTile = nil

        updatePath()
    end
end

--FUNÇÕES QUE NÃO ESTOU A USAR DE MOMENTO

-- local function randomizeMap()
--     for x = 1, mapSize do
--         map[x] = {}
--         for y = 1, mapSize do
--             map[x][y] = true
--         end
--     end

--     for _ = 1, math.random( 10, 100 ) do
--         local x = math.random( 1, mapSize - 2 )
--         local y = math.random( 1, mapSize - 2 )

--         if math.random() > 0.5 then
--             for n = 1, 5 do
--                 map[x][math.min( mapSize, y + n )] = false
--             end
--         else
--             for n = 1, 5 do
--                 map[math.min( mapSize, x + n )][y] = false
--             end
--         end
--     end

--     updatePath()
-- end

--LOVE.DRAW
-- love.graphics.setColor( 0.3, 0.3, 0.3 )
-- for x = 1, mapSize do
--     for y = 1, mapSize do
--         local fillStyle = "line"

--         love.graphics.setColor( 0.3, 0.3, 0.3 )

--         if not map[x][y] then
--             fillStyle = "fill"
--             love.graphics.setColor( 1, 0, 0)
--         end

--         love.graphics.rectangle( fillStyle, ( x - 1 ) * tileSize, ( y - 1 ) * tileSize, tileSize, tileSize )
--     end
-- end