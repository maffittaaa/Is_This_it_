ghost = {}
-- trigger = {}
-- local ghostRange
local lastPposition
local time = 0
local i
local destroy_ghost_fixture = false

function LoadGhost(world, x, y, i)
    local ghost = {}

    ghost.body = love.physics.newBody(world, x, y, "dynamic")
    ghost.shape = love.physics.newRectangleShape(30, 60)
    ghost.fixture = love.physics.newFixture(ghost.body, ghost.shape, 1)
    ghost.maxvelocity = 200
    ghost.isChasing = false
    ghost.lostGary = false
    ghost.patroling = true
    ghost.garyInSight = true
    ghost.ghostx_patrolling = 1
    ghost.is_forward_backwards = 1
    ghost.fixture:setFriction(10)
    ghost.body:setFixedRotation(true)
    ghost.position = vector2.new(ghost.body:getPosition())
    ghost.health = 4
    ghost.timer = 2
    ghost.type = "ghost"
    ghost.id = i
    ghost.fixture:setSensor(true)
    ghost.fixture:setUserData(ghost)

    ghost.ghostRange = {}
    ghost.ghostRange.body = love.physics.newBody(world, ghost.body:getX(), ghost.body:getY(), "dynamic")
    ghost.ghostRange.shape = love.physics.newCircleShape(300)

    ghost.trigger = {}
    ghost.trigger.body = love.physics.newBody(world, ghost.body:getX() - 30, 100, "static")
    ghost.trigger.shape = love.physics.newRectangleShape(40, 70)
    ghost.trigger.fixture = love.physics.newFixture(ghost.trigger.body, ghost.trigger.shape, 2)
    ghost.trigger.fixture:setSensor(true)
    ghost.trigger.type = "attack"
    ghost.trigger.id = ghost.id
    ghost.trigger.fixture:setUserData(ghost.trigger) -- trigger de lado
    return ghost
end

function UpdateGhost(dt, world)
    for k = 1, #ghosts, 1 do
        i = ghosts[k].id

        ghosts[i].position = vector2.new(ghosts[i].body:getPosition())
        ghosts[i].trigger.body:setPosition(ghosts[i].position.x, ghosts[i].position.y)

        ghosts[i].ghostRange.body:setPosition(ghosts[i].body:getX(), ghosts[i].body:getY())
        ghosts[i].range = vector2.mag(vector2.sub(ghosts[i].position, gary.position))

        if ghosts[i].timer > 0 then
            ghosts[i].timer = ghosts[i].timer - dt
        end

        if destroy_gary_fixture == true then
            ghosts[i].patroling = true
            ghosts[i].garyInSight = false
        end


        if ghosts[i].patroling == true then
            --Check if Gary in sight
            if ghosts[i].range < 300 then
                ghosts[i].garyInSight = true
                ghosts[i].patroling = false
            end
            --If not in Sight, Patrol
            ghosts[i].ghostx_patrolling = ghosts[i].body:getX()

            if ghosts[i].ghostx_patrolling >= posicoes[i + 9].x then
                ghosts[i].is_forward_backwards = -1
            elseif ghosts[i].ghostx_patrolling <= posicoes[i + 2].x then
                ghosts[i].is_forward_backwards = 1
            end

            ghosts[i].ghostx_patrolling = ghosts[i].ghostx_patrolling + (dt * 200 * ghosts[i].is_forward_backwards)


            if posicoes[i + 2].y - 5 < ghosts[i].body:getY() and ghosts[i].body:getY() < posicoes[i + 2].y + 5 then
                ghosts[i].body:setPosition(ghosts[i].position.x, posicoes[i + 2].y)
            elseif ghosts[i].body:getY() > posicoes[i + 2].y then
                ghosts[i].body:setLinearVelocity(0, -200)
            elseif ghosts[i].body:getY() < posicoes[i + 2].y then
                ghosts[i].body:setLinearVelocity(0, 200)
            end

            ghosts[i].body:setPosition(ghosts[i].ghostx_patrolling, ghosts[i].body:getY())
        elseif ghosts[i].garyInSight == true then
            --check again if gary in sight
            if ghosts[i].range > 300 then
                ghosts[i].isChasing = false
            else
                ghosts[i].isChasing = true
                ghosts[i].fixture:setSensor(true)
            end

            if ghosts[i].isChasing == false then
                --go to last location of gary
                local lastPos = vector2.mag(vector2.sub(ghosts[i].position, lastPposition))

                if lastPos < 1 then
                    time = time + dt
                    ghosts[i].body:setLinearVelocity(0, 0)
                    if time > 2 then
                        ghosts[i].patroling = true
                        ghosts[i].garyInSight = false
                        time = 0
                        return
                    end
                    return
                elseif lastPos > 1 then
                    local garyDiretion = vector2.sub(lastPposition, vector2.new(ghosts[i].body:getPosition()))
                    garyDiretion = vector2.norm(garyDiretion)
                    local force = vector2.mult(garyDiretion, 200)
                    ghosts[i].body:setLinearVelocity(force.x, force.y)
                end
            elseif ghosts[i].isChasing == true then
                --Follow gary
                time = 0
                lastPposition = gary.position
                local garyDiretion = vector2.sub(gary.position, vector2.new(ghosts[i].body:getPosition()))
                garyDiretion = vector2.norm(garyDiretion)
                local force = vector2.mult(garyDiretion, 200)
                ghosts[i].body:setLinearVelocity(force.x, force.y)
            end
        end
    end
