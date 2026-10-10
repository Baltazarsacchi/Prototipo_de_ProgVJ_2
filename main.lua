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



function love.load()--[[Funcion donde creo la ventana y doy valores a algunos datos]]

    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)

    love.graphics.setDefaultFilter("nearest", "nearest")
   
    Maquina_Estados = GestionEstados{
        [ 'titulo' ] = function() return EstadoTitulo() end,
        [ 'jugar'  ] = function() return EstadosJuegar() end,
        [ 'pause'  ] = function() return EstadoPausa() end,
        [ 'fin_de_partida'  ] = function() return EstadoFin() end
    }

    Maquina_Estados:cambiar("titulo")
    lienzo = love.graphics.newCanvas(ventana.ancho,ventana.alto)--[[Inicializo un lienzo]]

    
end

function love.keypressed(key)--[[Tecla para ver la hitbox]]

    local nombre = Maquina_Estados.nombre
    if key == "m" and nombre == "titulo" then
        
        Maquina_Estados:cambiar("jugar")
    elseif key == "p" and nombre == "jugar" then
       
        Maquina_Estados:cambiar("pause",Maquina_Estados.actual)
    elseif key == "p" and nombre == "pause" then
        Maquina_Estados:Guardar_posicion(Maquina_Estados.actual.estadoJuego,"jugar")
    elseif key == "h" and nombre == "jugar" then
        hitbox = not hitbox
    elseif key == "r" and (nombre == "pause" or nombre == "fin_de_partida") then
        Timer.clear()
        Maquina_Estados:cambiar("jugar",Maquina_Estados.actual)
    elseif key == "escape" and (nombre == "pause" or nombre == "fin_de_partida") then
        Maquina_Estados:cambiar("titulo") 
        Timer.clear()
    end
end
function love.mousepressed(x,y,button)
    
    local nombre = Maquina_Estados.nombre
    if button == 1 and nombre == "jugar" then
        
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
   
    if Maquina_Estados.nombre == "jugar" then
        Timer.update(dt)
    end
     
    Maquina_Estados:actualizar(dt)

    if Maquina_Estados.actual.Fin_del_Juego then
    
       Maquina_Estados:cambiar("fin_de_partida",Maquina_Estados.actual)
    end

end


function love.draw()--[[Dibuja en pantalla el lienzo con el jugador]]
   
    love.graphics.setCanvas(lienzo) 
            
    love.graphics.clear()
    Maquina_Estados:dibujar()
    love.graphics.setCanvas()
    
    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)

    
end
