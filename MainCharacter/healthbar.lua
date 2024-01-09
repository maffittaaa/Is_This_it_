healthbar = {}

function LoadHealthBars()
    healthbar.ghost = {}
    for i = 1, #ghosts, 1 do
        healthbar.ghost[i] = vector2.new(ghosts[i].body:getX(), ghosts[i].body:getY() + 60)
    end

    healthbar.gary = vector2.new(gary.body:getX(), gary.body:getY() + 60)

    healthbar.valkyrie = {}
    for i = 1, #valkyries, 1 do
        healthbar.valkyrie[i] = vector2.new(valkyries[i].body:getX(), valkyries[i].body:getY() + 60)
    end

    healthbar.death = vector2.new(death.body:getX(), death.body:getY() + 60)
end

function UpdateHealthBars()
    for i = 1, #ghosts, 1 do
        if ghosts[i].health > 0 then
            healthbar.ghost[i] = vector2.new(ghosts[i].body:getX() - 35, ghosts[i].body:getY() - 60)
        end
    end

    for i = #healthbar, 1, -1 do
        local num = healthbar[i]
        if num == 1 and num == 2 then
            table.remove(healthbar, i)
        end
    end

    healthbar.gary = vector2.new(gary.body:getX() - 35, gary.body:getY() - 60)
    for i = #healthbar, 1, -1 do
        local num = healthbar[i]
        if num == 1 and num == 2 then
            table.remove(healthbar, i)
        end
    end

    for i = 1, #valkyries, 1 do
        healthbar.valkyrie[i] = vector2.new(valkyries[i].body:getX() - 65, valkyries[i].body:getY() - 100)
    end

    for i = #healthbar, 1, -1 do
        local num = healthbar[i]
        if num == 1 and num == 2 then
            table.remove(healthbar, i)
        end
    end

    healthbar.death = vector2.new(death.body:getX(), death.body:getY() + 60)
    for i = #healthbar, 1, -1 do
        local num = healthbar[i]
        if num == 1 and num == 2 then
            table.remove(healthbar, i)
        end
    end
end

function DrawHealthBars()
    for i = 1, #ghosts, 1 do
        if inDarkSide == true then
            if ghosts[i].health <= 4 and ghosts[i].health > 0 then
                love.graphics.setColor(1, 0, 0)
                love.graphics.rectangle("fill", healthbar.ghost[i].x, healthbar.ghost[i].y, 17.5 * ghosts[i].health, 4)
            else
                for i = #healthbar, 1, -1 do
                    local num = healthbar[i]
                    if num == 1 and num == 2 then
                        table.remove(healthbar, i)
                    end
                end
            end
        end
    end

    for i = 1, #valkyries, 1 do
        if valkyries[i].health <= 7 and ghosts[i].health > 0 then
            love.graphics.setColor(1, 0, 0)
            love.graphics.rectangle("fill", healthbar.valkyrie[i].x, healthbar.valkyrie[i].y, 17.5 * valkyries[i].health,
                7)
        else
            for i = #healthbar, 1, -1 do
                local num = healthbar[i]
                if num == 1 and num == 2 then
                    table.remove(healthbar, i)
                end
            end
        end
    end

    if death.health > 0 then
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", healthbar.death.x - 100, healthbar.death.y - 170, 14 * death.health, 10)
    end

    love.graphics.setColor(1, 1, 1)
end
