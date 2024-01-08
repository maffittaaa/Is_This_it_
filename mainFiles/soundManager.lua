local ambientSounds = {
    "MainFiles/Sounds/Ambient/MainMenu.wav",
    "MainFiles/Sounds/Ambient/BrightSide.wav",
    "MainFiles/Sounds/Ambient/Dungeon.wav",
    "MainFiles/Sounds/Ambient/Cabin.wav",
    "MainFiles/Sounds/Ambient/DarkSide.wav",
    "MainFiles/Sounds/Ambient/Dungeon2.wav",
    "MainFiles/Sounds/Ambient/Lights.wav",
    "MainFiles/Sounds/Ambient/GaryDead.wav"
}
local source
local source2
local ambient = 1
local CheckGS = {}

function LoadSounds()
    source = love.audio.newSource(ambientSounds[ambient], "stream")
    ambient = 4
    source2 = love.audio.newSource(ambientSounds[ambient], "stream")
    source:setVolume(0.3)
    source2:setVolume(0.2)

    love.audio.play(source)
    love.audio.play(source2)
    
    CheckGS[1] = gameState
    CheckGS[2] = inDarkSide
    CheckGS[3] = inMasmorra
    CheckGS[4] = inCabin
end


function UpdateSounds(dt)

    if CheckGS[1] ~= gameState or CheckGS[2] ~= inDarkSide or CheckGS[3] ~= inMasmorra or CheckGS[4] ~= inCabin then
		love.audio.pause()

        source:setVolume(0.3)

        if gameState == MainMenu then
            ambient = 1
        elseif gameState == GamePlay and inCabin == true then
            ambient = 4
        elseif gameState == GamePlay and inDarkSide == false then
            ambient = 2
        elseif gameState == GamePlay and inMasmorra == true then
            source:setVolume(0.7)
            ambient = 3
        elseif gameState == GamePlay and inDarkSide == true then
            ambient = 5
        elseif gameState == DeadMenu then
            ambient = 8
        elseif gameState == WinMenu then
    
        end

        source = love.audio.newSource(ambientSounds[ambient], "stream")

        source2:setVolume(0.2)

        if gameState == MainMenu then
            ambient = 4
        elseif gameState == GamePlay and inCabin == true then
            ambient = 1
        elseif gameState == GamePlay and inDarkSide == false then
            ambient = 1
        elseif gameState == GamePlay and inMasmorra == true then
            ambient = 6
        elseif gameState == GamePlay and inDarkSide == true then
            ambient = 7
        elseif gameState == DeadMenu then
            ambient = 8
        elseif gameState == WinMenu then

        end

        source2 = love.audio.newSource(ambientSounds[ambient], "stream")

        if ambient == 1 then
            source2:setVolume(0)
        end

        if ambient == 8 then
            source2:setVolume(0)
            source:setVolume(0.2)
        end

        love.audio.play(source)
        love.audio.play(source2)
    end

    CheckGS[1] = gameState
    CheckGS[2] = inDarkSide
    CheckGS[3] = inMasmorra
    CheckGS[4] = inCabin

    if not source:isPlaying() then

        source:setVolume(0.3)

        if gameState == MainMenu then
            ambient = 1
        elseif gameState == GamePlay and inCabin == true then
            ambient = 4
        elseif gameState == GamePlay and inDarkSide == false then
            ambient = 2
        elseif gameState == GamePlay and inMasmorra == true then
            ambient = 3
            source:setVolume(0.7)
        elseif gameState == GamePlay and inDarkSide == true then
            ambient = 5
        elseif gameState == DeadMenu then
            ambient = 8
        elseif gameState == WinMenu then
    
        end

        source = love.audio.newSource(ambientSounds[ambient], "stream")

        if ambient ~= 8 then
            love.audio.play(source)
        end

    elseif not source2:isPlaying() then

        source2:setVolume(0.2)

        if gameState == MainMenu then
            ambient = 4
        elseif gameState == GamePlay and inCabin == true then
            ambient = 1
        elseif gameState == GamePlay and inDarkSide == false then
            ambient = 1
        elseif gameState == GamePlay and inMasmorra == true then
            ambient = 6 
            source2:setVolume(0.5)
        elseif gameState == GamePlay and inDarkSide == true then
            ambient = 7
        elseif gameState == DeadMenu then

        elseif gameState == WinMenu then

        end

        source2 = love.audio.newSource(ambientSounds[ambient], "stream")

        if ambient == 1 then
            source2:setVolume(0)
        end

        love.audio.play(source2)
	end

    if ambient == 7 then   
        local b = a*0.3
        source2:setVolume(b)
    end
end