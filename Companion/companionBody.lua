companion = {}

function LoadCompanionBody(world, position)
    companion.body = love.physics.newBody(world, position.x, position.y, "dynamic")
    companion.shape = love.physics.newRectangleShape(30, 60)
    companion.fixture = love.physics.newFixture(companion.body, companion.shape, 1)
    companion.lostGary = false
    companion.body:setFixedRotation(true)
    companion.fixture:setSensor(true)
    companion.position = vector2.new(companion.body:getPosition())
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
end

function DrawCompanionBody()
    love.graphics.setColor(0, 0, 1)
    love.graphics.circle("fill", companion.body:getX(), companion.body:getY(), 20)
end