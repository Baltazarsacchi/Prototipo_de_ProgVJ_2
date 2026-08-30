require("enemigo")
require("jugador")
require("disparo")

ventana = {--[[Tabla de la venta]]

    ancho = 400,
    alto = 300,
    limite_x = 375,
    limite_y = 275,
    escala = 2
}
hitbox = false
atrapado = false

sentido = 0

inicio = true

ataque = nil

mouse_x = 0
mouse_y = 0

function love.load()--[[Funcion donde creo la ventana y doy valores a algunos datos]]

    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)

    love.graphics.setDefaultFilter("nearest", "nearest")
    musica = love.audio.newSource("audio/golpe.mp3", "static")
    musica2 = love.audio.newSource("audio/reaparicion_enemigos.mp3", "static")
    musica_fondo = love.audio.newSource("audio/fondo.ogg","stream")

    musica_fondo:setLooping(true)
    musica_fondo:setVolume(0.5)

    musica_fondo:play()
    
    jugador = Jugador:crear(ventana.ancho/2,ventana.alto/2,16,16,"img/jugador.png",3)
    enemigo1 = Enemigo:crear(16,16,"img/enemigo1.png",1,25)
    enemigo2 = Enemigo:crear(16,16,"img/enemigo2.png",1,25)
    enemigo3 = Enemigo:crear(16,16,"img/enemigo3.png",3,25)
    
    disparo1 = Disparos:crearDisparo(jugador.x,jugador.y,64,64,"img/Axe.png")
   
   

    lienzo = love.graphics.newCanvas(ventana.ancho,ventana.alto)--[[Inicializo un lienzo]]
end

function love.keypressed(key)--[[Tecla para ver la hitbox]]

    if key == "h" then
        hitbox = not hitbox
    end
    if key == "m" then
        inicio = false
    end
    if key == "r" and (jugador.vida<0 or jugador.puntos > 95) then
        enemigo1.reinicio = true
        enemigo2.reinicio = true
        enemigo3.reinicio = true
        enemigo1:dano()
        enemigo2:dano()
        enemigo3:dano()
        jugador:reinicio(ventana.ancho/2,ventana.alto/2,16,16,3)

    end
end
function colisiones(objeto1,objeto2)--[[Controlador de colisiones]]
    return objeto1.x<objeto2.x+objeto2.ancho and objeto2.x< objeto1.x+ objeto1.ancho and objeto1.y<objeto2.y+objeto2.alto and objeto2.y<objeto1.y+objeto1.alto
end
function enemigoGolpeado(objeto1,objeto2)

    objeto1.reinicio = colisiones(objeto2,objeto1) 
    objeto2:golpeado(objeto1.reinicio,musica)
    objeto1:dano(musica2)
       
end
function enemigoDisparo(objeto1,objeto2)

    objeto1.reinicio = colisiones(objeto2,objeto1)
    if objeto1.reinicio then
        objeto2:cambioEstado()
        jugador:puntaje(10)
    end
    objeto1:dano(musica2)
    
end
function love.mousepressed(x,y,button)
    
    if button == 1 and (disparo1.activo == false) then
        
        disparo1:activacion(jugador.x,jugador.y,x/ventana.escala,y/ventana.escala)

    end 
   mouse_x = x
   mouse_y = y
    
end
function love.update(dt)--[[Movimiento inicial del jugador]]

    --[[Calculo de las hitbox]]
    if jugador.vida>=0 and inicio == false then
        
        disparo1:dispara(dt)

        jugador:movimiento(dt)
        enemigo1:movimiento(jugador.x,jugador.y,dt)
        enemigo2:movimiento(jugador.x,jugador.y,dt)
        enemigo3:movimiento(jugador.x,jugador.y,dt)

        enemigoGolpeado(enemigo1,jugador)
        enemigoGolpeado(enemigo2,jugador)
        enemigoGolpeado(enemigo3,jugador)

        enemigoDisparo(enemigo1,disparo1)
        enemigoDisparo(enemigo2,disparo1)
        enemigoDisparo(enemigo3,disparo1)

    end
end
function debugHitbox()--[[Muestra las hitbox en pantalla]]
    
    love.graphics.setColor(1,0,0)

    jugador:Hitbox()
    enemigo1:Hitbox()
    enemigo2:Hitbox()
    enemigo3:Hitbox()
    disparo1:Hitbox()
    love.graphics.setColor(1,1,1)
    
end

function love.draw()--[[Dibuja en pantalla el lienzo con el jugador]]
   
    love.graphics.setCanvas(lienzo)
      
        love.graphics.clear()
       
        if jugador.vida>=0 and jugador.puntos<100 and inicio == false then
            
            enemigo1:dibujar()
            enemigo2:dibujar()
            enemigo3:dibujar()
        
            love.graphics.setColor(0.54,0.27,0.07)
        
            love.graphics.rectangle("fill",0,0,15,ventana.alto) 
            love.graphics.rectangle("fill",0,0,ventana.ancho,15) 
            love.graphics.rectangle("fill",ventana.ancho-15,0,15,ventana.alto) 
            love.graphics.rectangle("fill",0,ventana.alto-15,ventana.ancho,15) 
        
            love.graphics.setColor(1,1,1)

            jugador:dibujo()
            disparo1:dibujo()

            if hitbox then
                debugHitbox()

            end
        elseif jugador.vida<0 and inicio == false then
            love.graphics.rectangle("fill",ventana.ancho/3 + 10,ventana.alto/2 - 15,ventana.alto/2 - 10,30)
            
            love.graphics.setColor(0.54,0.27,0.07)
            love.graphics.print("D e r r o t a",ventana.ancho/3+45,ventana.ancho/2 - 55)
            love.graphics.print("Presiona R para reiniciar",ventana.ancho/3+10,ventana.ancho/2 - 25)
            
            love.graphics.setColor(1,1,1)
        elseif jugador.puntos>=100 and inicio == false then
             love.graphics.rectangle("fill",ventana.ancho/3 + 10,ventana.alto/2 - 15,ventana.alto/2 - 10,30)
            
            love.graphics.setColor(0.65,0.85,0.75)
            love.graphics.print("Victoria",ventana.ancho/3+45,ventana.ancho/2 - 55)
            love.graphics.print("Presiona R para reiniciar",ventana.ancho/3+10,ventana.ancho/2 - 25)
            
            love.graphics.setColor(1,1,1)
        else 

            love.graphics.print("Prototipo numero 1",ventana.ancho/3,ventana.ancho/2 - 55)
            love.graphics.print("Presiona M para iniciar",ventana.ancho/3-10,ventana.ancho/2 - 25)
            love.graphics.print("Movimiento: 'W A S D",40,ventana.limite_y-(ventana.alto/4))
            love.graphics.print("Apunta con el cursor y presiona Clic Izquierdo para disparar",20,ventana.limite_y-(ventana.alto/4)+20)
            
            
        end
        
    love.graphics.setCanvas()
    
    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)

end
