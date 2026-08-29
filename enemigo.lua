
Enemigo = {}
Enemigo.__index = Enemigo


function Enemigo:crear(vel,vid,ruta)

    
    local o = setmetatable({},Enemigo)

    local sentido = math.random(1,4)

     if sentido == 1 then
        o.x = math.random(25,375)
        o.y = 25
    elseif sentido == 2 then
        o.x = math.random(25,375)
        o.y = 275
    elseif sentido == 3 then
        o.x = 25
        o.y =  math.random(25,275)
    elseif sentido == 4 then
        o.x = 375
        o.y =  math.random(25,275)
    end
    
    o.sprite = love.graphics.newImage(ruta)

    o.ancho = o.sprite:getWidth()
    o.alto = o.sprite:getHeight()
   
    o.origen_x = o.ancho/2
    o.origen_y = o.alto/2
   
    o.velocidad = vel

    o.vida = vid

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
        elseif sentido == 2 then
        
            self.x = math.random(25,375)
            self.y = 275
        elseif sentido == 3 then
          
            self.x = 25
            self.y =  math.random(25,275)
        elseif sentido == 4 then
        
            self.x = 375
            self.y =  math.random(25,275)
        end
        self.reinicio = false
    end
end

function Enemigo:movimiento(x,y,dt)

    --[[Calculo de distancias con el jugador]]
        local dis_x = math.abs(self.x - x)
        local dis_y = math.abs(self.y - y)

    --[[Dependiendo la distancia que tiene el enemigo con el jugador se mueve hacia la direccion mas lejana]]
        if dis_x>dis_y then
     
            if self.x <= x then
        
                self.x = self.x + (self.velocidad * dt)

            elseif self.x > x then

                self.x = self.x - (self.velocidad * dt)
            end
        else 
    
            if self.y <= y then
        
                self.y = self.y + (self.velocidad * dt)

            elseif self.y > y then

                self.y = self.y - (self.velocidad * dt)

            end
        end
    --[[Calculo de las hitbox]]
        self.hitbox_x = self.x - self.origen_x
        self.hitbox_y = self.y - self.origen_y
    
end

function Enemigo:dibujar()

    love.graphics.draw(self.sprite,self.x,self.y, 0, 1, 1, self.origen_x,self.origen_y)

    
end

function Enemigo:Hitbox()
     love.graphics.rectangle("line",self.hitbox_x,self.hitbox_y,self.ancho,self.alto)
    
end