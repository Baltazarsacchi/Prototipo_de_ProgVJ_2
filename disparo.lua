require("animacion")
Disparos = {}

Disparos .__index = Disparos


function Disparos:crearDisparo(posX,posY,al,anc,sprite)

    local dis = setmetatable({},Disparos)

    dis.activo = false

    dis.x = posX
    dis.y = posY
    dis.dir_x = 0
    dis.dir_y = 0
    dis.velocidad = 100
    dis.alto = al*0.2
    dis.ancho = anc*0.2
    dis.origen_x = dis.ancho / 2
    dis.origen_y = dis.alto / 2
    dis.direccion = 1
    dis.animacion = CrearAnimacion(sprite, 3, 64, 64, 5, false,dis.direccion,0.2)
    dis.animacion.activado = false

    dis.hitbox_x = 0
    dis.hitbox_y = 0


    return dis

    
end

function Disparos:cambioEstado()

    self.activo = false
    
end

function Disparos:activacion(posX,posY,x,y)

    self.activo = true

    self.animacion.activado = true
    self.x = posX
    self.y = posY
    local diferencia_x = x - self.x
    local diferencia_y = y - self.y
    local angulo = math.atan2(diferencia_y,diferencia_x )
    self.dir_x = math.cos(angulo)
    self.dir_y = math.sin(angulo)
    
end

function Disparos:dispara(dt)

    if self.activo == true then
        ActualizarAnimacion( self.animacion,dt, false)
        self.x = self.x + (self.dir_x * self.velocidad * dt)
        self.y = self.y + (self.dir_y * self.velocidad * dt) 

        if self.x <15 then
            self.activo = false
        elseif self.y<15 then
            self.activo = false
        elseif self.x>ventana.limite_x then
            self.activo = false
        elseif self.y>ventana.limite_y then
            self.activo = false
        end
    end

    self.hitbox_x = self.x - self.origen_x
    self.hitbox_y = self.y - self.origen_y

    
end

function Disparos:dibujo()

    if self.activo == true then
   
        DibujarAnimacion( self.animacion, self.x, self.y, self.origen_x, self.origen_y)

        love.graphics.print("Recargando ",70,0,0,1,1)
        
    else
        love.graphics.print("Listo para disparar ",70,0,0,1,1)
    end
end

function Disparos:Hitbox()

    love.graphics.rectangle("line",self.hitbox_x,self.hitbox_y,self.ancho,self.alto) 
end