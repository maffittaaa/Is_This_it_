vectorMine = {}

function vectorMine.new(px, py)
    return {x = px, y = py}
end

function vectorMine.magnitude(vec)
    return math.sqrt(vec.x^2 + vec.y^2)
end

function vectorMine.normalize(vec)
    local m = vectorMine.magnitude(vec)
    if m ~= 0 then
        return vectorMine.div(vec, m)
    end
    return vec
end

function vectorMine.div(vec, n)
    local result = vectorMine.new(0, 0)
    result.x = vec.x / n
    result.y = vec.y / n
    return result
end

function vectorMine.unit(vec)
    local magnitude = vectorMine.magnitude(vec)
    local result = {x = vec.x/magnitude, y = vec.y/magnitude}
    return result
end

function vectorMine.add3D(vec1, vec2)
    local result = math.sqrt((vec1.x - vec2.x)^2 + (vec1.y - vec2.y)^2 + (vec1.z - vec2.z)^2)
    return result
end

function vectorMine.DotProd3D(vec1, vec2)
    local vec3 = {}
    vec3.x = (vec2.y * vec1.z) - (vec2.z * vec1.y)
    vec3.y = (vec2.x * vec1.z) - (vec2.z * vec1.x)
    vec3.z = (vec2.y * vec1.x) - (vec2.x * vec1.y)
    return vec3
end

function vectorMine.DotProd2D(vec1, vec2)
    local result = (vec1.x * vec2.x) + (vec1.y * vec2.y)
    return result
end

--Dot Product

function vectorMine.DotProdAng(vec1, vec2, ang)
    vec1 = vectorMine.magnitude(vec1)
    vec2 = vectorMine.magnitude(vec2)
    local result = vectorMine.DotProd2D(vec1, vec2) * math.cos(ang)
    return result
end

function vectorMine.FindAng(vec1, vec2)
    local dotP = vectorMine.DotProd2D(vec1, vec2)
end

--Subtraction

function vectorMine.sub(vec1, vec2)
    local result = {x = (vec1.x - vec2.x), y = (vec1.y - vec2.y)}
    return result
end

--Multiplication

function vectorMine.mult(vec, n)
    local result = vectorMine.new(0, 0)
    result.x = vec.x * n
    result.y = vec.y * n
    return result
end