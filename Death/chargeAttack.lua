local chargeTime = 2   -- time that death needs to lock player position to charge to that point
local rechargeTime = 3 -- time that death needs to charge again
local isCharging = false
local canCharge = false
local chargeTimer = 0
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

    if death.garyInSight then
        if isCharging == false then
            chargeTimer = 0
            isCharging = true
            canCharge = false
        else
            chargeTimer = chargeTimer + dt
            if chargeTimer < chargeTime then
                local playerDirection = vector2.sub(gary.position, vector2.new(death.body:getPosition()))
                playerDirection = vector2.norm(playerDirection)
                death.body:setLinearVelocity(0, 0)
                death.body:setAngle(math.atan2(playerDirection.y, playerDirection.x))
            else
                local playerDirection = vector2.sub(lastPlayerPosition, vector2.new(death.body:getPosition()))
                playerDirection = vector2.norm(playerDirection)
                local force = vector2.mult(playerDirection, 200)

                local lastPlayerSeen = vector2.mag(vector2.sub(death.position, lastPlayerPosition))
                if lastPlayerSeen > 100 then
                    death.body:setAngle(math.atan2(force.y, force.x))
                    death.body:setLinearVelocity(force.x, force.y)
                else
                    isCharging = false
                    canCharge = true
                end
            end
        end
    end
end

function DrawChargeAttack()
    if canCharge then
        deathSprites = death.idle[death.animation_frame]
    else
        deathSprites = death.right[death.animation_frame]
    end

    love.graphics.draw(deathSprites, death.body:getX(), death.body:getY(), death.body:getAngle(), 1, 1,
        deathSprites:getWidth() / 2, deathSprites:getHeight() / 2)
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