end

function DrawGhost()
    for i = 1, #ghosts, 1 do
        if ghosts[i].health <= 4 and ghosts[i].health > 0 then
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(sprites.ghost, ghosts[i].body:getX(), ghosts[i].body:getY(), ghosts[i].body:getAngle(),
                1, 1, sprites.ghost:getWidth() / 2, sprites.ghost:getHeight() / 2)

            love.graphics.setColor(0, 1, 0)
            love.graphics.polygon("line", ghosts[i].trigger.body:getWorldPoints(ghosts[i].trigger.shape:getPoints()))

            love.graphics.setColor(1, 1, 1)
            love.graphics.circle("line", ghosts[i].ghostRange.body:getX(), ghosts[i].ghostRange.body:getY(),
                ghosts[i].ghostRange.shape:getRadius())
        elseif ghosts[i].health <= 0 then
            ghosts[i].body:setLinearVelocity(0, 0)
            if destroy_ghost_fixture == true then
                ghosts[i].isChasing = false
                ghosts[i].patroling = false
                ghosts[i].fixture:destroy()
                ghosts[i].trigger.fixture:destroy()
                ghosts[i].body:destroy()

                destroy_ghost_fixture = false
            end
        end
    end
end

function BeginContactGhost(fixtureA, fixtureB)
    for k = 1, #ghosts, 1 do


        if ghosts[k].isChasing == true and ghosts[k].garyInSight == true then
            if fixtureA:getUserData().type == "player" and fixtureB:getUserData().type == "attack" and gary.health <= 5 and gary.health > 0 then -- attack from ghost to player
                i = fixtureB:getUserData().id
                ghosts[i].timer = 1                                                                                                   -- cooldown tipe to chase again
                gary.health = gary.health - 1
                PushGaryBack(i)
                if gary.health <= 0 then
                    ghosts[i].isChasing = false
                    ghosts[i].patroling = true
                end
            end
        end
        if ghosts[k].isChasing == true and ghosts[k].garyInSight == true then
            if fixtureA:getUserData().type == "attack" and fixtureB:getUserData().type == "player" and gary.health <= 5 and gary.health > 0 then -- attack from ghost to player
                i = fixtureA:getUserData().id
                ghosts[i].timer = 1                                                                                                              -- cooldown tipe to chase again
                gary.health = gary.health - 1
                PushGaryBack(i)
                if gary.health <= 0 then
                    ghosts[i].isChasing = false
                    ghosts[i].patroling = true
                end
            end
        end
        if ghosts[k].health <= 4 and ghosts[k].health > 0 then
            if fixtureA:getUserData().type == "attack" and fixtureB:getUserData().type == "melee weapon" then -- attack from player to ghost
                ghosts[i].health = ghosts[i].health - 1
                i = fixtureA:getUserData().id
                print(i)

                if ghosts[i].health <= 0 then
                    ghosts[i].isChasing = false
                    ghosts[i].patroling = false
                end
            end
            if fixtureA:getUserData().type == "melee weapon" and fixtureB:getUserData().type == "attack" then -- attack from player to ghost
                i = fixtureB:getUserData().id
                ghosts[i].health = ghosts[i].health - 1
                if ghosts[i].health <= 0 then
                    ghosts[i].isChasing = false
                    ghosts[i].patroling = false
                end
            end
        end

        print(k, ghosts[k].health)
    end
end
