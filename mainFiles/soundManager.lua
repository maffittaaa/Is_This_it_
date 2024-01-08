local ambientSounds = {
    "MainFiles/Sounds/Ambient/MainMenu.wav",
    "MainFiles/Sounds/Ambient/BrightSide.wav",
    "MainFiles/Sounds/Ambient/Dungeon.wav",
    "MainFiles/Sounds/Ambient/Cabin.wav",
    "MainFiles/Sounds/Ambient/DarkSide.wav"
}
local source
local ambient = 1
local CheckGS = {}

function LoadSounds()
    source = love.audio.newSource(ambientSounds[ambient], "stream")
    source:setVolume(0.3)
    love.audio.play(source)

    CheckGS[1] = gameState
    CheckGS[2] = inDarkSide
    CheckGS[3] = inMasmorra
    CheckGS[4] = inCabin
end

function UpdateSounds(dt)
    if CheckGS[1] ~= gameState or CheckGS[2] ~= inDarkSide or CheckGS[3] ~= inMasmorra or CheckGS[4] ~= inCabin then
        love.audio.pause()

        if gameState == MainMenu then
            ambient = 1
        elseif gameState == GamePlay and inCabin == true then
            ambient = 4
        elseif gameState == GamePlay and inDarkSide == false then
            ambient = 2
        elseif gameState == GamePlay and inMasmorra == true then
            ambient = 3
        elseif gameState == GamePlay and inDarkSide == true then
            ambient = 5
        elseif gameState == DeadMenu then

        elseif gameState == WinMenu then

        end

        print("Ambient: " .. ambient)

        source = love.audio.newSource(ambientSounds[ambient], "stream")
        source:setVolume(0.3)
        love.audio.play(source)
    end

    CheckGS[1] = gameState
    CheckGS[2] = inDarkSide
    CheckGS[3] = inMasmorra
    CheckGS[4] = inCabin

    if not source:isPlaying() then
        if gameState == MainMenu then
            ambient = 1
        elseif gameState == GamePlay and inCabin == true then
            ambient = 4
        elseif gameState == GamePlay and inDarkSide == false then
            ambient = 2
        elseif gameState == GamePlay and inMasmorra == true then
            ambient = 3
        elseif gameState == GamePlay and inDarkSide == true then
            ambient = 5
        elseif gameState == DeadMenu then

        elseif gameState == WinMenu then

        end

        source = love.audio.newSource(ambientSounds[ambient], "stream")
        source:setVolume(0.3)
        love.audio.play(source)
    end
end
