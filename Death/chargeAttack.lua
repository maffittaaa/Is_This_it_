local cooldownForCharge_sec = 2 --cooldown until she can charge
local cooldown_intervalo = 0
local lastPlayerPosition

function UpdateChargeAttack(dt)
    death.position = vector2.new(death.body:getPosition())
    death.range = vector2.mag(vector2.sub(death.position, gary.position))
    lastPlayerPosition = gary.position

    if death.range < 300 then
        death.garyInSight = true
    else
        death.garyInSight = false
    end

    if death.garyInSight == true then
        cooldown_intervalo = cooldown_intervalo + dt
        if cooldown_intervalo > cooldownForCharge_sec then -- verify if the cooldown is done so she can charge again
            canCharge = true
            cooldown_intervalo = 0
        else
            canCharge = false
        end
        if canCharge and death.health > 0 then
            lastPosition = vector2.mag(vector2.sub(death.position, lastPlayerPosition))
            print(lastPosition)
            if lastPosition < 100 then
                death.body:setLinearVelocity(0, 0)
                cooldown_intervalo = 0
            elseif lastPosition > 100 then
                local playerDirection = vector2.sub(gary.position, vector2.new(death.body:getPosition()))
                playerDirection = vector2.norm(playerDirection)
                force = vector2.mult(playerDirection, 200)
                death.body:setAngle(math.atan2(force.y, force.x))
                death.body:setLinearVelocity(force.x, force.y)
            end
        end
    end
end

function DrawChargeAttack()
    deathSprites = death.idle[death.animation_frame]
    love.graphics.draw(deathSprites, death.body:getX(), death.body:getY(), death.body:getAngle(), 1, 1,
        deathSprites:getWidth() / 2, deathSprites:getHeight() / 2)

    -- -- if lastPosition < 1 then
    --     deathSprites = death.right[death.animation_frame]
    --     love.graphics.draw(deathSprites, death.body:getX(), death.body:getY(), death.body:getAngle(), 1, 1,
    --         deathSprites:getWidth() / 2, deathSprites:getHeight() / 2)
    -- end
end

function BeginContactChargeAttack(fixtureA, fixtureB)
    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "death attack" and gary.health <= 5 and gary.health > 0 then -- attack from ghost to player                                                                                                           -- cooldown time to chase again
        gary.health = gary.health - 0.5
    end
    if fixtureA:getUserData().type == "death attack" and fixtureB:getUserData().type == "player" and gary.health <= 5 and gary.health > 0 then -- attack from ghost to player
        if fixtureA:getUserData().isChasing == true and fixtureA:getUserData().garyInSight == true then                                        -- cooldown tipe to chase again
            gary.health = gary.health - 0.5
        end
    end
end
