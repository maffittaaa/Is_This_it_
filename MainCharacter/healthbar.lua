healthbar = {}

function LoadHealthBars()
    healthbar.ghost = {}
    for i = 1, #ghosts, 1 do
        healthbar.ghost[i] = vector2.new(ghosts[i].body:getX(), ghosts[i].body:getY() + 60)
    end
    healthbar.gary = vector2.new(gary.body:getX(), gary.body:getY() + 60)
end

function UpdateHealthBars()
    for i = 1, #ghosts, 1 do
        healthbar.ghost[i] = vector2.new(ghosts[i].body:getX() - 35, ghosts[i].body:getY() - 60)
    end
    healthbar.gary = vector2.new(gary.body:getX() - 35, gary.body:getY() - 60)
end

function DrawHealthBars()
    if gary.health > 0 then
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", healthbar.gary.x, healthbar.gary.y, 70, 10)
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", healthbar.gary.x, healthbar.gary.y, 14 * gary.health, 5)
    else
        for i = #healthbar, 1, -1 do
            local num = healthbar[i]
            if num == 1 and num == 2 then
                table.remove(healthbar, i)
                print("healthbar on", healthbar[i])
            end
        end
    end

    for i = 1, #ghosts, 1 do    
        if ghosts[i].health <= 4 and ghosts[i].health > 0 then
            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("fill", healthbar.ghost[i].x, healthbar.ghost[i].y, 70, 10)
            love.graphics.setColor(1, 0, 0)
            love.graphics.rectangle("fill", healthbar.ghost[i].x, healthbar.ghost[i].y, 17.5 * ghosts[i].health, 4)
        else
            for i = #healthbar, 1, -1 do
                local num = healthbar[i]
                if num == 1 and num == 2 then
                    table.remove(healthbar, i)
                    print("healthbar on", healthbar[i])
                end
            end
        end
    end
    love.graphics.setColor(1, 1, 1)

end
