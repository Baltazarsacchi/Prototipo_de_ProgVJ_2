require("lib.dependencias")

ventana = {--[[Tabla de la venta]]

    ancho = 400,
    alto = 300,
    limite_x = 375,
    limite_y = 275,
    escala = 2,
    centro_x_camara = 0,
    centro_y_camara = 0,
    mapa_ancho = 0,
    mapa_alto = 0
}
hitbox = false
inicio = true
pause = false
fin = false

Texto_vidas = ""

function love.load()--[[Funcion donde creo la ventana y doy valores a algunos datos]]

    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)

    love.graphics.setDefaultFilter("nearest", "nearest")
    musica_fondo = love.audio.newSource("audio/fondo.ogg","stream")

    musica_fondo:setLooping(true)
    musica_fondo:setVolume(0.2)

    musica_fondo:play()
   
    Maquina_Estados = GestionEstados{
        [ 'titulo' ] = function() return EstadoTitulo() end,
        [ 'jugar'  ] = function() return EstadosJuegar() end,
        [ 'pause'  ] = function() return EstadoPausa() end,
        [ 'fin_de_partida'  ] = function() return EstadoFin() end
    }

    Maquina_Estados:cambiar("titulo")
    lienzo = love.graphics.newCanvas(ventana.ancho,ventana.alto)--[[Inicializo un lienzo]]

    love.handlers.actualizarVidas = UIVidas
    
end

function UIVidas(vidas)
    
    Texto_vidas = "Vidas: "..vidas
end

function love.keypressed(key)--[[Tecla para ver la hitbox]]

    if key == "m" and inicio then
        Maquina_Estados:cambiar("jugar")
        inicio = false
    end
    if key == "p" and not inicio then
        pause = not pause
        if pause then
            local estadoJuego = Maquina_Estados.actual
          
            Maquina_Estados:cambiar("pause",estadoJuego)
        else

            local estadoJuego = Maquina_Estados.actual.estadoJuego
            Maquina_Estados:Guardar_posicion(estadoJuego)
        end
    end
     if key == "h" and not inicio then
        hitbox = not hitbox
    end
    if key == "r" and (pause or fin) then
        
        local estadoJuego = Maquina_Estados.actual
        Maquina_Estados:cambiar("jugar",  estadoJuego)
        inicio = false
        pause = false
        fin = false

    end
    if key == "escape" and (pause or fin) then
        Maquina_Estados:cambiar("titulo")
        inicio = true
        pause = false
    end
end
function love.mousepressed(x,y,button)
    
    if button == 1 and not inicio and not fin and not pause then
        
        for i,disparo in ipairs(Maquina_Estados.actual.disparo) do
            if(not disparo.activo) then
                local mouseX = x / ventana.escala
                local mouseY = y / ventana.escala

                mouseX = mouseX + Maquina_Estados.actual.camara.x - ventana.ancho / 2
                mouseY = mouseY + Maquina_Estados.actual.camara.y - ventana.alto / 2
                
                disparo:activacion(Maquina_Estados.actual.jugador.x,Maquina_Estados.actual.jugador.y,mouseX,mouseY)
                break
            end
        end

    end 
end
function love.update(dt)--[[Movimiento inicial del jugador]]
  
    Timer.update(dt) 
    Maquina_Estados:actualizar(dt)

    if Maquina_Estados.actual.Fin_del_Juego then
    
        local estadoJuego = Maquina_Estados.actual
        Maquina_Estados:cambiar("fin_de_partida",estadoJuego)
        fin = true
    end

end


function love.draw()--[[Dibuja en pantalla el lienzo con el jugador]]
   
    love.graphics.setCanvas(lienzo) 
            
    love.graphics.clear()
    Maquina_Estados:dibujar()
    love.graphics.printf(Texto_vidas, 0, 10, ventana.ancho, "center")
    love.graphics.setCanvas()
    
    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)

    
end
