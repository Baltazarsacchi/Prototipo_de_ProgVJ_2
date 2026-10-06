Class = require("lib.class")
Bump = require("lib.bump")

Cuerpos = Class{} --[Clase base para los objetos]--

--[Identificadores del tipo de cuerpo]--
Tipo_ENEMIGO = 1
Tipo_JUGADOR = 2
Tipo_ENEMIGO_DISPARO = 3
Tipo_JUGADOR_DISPARO = 4
Tipo_OBJETO = 5

function Cuerpos:init(tipo,mundo)--[Asociamos el tipo con el cuerpo que se crea]--

    self.tipo = tipo
    self.mundo = mundo
    
end

function Cuerpos:Colision()--[Se hace la verificacion de si hubo colision con el metodo AABB]--

    
    local Tipo, cantidad = self.mundo:queryRect(self.hitbox_x,self.hitbox_y,self.ancho,self.alto)

    for i=1, cantidad do
        local objeto = Tipo[i]
        if objeto ~= self then
            return true , objeto.tipo
        end
    end
    return false, 0
end

function Cuerpos:actualizar_Hitbox()--[Actualiza la hitbox de cada uno de los cuerpos]--
    
    self.hitbox_x = self.x - self.origen_x
    self.hitbox_y = self.y - self.origen_y
end