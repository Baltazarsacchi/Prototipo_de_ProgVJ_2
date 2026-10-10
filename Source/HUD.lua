HUD = Class{}

 audio = {--[Guardo en un tabla todos los sonido]--
    
        inicio = love.audio.newSource("audio/inicio.mp3","stream"),
        jugando = love.audio.newSource("audio/jugando.ogg","stream"),

        victoria = love.audio.newSource("audio/Victoria.mp3","static"),
        derrota = love.audio.newSource("audio/Derrota.mp3","static"),

        jugador = love.audio.newSource("audio/golpe.mp3", "static"),
        disparo = love.audio.newSource("audio/Golpe_al_enemigo.mp3", "static"),
        enemigo = love.audio.newSource("audio/reaparicion_enemigos.mp3", "static"),
    }

function HUD:init(vida, vida_maxima, puntos)--[Inicializo la HUD]--

    --[Cargo las imagenes de vida,puntos de vida y puntos]--
    self.Vida_completa = love.graphics.newImage("img/Vida_Completa.png")
    self.Vida_vacia = love.graphics.newImage("img/Vida_Vacia.png")
    
    self.puntos = puntos
    self.vida = vida
    self.vida_maxima = vida_maxima

   --[Cargo los evento a utilizar]--
    love.handlers["actualizar"] = function(vida, vida_maxima, puntos)
        self:actualizar(vida, vida_maxima, puntos)
    end

    love.handlers["sonido_inicio"] = function() self:sonido(audio.inicio,1.0) end
    love.handlers["sonido_jugando"] = function() self:sonido(audio.jugando,1.0) end

    love.handlers["sonido_victoria"] = function() self:sonido(audio.victoria,1.0) end
    love.handlers["sonido_derrota"] = function() self:sonido(audio.derrota,1.0) end

    love.handlers["sonido_jugador"] = function() self:sonido(audio.jugador,2.0) end
    love.handlers["sonido_disparo"] = function() self:sonido(audio.disparo,10.0) end
    love.handlers["sonido_enemigo"] = function() self:sonido(audio.enemigo,2.0) end

    love.handlers["Parar_la_Musica"] = function () self:detener_sonido() end
   
end
function HUD:actualizar(vida, vida_maxima, puntos)--[Actualiza lo que se ve en la HUD]--

    self.vida = vida
    self.vida_maxima = vida_maxima
    self.puntos = puntos
    
end

function HUD:DrawHUD()--[Dibuja la HUD]--
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

function HUD:sonido(audio,x)--[Activa los Sonidos]--
    
    audio:setVolume(0.25)
    audio:setPitch(x)
    audio:play()
    
end

function HUD:detener_sonido()--[]--

    audio.inicio:stop()
    audio.jugando:stop()
    audio.victoria:stop()
    audio.derrota:stop()
 
end
