
local Vector = {}
Vector.__index = Vector

--mudei para uma globalFunction
local function newVector( x, y )
    return setmetatable( { x = x or 0, y = y or 0 }, Vector )
end

function isvector( vTbl )
    return getmetatable( vTbl ) == Vector
end

function Vector.__unm( vTbl )
    return newVector( -vTbl.x, -vTbl.y )
end

function Vector.__add( a, b )
    return newVector( a.x + b.x, a.y + b.y )
end

-- function Vector.__sub( a, b )
--     return newVector( a.x - b.x, a.y - b.y )
-- end

function Vector.__magnitude(vec)
    return math.sqrt(vec.x^2 + vec.y^2)
end

function Vector.__normalize(vec)
    local m = vectorMine.magnitude(vec)
    if m ~= 0 then
        return vectorMine.div(vec, m)
    end
    return vec
end

function Vector.__mul( a, b )
    if type( a ) == "number" then
        return newVector( a * b.x, a * b.y )
    elseif type( b ) == "number" then
        return newVector( a.x * b, a.y * b )
    else
        return newVector( a.x * b.x, a.y * b.y )
    end
end

function Vector.__div( a, b )
    return newVector( a.x / b, a.y / b )
end

function Vector.__eq( a, b )
    return a.x == b.x and a.y == b.y
end

function Vector:__tostring()
    return "(" .. self.x .. ", " .. self.y .. ")"
end

function Vector:ID()
    if self._ID == nil then
        local x, y = self.x, self.y
        self._ID = 0.5 * ( ( x + y ) * ( x + y + 1 ) + y )
    end

    return self._ID
end

return setmetatable( Vector, { __call = function( _, ... ) return newVector( ... ) end } )