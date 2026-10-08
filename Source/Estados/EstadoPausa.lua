EstadoPausa = Class{__includes = Estados}

function EstadoPausa:init()end
function EstadoPausa:ingresar(estadoJuegar)--[Guarda informacion necesaria]--

    self.estadoJuego = estadoJuegar    
end
function EstadoPausa:salida()end
function EstadoPausa:actualizar(dt)end
function EstadoPausa:dibujar()--[Dibuja a todos los elementos que estan en pantalla sin eliminarlos]--

    
    self.estadoJuego.camara:attach(0,0,ventana.ancho,ventana.alto)

    self.estadoJuego.mapa:drawLayer(self.estadoJuego.mapa.layers["Piso"])
    self.estadoJuego.mapa:drawLayer(self.estadoJuego.mapa.layers["Rocas"])

    
    self.estadoJuego.jugador:dibujo() 
            
    for i,disparo in ipairs(self.estadoJuego.disparo) do 
                
        disparo:dibujo()
    end 
    if hitbox then 
                
        love.graphics.setColor(1,0,0)

        self.estadoJuego.jugador:Hitbox()
        for i,enemigo in ipairs(self.estadoJuego.enemigos) do
            enemigo:Hitbox()
        end
        for i,disparo in ipairs(self.estadoJuego.disparo) do
            disparo:Hitbox()
        end
        
        love.graphics.setColor(1,1,1)
    end

    for i,enemigo in ipairs(self.estadoJuego.enemigos) do 
                
        enemigo:dibujar()
    end 
    self.estadoJuego.mapa:drawLayer(self.estadoJuego.mapa.layers["Decoracion"])
    self.estadoJuego.camara:detach()
    self.estadoJuego.hud:Draw()
    love.graphics.setColor(1,0,0) 
    love.graphics.print("PAUSA",ventana.ancho/2 - 10,ventana.alto/2 -5,0,1,1)
    love.graphics.setColor(1,1,1) 
           
    
    


end
