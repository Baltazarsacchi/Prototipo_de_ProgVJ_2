Enemigo = Class{__includes = Cuerpos}
require("Source.animacion")

function Enemigo:init(x,y,al,anc,ruta,vi,vel,mun)--[Inicial al enemigo en uno de los 4 bordes definidos]--

 
    self.mundo = mun
    Cuerpos.init(self,Tipo_ENEMIGO,mun)--[Se le otorga un tipo]--
    
    --[Posicionamiento y posiciones anteriores]--
    self.x = x
    self.y =  y
    self.direccion = 0
    self.posicion_inicial_x = x
    self.posicion_inicial_y = y
    self.x_anterior = self.x
    self.y_anterior = self.y

    --[Inicializacion de animacion]--
    self.animacion = CrearAnimacion(ruta,3,anc,al,5,true,self.direccion,1)
    
    --[Tamaño y centrado de imagen con la hitbox]--
    self.ancho = anc
    self.alto = al
    self.origen_x = self.ancho/2
    self.origen_y = self.alto/2
   
    self.velocidad = vel

    self.hitbox_x = 0
    self.hitbox_y = 0

    self:actualizar_Hitbox()

    --[Lo añado al mundo]--
    self.mundo:add(self, self.hitbox_x, self.hitbox_y, self.ancho, self.alto)

    --[Variables banderas]--
    self.tiempo_recarga = false
    self.hit = false
end


function Enemigo:dano()--[Desaparece al enemigo del mundo y lo regresa en un cierto tiempo]--

    if not self.hit or self.tiempo_recarga then return end
        
        self.mundo:remove(self)
        self.hit = false
        self.tiempo_recarga = true

        Timer.after(3, function()  
            
            love.event.push("sonido_enemigo")
            self.x = self.posicion_inicial_x
            self.y = self.posicion_inicial_y
            self:actualizar_Hitbox()
            self.mundo:add(self, self.hitbox_x, self.hitbox_y, self.ancho, self.alto)
            self.tiempo_recarga = false 

        end)
end


function Enemigo:movimiento(x,y,dt)--[Hace que el enemigo se mueva siguiendo al jugador]--
 

    self:dano()
    if self.tiempo_recarga then return end

    self.x_anterior = self.x
    self.y_anterior = self.y
    ActualizarAnimacion(self.animacion,dt, false)
    --[[Calculo de distancias con el jugador]]
        local dis_x = math.abs(self.x - x)
        local dis_y = math.abs(self.y - y)
        local direccionamiento = dis_x>(dis_y+10)

    
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
    
    
    self:actualizar_Hitbox()
    self.mundo:update(self,self.hitbox_x,self.hitbox_y,self.ancho,self.alto)
    
end

function Enemigo:dibujar()--[Dibuja a los enemigos con su animacion]--
    if self.tiempo_recarga then return end
    DibujarAnimacion(self.animacion,self.x,self.y,self.origen_x,self.origen_y)
end

function Enemigo:Hitbox()--[Dibuja su hitbox]--
    if self.tiempo_recarga then return end
    love.graphics.rectangle("line",self.hitbox_x,self.hitbox_y,self.ancho,self.alto)
    
end

function Enemigo:colision()--[Chequea si hubo colision y con que colisiono]--

    if self.tiempo_recarga then return end

    for _, otro in ipairs(self:Colision()) do
        if otro.tipo == Tipo_JUGADOR then
            self.x = self.x_anterior
            self.y = self.y_anterior
        elseif otro.tipo == Tipo_OBJETO then

            --[El enemigo se sigue movimiento y se destraba si colisiona con un objeto]--
            local diferencia_x = otro.x - self.x
            local diferencia_y = otro.y - self.y
            local angulo = math.atan2(diferencia_y,diferencia_x )
            self.dir_x = math.cos(angulo)
            self.dir_y = math.sin(angulo)
            self.x = self.x - self.dir_x
            self.y = self.y - self.dir_y
        end
    end
    
    self:actualizar_Hitbox()
    self.mundo:update(self, self.hitbox_x, self.hitbox_y, self.ancho, self.alto)
end