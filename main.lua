require("enemigo")
require("jugador")

ventana = {--[[Tabla de la venta]]

    ancho = 400,
    alto = 300,
    escala = 2
}
hitbox = false
atrapado = false

sentido = 0

ataque = nil
function love.load()--[[Funcion donde creo la ventana y doy valores a algunos datos]]

    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)

    love.graphics.setDefaultFilter("nearest", "nearest")
    
    jugador = Jugador:crear(ventana.ancho/2,ventana.alto/2,16,16,"img/jugador.png",3)
    enemigo1 = Enemigo:crear(16,16,"img/enemigo3.png",1,25)
    enemigo2 = Enemigo:crear(16,16,"img/enemigo3.png",1,25)
    enemigo3 = Enemigo:crear(16,16,"img/enemigo3.png",3,25)
   
   

    lienzo = love.graphics.newCanvas(ventana.ancho,ventana.alto)--[[Inicializo un lienzo]]
end

function love.keypressed(key)--[[Tecla para ver la hitbox]]

    if key == "h" then
        hitbox = not hitbox
    end
    
end
function colisiones(x1,y1,ancho1,alto1,x2,y2,ancho2,alto2)--[[Controlador de colisiones]]
    return x1<x2+ancho2 and x2<x1+ancho1 and y1<y2+alto2 and y2<y1+alto1
end

function love.update(dt)--[[Movimiento inicial del jugador]]


    --[[Calculo de las hitbox]]

    Jugador.movimiento(jugador,dt)
    Enemigo.movimiento(enemigo1,jugador.x,jugador.y,dt)
    Enemigo.movimiento(enemigo2,jugador.x,jugador.y,dt)
    Enemigo.movimiento(enemigo3,jugador.x,jugador.y,dt)

    enemigo1.reinicio = colisiones(
        jugador.hitbox_x,
        jugador.hitbox_y,
        jugador.ancho,
        jugador.alto,
        enemigo1.hitbox_x,
        enemigo1.hitbox_y,
        enemigo1.ancho,
        enemigo1.alto
    ) 
    enemigo2.reinicio = colisiones(
        jugador.hitbox_x,
        jugador.hitbox_y,
        jugador.ancho,
        jugador.alto,
        enemigo2.hitbox_x,
        enemigo2.hitbox_y,
        enemigo2.ancho,
        enemigo2.alto
    ) 
    enemigo3.reinicio = colisiones(
        jugador.hitbox_x,
        jugador.hitbox_y,
        jugador.ancho,
        jugador.alto,
        enemigo3.hitbox_x,
        enemigo3.hitbox_y,
        enemigo3.ancho,
        enemigo3.alto
    ) 
    Jugador.golpeado(jugador,enemigo1.reinicio)
    Jugador.golpeado(jugador,enemigo2.reinicio)
    Jugador.golpeado(jugador,enemigo3.reinicio)
end
function debugHitbox()--[[Muestra las hitbox en pantalla]]
    
    love.graphics.setColor(1,0,0)

    Jugador.Hitbox(jugador)
    Enemigo.Hitbox(enemigo1)
    Enemigo.Hitbox(enemigo2)
    Enemigo.Hitbox(enemigo3)
    love.graphics.setColor(1,1,1)
    
end

function love.draw()--[[Dibuja en pantalla el lienzo con el jugador]]
   
    love.graphics.setCanvas(lienzo)
      
        love.graphics.clear()
       
        Enemigo.dibujar(enemigo1)
        Enemigo.dibujar(enemigo2)
        Enemigo.dibujar(enemigo3)
        
        
        Enemigo.dano(enemigo1)
        Enemigo.dano(enemigo2)
        Enemigo.dano(enemigo3)

        love.graphics.setColor(0.54,0.27,0.07)
        
            love.graphics.rectangle("fill",0,0,15,ventana.alto) 
            love.graphics.rectangle("fill",0,0,ventana.ancho,15) 
            love.graphics.rectangle("fill",ventana.ancho-15,0,15,ventana.alto) 
            love.graphics.rectangle("fill",0,ventana.alto-15,ventana.ancho,15) 
        
        love.graphics.setColor(1,1,1)

        Jugador.dibujo(jugador)
        
        if hitbox then
            debugHitbox()
        end
    love.graphics.setCanvas()
    
    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)

end
