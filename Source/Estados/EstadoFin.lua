EstadoFin = Class{__includes = Estados}


function EstadoFin:init() end
function EstadoFin:ingresar(estadoJuego)--[Guarda informacion necesaria]--
    self.estadoJuego = estadoJuego
    --[Chequea que estado del fin del juego se cumple y le da un sonido]--
    if self.estadoJuego.jugador.vida<1 then
        love.event.push("sonido_derrota")
    else 
        love.event.push("sonido_victoria")
    end
end
function EstadoFin:salida()end
function EstadoFin:actualizar(dt)end
function EstadoFin:dibujar()--[Dibuja la pantalla del final del juego]--

    
    love.graphics.rectangle("fill",ventana.ancho/3 + 10,ventana.alto/2 - 15,ventana.alto/2 - 10,30)
            
    if self.estadoJuego.jugador.vida <1 then
        love.graphics.setColor(0.54,0.27,0.07)
        love.graphics.print("D e r r o t a",ventana.ancho/3+45,ventana.ancho/2 - 55)
        love.graphics.print("Presiona R para reiniciar",ventana.ancho/3+10,ventana.ancho/2 - 25)
            
    else
            
        love.graphics.setColor(0.07,0.54,0.27)
        love.graphics.print("V i c t o r i a",ventana.ancho/3+45,ventana.ancho/2 - 55)
        love.graphics.print("Presiona R para reiniciar",ventana.ancho/3+10,ventana.ancho/2 - 25)
    end
    
    love.graphics.setColor(1,1,1)

end
