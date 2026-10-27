Objetos = Class{__includes = Cuerpos}

function Objetos:init(obj,mundo)
   
   
    Cuerpos.init(self,Tipo_OBJETO,mundo)

    self.x = obj.x
    self.y = obj.y
    self.width = obj.width
    self.height = obj.height
    
    mundo:add(self, self.x,self.y,self.width,self.height)
end
function Objetos:Hitbox()
    
    love.graphics.rectangle("line", self.x,self.y,self.width,self.height)
    
end