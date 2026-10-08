Enemigo = Class{__includes = Cuerpos}
require("Source.animacion")

function Enemigo:init(x,y,al,anc,ruta,vi,vel,mun,estilo)--[Inicial al enemigo en uno de los 4 bordes definidos]--

 
    self.mundo = mun
    Cuerpos.init(self,Tipo_ENEMIGO,mun)--[Se le otorga un tipo]--
    self.x = x
    self.y =  y
    self.direccion = 0

    self.posicion_inicial_x = x
    self.posicion_inicial_y = y
    self. estilo = estilo
    self.x_anterior = self.x
    self.y_anterior = self.y

    self.animacion = CrearAnimacion(ruta,3,anc,al,5,true,self.direccion,1)
    
    self.ancho = anc
    self.alto = al
   
    self.origen_x = self.ancho/2
    self.origen_y = self.alto/2
   
    self.velocidad = vel

    self.vida = vi

    self.hitbox_x = 0
    self.hitbox_y = 0
    self.reinicio = false

    self.mus = love.audio.newSource("audio/reaparicion_enemigos.mp3", "static")
    self:actualizar_Hitbox()
    self.mundo:add(self, self.hitbox_x, self.hitbox_y, self.ancho, self.alto)

    self.tiempo_recarga = false
    self.hit = false
end


function Enemigo:dano(dt)

    if not self.hit then return end

    

        if self.tiempo_recarga then
            self.x = -16
            self.y = 0
            Timer.after(2, function() self.tiempo_recarga = true end)
        else 
        
            love.event.push("sonido_enemigo")
            self.x = self.posicion_inicial_x
            self.y = self.posicion_inicial_y

            self.hit = false
            self.tiempo_recarga = false
        end
end


function Enemigo:movimiento(x,y,dt)--[Hace que el enemigo se mueva siguiendo al jugador]--

    self.x_anterior = self.x
    self.y_anterior = self.y
    ActualizarAnimacion(self.animacion,dt, false)
    --[[Calculo de distancias con el jugador]]
        local dis_x = math.abs(self.x - x)
        local dis_y = math.abs(self.y - y)
        direccionamiento = dis_x>(dis_y+10)

    --[[Dependiendo la distancia que tiene el enemigo con el jugador se mueve hacia la direccion mas lejana]]  
        if direccionamiento then
     
            if self.x < x then
        
                self.x = self.x + (self.velocidad * dt)
                cambioDireccion(self.animacion,3)
                

            elseif self.x > x then

                self.x = self.x - (self.velocidad * dt)
                cambioDireccion(self.animacion,2)
                
            end
        else 
    
            if self.y < y then
        
                self.y = self.y + (self.velocidad * dt)
                cambioDireccion(self.animacion,0)
                

            elseif self.y > y then

                self.y = self.y - (self.velocidad * dt)
                cambioDireccion(self.animacion,1)

            end
        end

        self:dano(dt)
    --[[Calculo de las hitbox]]
    
    self:actualizar_Hitbox()
    self.mundo:update(self,self.hitbox_x,self.hitbox_y,self.ancho,self.alto)
    
end

function Enemigo:dibujar()

    DibujarAnimacion(self.animacion,self.x,self.y,self.origen_x,self.origen_y)
end

function Enemigo:Hitbox()
    love.graphics.rectangle("line",self.hitbox_x,self.hitbox_y,self.ancho,self.alto)
    
end

function Enemigo:colision()

    local Consulta, tipo = self:Colision() 

    if Consulta then
        
       
        if tipo == 4 then
            self.hit = true
        end
        if tipo == 5 then
            self.x = self.x_anterior
            self.y = self.y_anterior
        end

    end
end