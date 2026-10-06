EstadoTitulo = Class{__includes = Estados}

function EstadoTitulo:init()
    self.mapa = STI("Mapa/Titulo.lua")
end
function EstadoTitulo:actualizar(dt) end
function EstadoTitulo:ingresar()end
function EstadoTitulo:salida()end

function EstadoTitulo:dibujar()--[Dibuja la interfaz del inicio del juego]--

    self.mapa:drawLayer(self.mapa.layers["Titulo"]) 
    love.graphics.setColor(1,0,0)
    love.graphics.print("Prototipo numero 2",ventana.ancho/3,ventana.ancho/3 - 55)
    love.graphics.print("Presiona M para iniciar",ventana.ancho/3-10,ventana.ancho/3 - 25)
    love.graphics.print("Movimiento: 'W A S D",40,ventana.limite_y-(ventana.alto/4))
    love.graphics.print("Apunta con el cursor y presiona Clic Izquierdo para disparar",20,ventana.limite_y-(ventana.alto/4)+20)
    love.graphics.setColor(1,1,1)

end