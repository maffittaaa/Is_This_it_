life = {}
life.index = life
instance = setmetatable({}, life)

function CreateLife(x, y)
    instance.x = x
    instance.y = y
    instance.img = love.graphics.newImage("MainCharacter/life.png")
    instance.width = instance.img:getWidth()
    instance.height =  instance.img:getHeight()
    return instance
end

function DrawLife()
    love.graphics.draw(sprites.life, instance.img:getWidth(), instance.img:getHeight())
end