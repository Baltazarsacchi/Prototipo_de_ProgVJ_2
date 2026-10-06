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
    self.animacion.activado = true
    self.puntos = 0
    self.mus = love.audio.newSource("audio/golpe.mp3", "static")
    self.golpe = false
    self.mundo = mun

    self.camara = Camara()
    self.Vida_completa = love.graphics.newImage("img/Vida_Completa.png")
    self.Vida_vacia = love.graphics.newImage("img/Vida_Vacia.png")

    self:actualizar_Hitbox()
    self.mundo:add(self,self.hitbox_x,self.hitbox_y,self.ancho,self.alto)

end

function Jugador:golpeado(hit)

    if hit then
        self.vida = self.vida - 1 
        self.mus:play()
        self.golpe = false
    end
    
end
function Jugador:puntaje(pun)

    self.puntos = self.puntos + pun
    
end
function Jugador:movimiento(dt)
     
    self.x_anterior = self.x
    self.y_anterior = self.y
    
    if (love.keyboard.isDown("right") or love.keyboard.isDown("d") ) then

        self.x = self.x + (self.velocidad * dt)
        cambioDireccion(self.animacion,3)

        self.animacion.activa = true
       
    elseif (love.keyboard.isDown("left") or love.keyboard.isDown("a") ) then

        self.x = self.x - (self.velocidad * dt)
        cambioDireccion(self.animacion,2)
        self.animacion.activa = true
        
    elseif (love.keyboard.isDown("up") or love.keyboard.isDown("w")) then

        self.y = self.y - (self.velocidad * dt)

        cambioDireccion(self.animacion,1)
        self.animacion.activa = true
       
       
    elseif (love.keyboard.isDown("down") or love.keyboard.isDown("s")) then

        self.y = self.y + (self.velocidad * dt)
        self.animacion.activa = true
        cambioDireccion(self.animacion,0)
        
    else
        self.animacion.activa = false

    end

   
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

    local consulta, tipo = self:Colision()
    if consulta then 
        if  tipo == 1 then
            self.golpe = true
            self:golpeado(self.golpe)
        end
        if tipo == 5 then
            self.x = self.x_anterior
            self.y = self.y_anterior
        end
    end
end
function Jugador:interfaz()

    love.graphics.print("Vida : ",5,0,0,1,1)
   
    for i = self.vida_maxima-1, 0, -1 do
        love.graphics.draw(self.Vida_vacia,45+(18*i),0,0,1,1) 
    end
    for i = 0,self.vida-1  do
        love.graphics.draw(self.Vida_completa,45 +(18*i),0,0,1,1) 
    end
    
    love.graphics.print("Puntos: ",250,0)
    love.graphics.print(self.puntos,325,0,0,1.1,1.1)
    love.graphics.print("/100",350,0,0,1.1,1.1)

    
end