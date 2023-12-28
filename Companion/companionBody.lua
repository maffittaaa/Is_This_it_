companion = {}

function LoadCompanionBody(world, position)
    companion.body = love.physics.newBody(world, position.x, position.y, "dynamic")

    companion.idle = {}
    for i = 1, 3, 1 do
        companion.idle[i] = love.graphics.newImage("Sprites/companion_idle_" .. i .. ".png")
    end

    companion.left = {}
    for i = 1, 3, 1 do
        companion.left[i] = love.graphics.newImage("Sprites/companion_left_" .. i .. ".png")
    end

    companion.right = {}
    for i = 1, 3, 1 do
        companion.right[i] = love.graphics.newImage("Sprites/companion_right_" .. i .. ".png")
    end

    companion.shape = love.physics.newRectangleShape(30, 60)
    companion.fixture = love.physics.newFixture(companion.body, companion.shape, 1)
    companion.lostGary = false
    companion.body:setFixedRotation(true)
    companion.fixture:setSensor(true)
    companion.position = vector2.new(companion.body:getPosition())
    companion.animation_frame = 1
    companion.animation_timer = 0
    companion.type = "companion"
    companion.fixture:setUserData(companion)
end

function UpdateCompanionBody(dt)
    companion.position = vector2.new(companion.body:getPosition())

    local distanceToGary = vector.magnitude(vector.sub(companion.position, GetPlayerPosition()))

    if distanceToGary > width then
        companion.lostGary = true
        companion.body:setLinearVelocity(0, 0)
    elseif distanceToGary > height then
        companion.body:setLinearVelocity(0, 0)
        companion.lostGary = true
    end

    if distanceToGary < 100 then
        companion.lostGary = false
    end

    companion.animation_timer = companion.animation_timer + dt
    if companion.animation_timer > 0.1 then
        companion.animation_frame = companion.animation_frame + 1
        if companion.animation_frame > 3 then
            companion.animation_frame = 1
        end
        companion.animation_timer = 0
    end
end

function DrawCompanionBody()
    love.graphics.setColor(1, 1, 1)
    local companionSprites = companion.idle[companion.animation_frame]
    local velx, vely = companion.body:getLinearVelocity()
    print(companion.body:getLinearVelocity())
    if velx > 0 then
        companionSprites = companion.right[companion.animation_frame]
    elseif velx < 0 then
        companionSprites = companion.left[companion.animation_frame]
    elseif vely > 0 and velx < 0 then
        print("aaaaaaaaaaaaaaa")
        companionSprites = companion.idle[companion.animation_frame]
    end
    -- print (companion.idle[companion.animation_frame])
    love.graphics.draw(companionSprites, companion.body:getX(), companion.body:getY(), companion.body:getAngle(),
    1, 1, companionSprites:getWidth() / 2, companionSprites:getHeight() / 2)
end