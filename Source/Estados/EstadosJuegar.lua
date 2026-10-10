Bump = require("lib.bump")
EstadosJuegar = Class{__includes = Estados}

function EstadosJuegar:init()--[Inicializa el juego con la carga del escenario, enemigos y jugador]--
    
    
    self.mapa = STI("Mapa/Mapa.lua")
    self.mundo = Bump.newWorld(16)
    
    self.centro_x_camara = ventana.ancho/2
    self.centro_y_camara = ventana.alto/2

    self.mapa_ancho = self.mapa.width * self.mapa.tilewidth
    self.mapa_alto = self.mapa.height * self.mapa.tileheight
    
    self.enemigos = {}--[Tabla Enemigos]--
    self.disparo = {}--[Tabla Disparos]--
    self.objetos = {} --[Tabla Objetos]--

    self.jugador = Jugador(ventana.ancho/2,ventana.alto/2,16,16,"img/jugador.png",5, self.mundo )
    
    --[Creando elementos disparos y cargandolos en su tabla]--
    table.insert(self.disparo, Disparos(0,0,64,64,"img/Axe.png", self.mundo ))
    table.insert(self.disparo, Disparos(0,0,64,64,"img/Axe.png", self.mundo ))
    table.insert(self.disparo, Disparos(0,0,64,64,"img/Axe.png", self.mundo ))

    --[Creando elementos enemigos y cargandolos en su tabla]--
    for _, obj in ipairs(self.mapa.layers["Limites"].objects) do
        
        table.insert(self.objetos,Objetos(obj,self.mundo))
    end
     if self.mapa.layers["Generacion"] then
        
        for _,obj in ipairs(self.mapa.layers["Generacion"].objects) do
            if obj.name == "Enemigo 1" then
                table.insert(self.enemigos, Enemigo(obj.x,obj.y,16,16,"img/enemigo1.png",1,25, self.mundo ))
            end
            if obj.name == "Enemigo 2" then
                table.insert(self.enemigos, Enemigo(obj.x,obj.y,16,16,"img/enemigo2.png",1,25, self.mundo ))
            end
            if obj.name == "Enemigo 3" then
                table.insert(self.enemigos, Enemigo(obj.x,obj.y,16,16,"img/enemigo3.png",3,25, self.mundo ))
            end
        end
    end

    --[Creando un elemento HUD]--
    self.hud = HUD(self.jugador.vida, self.jugador.vida_maxima, self.jugador.puntos)

    --[Inicializa el sonido del juego]--
    love.event.push("sonido_jugando")
    
    self.Fin_del_Juego = false--[Condicion para que termine el juego]--
    self.camara = Camara()--[Camara]--
    
end
function EstadosJuegar:ingresar()end
function EstadosJuegar:salida()end



function EstadosJuegar:actualizar(dt)--[Actualiza los moviminetos del jugador, enemigo y disparos si estan activos]--
   
    if not self.Fin_del_Juego then 
    
        --[Actualizando el moviminetos de los distintos objetos y chequeando sus colisiones]--
        
        self.jugador:movimiento(dt)

        for i,enemigo in ipairs(self.enemigos) do
            enemigo:movimiento(self.jugador.x,self.jugador.y,dt)
        end

        self.jugador:colisiones()

        for i,disparo in ipairs(self.disparo) do
            disparo:dispara(dt)
        end

        for i,disparo in ipairs(self.disparo) do
            
            if disparo:colision() then
                self.jugador:puntaje(5)
            end
        end
        for i,enemigo in ipairs(self.enemigos) do
            
            enemigo:colision()
        end

       
        self.camara:lookAt(self.jugador.x,self.jugador.y)
    end
    
    self.Fin_del_Juego = self.jugador.vida<1  or self.jugador.puntos > 95 --[Controla si se cumple alguna de las condicones para el final de la partida]--
    
    --[Funcion para que la camara no salga de los limites del mapa]--
    if self.camara.x <self.centro_x_camara then
        self.camara.x = self.centro_x_camara
        
    end
    
    if self.camara.y < self.centro_y_camara then
        self.camara.y = self.centro_y_camara
        
    end
    if self.camara.x > (self.mapa_ancho - self.centro_x_camara) then
        self.camara.x = self.mapa_ancho - self.centro_x_camara
        
    end
    if self.camara.y > (self.mapa_alto - self.centro_y_camara) then
        self.camara.y = self.mapa_alto - self.centro_y_camara
        
    end
   
end
function EstadosJuegar:dibujar()--[Dibuja en pantalla al jugador, disparos, enemigos, fondo y limites]--

    
 
    self.camara:attach(0,0,ventana.ancho,ventana.alto)

    self.mapa:drawLayer(self.mapa.layers["Piso"])
    self.mapa:drawLayer(self.mapa.layers["Rocas"])
    for i,enemigo in ipairs(self.enemigos) do 
                
        enemigo:dibujar()
    end 
        
    self.jugador:dibujo() 

    self.mapa:drawLayer(self.mapa.layers["Decoracion"])
    for i,disparo in ipairs(self.disparo) do 
            
        disparo:dibujo()
    end 
    if hitbox then --[Dibuja en pantallas las hitbox si estan activas]--
                
            
        love.graphics.setColor(1,0,0)

        self.jugador:Hitbox()
        for i,enemigo in ipairs(self.enemigos) do
            enemigo:Hitbox()
        end
        for i,disparo in ipairs(self.disparo) do
            disparo:Hitbox()
        end
        for i,objetos in ipairs(self.objetos) do
                
            objetos:Hitbox()
        end
            
        love.graphics.setColor(1,1,1)
    end
    self.camara:detach()
    self.hud:DrawHUD()--[Dibujo en pantalla la HUD del jugador]--
  
    

end
