require("animacion")
Jugador = {}

Jugador.__index = Jugador

function Jugador:crear(posX,posY,al,anc,ruta,vi)


    local o = setmetatable({},Jugador)
    o.x = posX
    o.y = posY
    o.direccion = 0
    o.velocidad = 75
    o.alto = al
    o.ancho = anc
    o.origen_x = o.ancho / 2
    o.origen_y = o.alto / 2
    o.vida = vi
    o.animacion = CrearAnimacion(ruta, 3, 16, 16, 5, true,o.direccion)
    o.animacion.activado = true

    return o
end

function Jugador:golpeado(hit)

    if hit then
        jugador.vida = jugador.vida - 1 
    end
    
end
function Jugador:movimiento(dt)
     
    
    if love.keyboard.isDown("right") and jugador.hitbox_x < ventana.ancho-30 then

        jugador.x = jugador.x + (jugador.velocidad * dt)
        cambioDireccion(jugador.animacion,3)

        jugador.animacion.activa = true
       
    elseif love.keyboard.isDown("left") and jugador.hitbox_x > 15 then

        jugador.x = jugador.x - (jugador.velocidad * dt)
        cambioDireccion(jugador.animacion,2)
        jugador.animacion.activa = true
        
    elseif love.keyboard.isDown("up") and jugador.hitbox_y > 15 then

        jugador.y = jugador.y - (jugador.velocidad * dt)

        cambioDireccion(jugador.animacion,1)
        jugador.animacion.activa = true
       
       
    elseif love.keyboard.isDown("down") and jugador.hitbox_y < ventana.alto-30 then

        jugador.y = jugador.y + (jugador.velocidad * dt)
        jugador.animacion.activa = true
        cambioDireccion(jugador.animacion,0)
        
    else
        jugador.animacion.activa = false

    end

    ActualizarAnimacion(jugador.animacion,dt, false)
    jugador.hitbox_x = jugador.x - jugador.origen_x
    jugador.hitbox_y = jugador.y - jugador.origen_y
    
end

function Jugador:dibujo()
    
    DibujarAnimacion(jugador.animacion, jugador.x, jugador.y, jugador.origen_x, jugador.origen_y)
    love.graphics.print("Vida : ",5,0,0,1,1)
    love.graphics.print(jugador.vida,45,0,0,1.1,1.1)
    

end

function Jugador:Hitbox()

    love.graphics.rectangle("line",jugador.hitbox_x,jugador.hitbox_y,jugador.ancho,jugador.alto) 
end