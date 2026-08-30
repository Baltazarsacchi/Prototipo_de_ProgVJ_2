require("animacion")
Enemigo = {}
Enemigo.__index = Enemigo


function Enemigo:crear(al,anc,ruta,vi,vel)

    
    local o = setmetatable({},Enemigo)

    
    local sentido = math.random(1,4)

     if sentido == 1 then
        o.x = math.random(25,375)
        o.y = 25
        o.direccion = 0
    elseif sentido == 2 then
        o.x = math.random(25,375)
        o.y = 275
        o.direccion = 1
    elseif sentido == 3 then
        o.x = 25
        o.y =  math.random(25,275)
        o.direccion = 3
    elseif sentido == 4 then
        o.x = 375
        o.y =  math.random(25,275)
        o.direccion = 2
    end

    o.animacion = CrearAnimacion(ruta,3,anc,al,5,true,o.direccion)
    
    o.ancho = anc
    o.alto = al
   
    o.origen_x = o.ancho/2
    o.origen_y = o.alto/2
   
    o.velocidad = vel

    o.vida = vi

    o.hitbox_x = 0
    o.hitbox_y = 0
    o.reinicio = false

    return o

    

end

function Enemigo:dano()

    if self.reinicio then 
    
        local sentido = math.random(1,4)

        if sentido == 1 then
         
            self.x = math.random(25,375)
            self.y = 25
            cambioDireccion(self.animacion,0)
        elseif sentido == 2 then
        
            self.x = math.random(25,375)
            self.y = ventana.alto-25
            cambioDireccion(self.animacion,1)
        elseif sentido == 3 then
          
            self.x = 25
            self.y =  math.random(25,275)
            cambioDireccion(self.animacion,3)
        elseif sentido == 4 then
        
            self.x = ventana.ancho-25
            self.y =  math.random(25,275)
            cambioDireccion(self.animacion,2)
        end
        self.reinicio = false
    end
end

function Enemigo:movimiento(x,y,dt)

    
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
    --[[Calculo de las hitbox]]
        self.hitbox_x = self.x - self.origen_x
        self.hitbox_y = self.y - self.origen_y
    
end

function Enemigo:dibujar()

    DibujarAnimacion(self.animacion,self.x,self.y,self.origen_x,self.origen_y)
end

function Enemigo:Hitbox()
     love.graphics.rectangle("line",self.hitbox_x,self.hitbox_y,self.ancho,self.alto)
    
end