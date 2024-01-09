local lastPlayerPosition

local isCharging = false
local chargeTime = 2 -- time that death needs to lock player position to charge to that point
local charge = false
local facingRight = true

function UpdateChargeAttack(dt)
    death.position = vector2.new(death.body:getPosition())
    death.range = vector2.mag(vector2.sub(death.position, gary.position))

    --looking for player
    if isCharging == false and charge == false then
        if death.range < 300 then
            death.garyInSight = true
            isCharging = true
            return
        end
    end

    --started charging the attack because player in sight
    if isCharging == true and chargeTime > 0 then
        chargeTime = chargeTime - dt
        if chargeTime <= 0 then
            chargeTime = 2
            charge = true
            isCharging = false
            lastPlayerPosition = gary.position
            return
        end
    end

    if charge == false and death.animation_frame == 3 then
        death.trigger.body:setActive(true) -- set the trigger active in the last frame
    else
        death.trigger.body:setActive(false)
    end

    if charge == true then
        local playerDirection = vector2.sub(lastPlayerPosition, vector2.new(death.body:getPosition()))
        playerDirection = vector2.norm(playerDirection)



        local force = vector2.mult(playerDirection, 200)
        death.body:setLinearVelocity(force.x, force.y)

        local deathPosition = vector2.new(death.body:getPosition())
        local deathRange = vector2.mag(vector2.sub(deathPosition, lastPlayerPosition))
        facingRight = RightSide(lastPlayerPosition.x, deathPosition.x)
        death.facingRight = facingRight


        local distanceToPlayer = 70
        if deathRange < distanceToPlayer then
            charge = false
            death.body:setLinearVelocity(0, 0)
        end
    end
end

function RightSide(playerPositionX, enemyPositionX)
    return playerPositionX > enemyPositionX
end

function DrawChargeAttack()
    if charge then
        deathSprites = death.idle[death.animation_frame]
    elseif facingRight then
        deathSprites = death.right[death.animation_frame]
    else
        deathSprites = death.left[death.animation_frame]
    end

    love.graphics.draw(deathSprites, death.body:getX(), death.body:getY(), death.body:getAngle(), 1, 1,
        deathSprites:getWidth() / 2, deathSprites:getHeight() / 2)

    if death.trigger.body:isActive() then
        if death.facingRight == true then
            love.graphics.rectangle("line", death.body:getX() + 50, death.body:getY() - 20, 40, 70)
        else
            love.graphics.rectangle("line", death.body:getX() - 100, death.body:getY() - 20, 40, 70)
        end
    end
end

function BeginContactChargeAttack(fixtureA, fixtureB)
    if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "death attack" and gary.health <= 5 and gary.health > 0 then -- attack from death to player                                                                                                           -- cooldown time to chase again
        gary.health = gary.health - 1
    end
    if fixtureA:getUserData().type == "death attack" and fixtureB:getUserData().type == "player" and gary.health <= 5 and gary.health > 0 then -- attack from death to player
        gary.health = gary.health - 1
    end
end
