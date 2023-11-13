vector = {}

function vector.new(px, py)
    return {x = px, y = py}
end

function vector.magnitude(vec)
    return math.sqrt(vec.x^2 + vec.y^2)
end

function vector.normalize(vec)
    local m = vector.magnitude(vec)
    if m ~= 0 then
        return vector.div(vec, m)
    end
    return vec
end

function vector.div(vec, n)
    local result = vector.new(0, 0)
    result.x = vec.x / n
    result.y = vec.y / n
    return result
end

function vector.unit(vec)
    local magnitude = vector.magnitude(vec)
    local result = {x = vec.x/magnitude, y = vec.y/magnitude}
    return result
end

function vector.add3D(vec1, vec2)
    local result = math.sqrt((vec1.x - vec2.x)^2 + (vec1.y - vec2.y)^2 + (vec1.z - vec2.z)^2)
    return result
end

function vector.DotProd3D(vec1, vec2)
    local vec3 = {}
    vec3.x = (vec2.y * vec1.z) - (vec2.z * vec1.y)
    vec3.y = (vec2.x * vec1.z) - (vec2.z * vec1.x)
    vec3.z = (vec2.y * vec1.x) - (vec2.x * vec1.y)
    return vec3
end

function vector.DotProd2D(vec1, vec2)
    local result = (vec1.x * vec2.x) + (vec1.y * vec2.y)
    return result
end

--Dot Product

function vector.DotProdAng(vec1, vec2, ang)
    vec1 = vector.magnitude(vec1)
    vec2 = vector.magnitude(vec2)
    local result = vector.DotProd2D(vec1, vec2) * math.cos(ang)
    return result
end

function vector.FindAng(vec1, vec2)
    local dotP = vector.DotProd2D(vec1, vec2)
end

--Subtraction

function vector.sub(vec1, vec2)
    local result = {x = (vec1.x - vec2.x), y = (vec1.y - vec2.y)}
    return result
end

--Multiplication

function vector.mult(vec, n)
    local result = vector.new(0, 0)
    result.x = vec.x * n
    result.y = vec.y * n
    return result
end