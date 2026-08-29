Jugador = {}

Jugador.__index = Jugador

function Jugador:crear(posX,posY,ruta,vi)

    local o = setmetatable({},Jugador)
    o.x = posX
    o.y = posY
    o.sprite = love.graphics.newImage(ruta)
    o.velocidad = 75
    o.alto = o.sprite:getHeight()
    o.ancho = o.sprite:getWidth()
    o.origen_x = o.ancho / 2
    o.origen_y = o.alto / 2
    o.vida = vi
    return o
end
function Jugador:golpeado(hit)

    if hit then
        jugador.vida = jugador.vida - 1 
    end
    
end
function Jugador:movimiento(dt)
     
    if love.keyboard.isDown("right") then

        jugador.x = jugador.x + (jugador.velocidad * dt)
       
    elseif love.keyboard.isDown("left") then

        jugador.x = jugador.x - (jugador.velocidad * dt)
        
    elseif love.keyboard.isDown("up") then

       jugador.y = jugador.y - (jugador.velocidad * dt)
       
    elseif love.keyboard.isDown("down") then

        jugador.y = jugador.y + (jugador.velocidad * dt)
        
    end

    jugador.hitbox_x = jugador.x - jugador.origen_x
    jugador.hitbox_y = jugador.y - jugador.origen_y
    
end

function Jugador:dibujo()

    love.graphics.draw(jugador.sprite,jugador.x,jugador.y, 0, 1, 1, jugador.origen_x,jugador.origen_y)

    love.graphics.print("Vida : ",10,10,0,1,1)
    love.graphics.print(jugador.vida,45,10,0,1.1,1.1)

end

function Jugador:Hitbox()

    love.graphics.rectangle("line",jugador.hitbox_x,jugador.hitbox_y,jugador.ancho,jugador.alto) 
end