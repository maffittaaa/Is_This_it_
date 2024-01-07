local button_height = 93
local buttons = {}
local mainMenuBackground = love.graphics.newImage("Mapa/Assets/Main_Menu_Background.png")
local StarsBackground = love.graphics.newImage("Mapa/Assets/Stars_Background.png")
local rotation = 0

function NewButton(text,fn)   
   font = love.graphics.newFont(24)
    return {text = text, fn = fn, now = false, last = false
    }
end

function LoadMainMenu()
    table.insert(buttons,NewButton("", 
    function()
        gameState = Restarting
    end))
    table.insert(buttons,NewButton("",
        function()
            love.event.quit(0)
        end))

    src1 = love.audio.newSource("MainFiles/Sounds/Ambient/MainMenu.wav", "stream")
    src1:setVolume(0.9) -- 90% of ordinary volume
    src1:play()
end

function RestartingGame(world)
    LoadMain(world)
    gameState = GamePlay
end

function UpdateMainMenu(dt)
    rotation = rotation + (dt*0.05)
end

function DrawMainMenu()
    local ww = love.graphics.getWidth()
    local wh = love.graphics.getHeight()

    local button_width = 539
    local margin = 48
    local total_height = (button_height + margin) * #buttons
    local cursor_y = 0

    love.graphics.setColor(1,1,1)
    love.graphics.draw(StarsBackground, width/2, height/2 + 300, rotation, 1, 1, StarsBackground:getWidth() / 2, StarsBackground:getHeight() / 2)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(mainMenuBackground, width/2, height/2, 0, 1, 1, mainMenuBackground:getWidth() / 2, mainMenuBackground:getHeight() / 2)


    for i, button in ipairs(buttons) do
        button.last = button.now

        local buttonx = ((ww * 0.5) - (button_width * 0.5))
        local buttony = ((wh * 0.5) - total_height * 0.5 + cursor_y ) + 103

        local color = {0,0,0}

        local mousex, mousey= love.mouse.getPosition()

        local hot = mousex > buttonx and mousex < buttonx + button_width and mousey > buttony and mousey < buttony + button_height

        if hot then
            color = {0.7,0.7,0.7}
        end

        button.now = love.mouse.isDown(1)

        if button.now and not button.last and hot then
            button.fn()
        end 

        love.graphics.setColor(color)
        love.graphics.rectangle("line", buttonx, buttony,button_width,button_height)
        
        local textW = font:getWidth(button.text)
        local textH = font:getHeight(button.text)
        
        love.graphics.setColor(0.2,0.2,0.2)
        love.graphics.print(button.text, font, (ww * 0.5) - textW * 0.5, buttony + textH * 0.5)
        cursor_y= cursor_y + (button_height + margin)
    end

    
end