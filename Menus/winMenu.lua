local button_height = 48
local buttons = {}

function NewButton(text,fn)   
   font = love.graphics.newFont(24)
    return {text = text, fn = fn, now = false, last = false
    }
end

function LoadWinMenu()

    table.insert(buttons,NewButton("Restart", 
    function()
        gameState = Restarting
    end))

    table.insert(buttons,NewButton("Main Menu", 
    function()
        gameState = MainMenu
    end))

    table.insert(buttons,NewButton("Exit",
        function()
            love.event.quit(0)
        end))
end

function UpdateWinMenu()
    
end

function DrawWinMenu()
    local ww = love.graphics.getWidth()
    local wh = love.graphics.getHeight()

    love.graphics.setColor(0.1,0.1,0.3)
    love.graphics.rectangle("fill", camera.x - width/2, camera.y - height, width * 2, height * 2)

    local button_width = ww * (1/3)
    local margin = 16
    local total_height = (button_height + margin) * #buttons
    local cursor_y = 0
    
    for i, button in ipairs(buttons) do
        button.last = button.now

        local buttonx = (ww * 0.5) - (button_width * 0.5)
        local buttony = (wh * 0.5) - total_height * 0.5 + cursor_y 
    
        local color = {0.5,0.5,0.8}
    
        local mousex, mousey= love.mouse.getPosition()

        local hot = mousex > buttonx and mousex < buttonx + button_width and mousey > buttony and mousey < buttony + button_height
    
        if hot then
            color = {0.7,0.7,1}
        end

        button.now = love.mouse.isDown(1)

        if button.now and not button.last and hot then
            button.fn()
        end 

        love.graphics.setColor(color)
        love.graphics.rectangle("fill", buttonx, buttony,button_width,button_height)
        
        local textW = font:getWidth(button.text)
        local textH = font:getHeight(button.text)
        
        love.graphics.setColor(0.2,0.2,0.2)
        love.graphics.print(button.text, font, (ww * 0.5) - textW * 0.5, buttony + textH * 0.5)
        cursor_y= cursor_y + (button_height + margin)
    end
end