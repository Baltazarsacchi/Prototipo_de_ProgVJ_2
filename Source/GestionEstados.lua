
GestionEstados = Class{}

function GestionEstados:init(estado)

    self.origen = {
        dibujar = function () end,
        actualizar = function (dt) end,
        ingresar = function () end,
        salida = function () end
    }

    self.estado = estado or {}
    self.actual = self.origen
    
end

function GestionEstados:cambiar(Estado_a_Cambiar, Parametros_Estado)
    
    self.actual:salida()
    self.actual = self.estado[Estado_a_Cambiar]()
    self.actual:ingresar(Parametros_Estado)
    
end

function GestionEstados:Guardar_posicion(estado)

    self.actual:salida()
    self.actual = estado
    self.actual:ingresar()

    
end

function GestionEstados:actualizar(dt)
    
    self.actual:actualizar(dt)
    
end

function GestionEstados:dibujar()
    
    self.actual:dibujar()
    
end