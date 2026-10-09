Class = require("lib.class")
require("Source.animacion")
Disparos = Class{__includes = Cuerpos}

function Disparos:init(posX,posY,al,anc,sprite,mun)--[Inicia el disparo]--

    self.activo = false

    Cuerpos.init(self,Tipo_JUGADOR_DISPARO,mun)

    self.mundo = mun
    self.x = posX
    self.y = posY
    self.dir_x = 0
    self.dir_y = 0
    self.velocidad = 100
    self.alto = al*0.2
    self.ancho = anc*0.2
    self.origen_x = self.ancho / 2
    self.origen_y = self.alto / 2
    self.direccion = 1
    self.animacion = CrearAnimacion(sprite, 3, 64, 64, 5, false,self.direccion,0.2)
    self.animacion.activado = false

    self.time = 0
    self.hitbox_x = 0
    self.hitbox_y = 0

    self:actualizar_Hitbox()
    self.mundo:add(self,self.hitbox_x,self.hitbox_y,self.ancho,self.alto)

end

function Disparos:Disparo_Jugador()--[Le da definicion a los disparos que salen del Jugador]--
    
    Cuerpos.init(self,Tipo_JUGADOR_DISPARO)
end
function Disparos:Disparo_Enemigo()--[Le da definicion a los disparos que salen del Enemigo]--
    Cuerpos.init(self,Tipo_ENEMIGO_DISPARO)
end
function Disparos:activacion(posX,posY,x,y)--[Activa el disparo que sale del jugador]--

    self.activo = true

    self.animacion.activado = true
    self.x = posX
    self.y = posY
    local diferencia_x = x - self.x
    local diferencia_y = y - self.y
    local angulo = math.atan2(diferencia_y,diferencia_x ) --[Calcula el angulo con el que sale el disparos]--
    self.dir_x = math.cos(angulo)
    self.dir_y = math.sin(angulo)
    
end

function Disparos:dispara(dt)--[Actualiza su posicion y verifica que el disparo esta entre los limites]--


    if self.activo == true then
        ActualizarAnimacion( self.animacion,dt, false)
        self.x = self.x + (self.dir_x * self.velocidad * dt)
        self.y = self.y + (self.dir_y * self.velocidad * dt) 

        self.time = self.time + dt

        
    end
    

    self:actualizar_Hitbox()--[Actualiza la Hitbox disparo]--
    self.mundo:update(self,self.hitbox_x,self.hitbox_y,self.ancho,self.alto)

    
end

function Disparos:dibujo()--[Dibuja los disparo]--

    if self.activo == true then
   
        love.graphics.setColor(1,0,0)
        DibujarAnimacion( self.animacion, self.x, self.y, self.origen_x, self.origen_y)
        love.graphics.setColor(1,1,1)
    end
end

function Disparos:Hitbox()--[Dibuja en pantalla la hitbox del Disparo]--

    if self.activo == true then
        love.graphics.rectangle("line",self.hitbox_x,self.hitbox_y,self.ancho,self.alto) 
    end 
    
end

function Disparos:reinicio()--[Reinicia el disparo]--

    self.x = 0
    self.y = 0
    self.activo = false

end
function Disparos:colision()
     
    if not self.activo then return false end

    local pared = false
    for _, otro in ipairs(self:Colision()) do
        if otro.tipo == Tipo_OBJETO then
            pared = true
        elseif otro.tipo == Tipo_ENEMIGO then
            love.event.push("sonido_disparo")
            otro.hit = true
            self:reinicio()
            return true
        end
    end
    if pared then
        self:reinicio()
        return false
    end

    return false
end