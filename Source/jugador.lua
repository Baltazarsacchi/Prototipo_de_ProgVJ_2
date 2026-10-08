require("Source.Cuerpos")
Jugador = Class{__includes = Cuerpos}
require("Source.animacion")


function Jugador:init(posX,posY,al,anc,ruta,vi,mun)


    Cuerpos.init(self,Tipo_JUGADOR,mun)
    self.x = posX
    self.y = posY
    self.x_anterior = posX
    self.y_anterior = posY
    self.direccion = 0
    self.velocidad = 75
    self.alto = al
    self.ancho = anc
    self.origen_x = self.ancho / 2
    self.origen_y = self.alto / 2
    self.vida = vi
    self.vida_maxima = vi
    self.animacion = CrearAnimacion(ruta, 3, 16, 16, 5, true,self.direccion,1)
    self.puntos = 0
   self.img = love.graphics.newImage(ruta)
    self.mundo = mun

    self.invulnerabilidad = false
    self.camara = Camara()
  
    self:actualizar_Hitbox()
    self.mundo:add(self,self.hitbox_x,self.hitbox_y,self.ancho,self.alto)

end


function Jugador:puntaje(pun)

    self.puntos = self.puntos + pun
    love.event.push("actualizar", self.vida, self.vida_maxima, self.puntos)
    
end
function Jugador:movimiento(dt)
     
    self.x_anterior = self.x
    self.y_anterior = self.y
    
    if (love.keyboard.isDown("right") or love.keyboard.isDown("d") ) then

        self.x = self.x + (self.velocidad * dt)
        cambioDireccion(self.animacion,3)
       
    elseif (love.keyboard.isDown("left") or love.keyboard.isDown("a") ) then

        self.x = self.x - (self.velocidad * dt)
        cambioDireccion(self.animacion,2)
        
    elseif (love.keyboard.isDown("up") or love.keyboard.isDown("w")) then

        self.y = self.y - (self.velocidad * dt)
        cambioDireccion(self.animacion,1)
       
       
    elseif (love.keyboard.isDown("down") or love.keyboard.isDown("s")) then

        self.y = self.y + (self.velocidad * dt)
        cambioDireccion(self.animacion,0)
   
    end

    love.event.push("actualizar", self.vida, self.vida_maxima, self.puntos)
    ActualizarAnimacion(self.animacion,dt, false)
   
    self:actualizar_Hitbox()
    self.mundo:update(self,self.hitbox_x,self.hitbox_y,self.ancho,self.alto)

end

function Jugador:dibujo()
    
   
    DibujarAnimacion(self.animacion, self.x, self.y, self.origen_x, self.origen_y)
   
end

function Jugador:Hitbox()

    love.graphics.rectangle("line",self.hitbox_x,self.hitbox_y,self.ancho,self.alto) 
end

function Jugador:colisiones()

    for _, otro in ipairs(self:Colision()) do
        if otro.tipo == Tipo_ENEMIGO and not self.invulnerabilidad then
            self.invulnerabilidad = true
            Timer.after(2, function() self.invulnerabilidad = false end)

            self.vida = self.vida - 1
            love.event.push("sonido_jugador")
            love.event.push("actualizar", self.vida, self.vida_maxima, self.puntos)
        elseif otro.tipo == Tipo_OBJETO then
            self.x = self.x_anterior
            self.y = self.y_anterior
        end
    end

end
