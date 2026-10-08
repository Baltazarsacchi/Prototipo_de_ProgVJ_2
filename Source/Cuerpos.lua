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

    
    local items, n = self.mundo:queryRect(self.hitbox_x, self.hitbox_y, self.ancho, self.alto)
    local otros = {}

    for i = 1, n do
        if items[i] ~= self then
            otros[#otros + 1] = items[i]
        end
    end
    return otros
end

function Cuerpos:actualizar_Hitbox()--[Actualiza la hitbox de cada uno de los cuerpos]--
    
    self.hitbox_x = self.x - self.origen_x
    self.hitbox_y = self.y - self.origen_y
end