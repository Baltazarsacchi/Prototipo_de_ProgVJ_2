HUD = Class{}

function HUD:init(vida, vida_maxima, puntos)


    self.Vida_completa = love.graphics.newImage("img/Vida_Completa.png")
    self.Vida_vacia = love.graphics.newImage("img/Vida_Vacia.png")

    self.puntos = 0

    self.vida = vida
    self.vida_maxima = vida_maxima
    self.jugador = love.audio.newSource("audio/golpe.mp3", "static")
    self.disparo = love.audio.newSource("audio/Golpe_al_enemigo.mp3", "static")
    self.enemigo = love.audio.newSource("audio/reaparicion_enemigos.mp3", "static")

    love.handlers["actualizar"] = function(vida, vida_maxima, puntos)
        self:actualizar(vida, vida_maxima, puntos)
    end
    love.handlers["sonido_jugador"] = function() self:sonido(self.jugador) end
    love.handlers["sonido_disparo"] = function() self:sonido(self.disparo) end
    love.handlers["sonido_enemigo"] = function() self:sonido(self.enemigo) end
   
end
function HUD:actualizar(vida, vida_maxima, puntos)

    self.vida = vida
    self.vida_maxima = vida_maxima
    self.puntos = puntos
    
end

function HUD:Draw()
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
function HUD:sonido(audio)
    audio:stop()
    audio:setVolume(0.25)
    audio:play()
    
end

