
GestionEstados = Class{}

function GestionEstados:init(estado)

    self.origen = {--[Funciones basicas que usaran o no las clase hijas]--
        dibujar = function () end,
        actualizar = function (dt) end,
        ingresar = function () end,
        salida = function () end
    }

    self.hud = HUD(0,0,0) --[Definicion de la HUD para que puedan usar eventos las clases hijas]--
    self.estado = estado or {}--[Inica con un estado definido o nill]--
    self.actual = self.origen--[Es la funcion en la que se encuentra]--
    
    
end

function GestionEstados:musica(nombre)--[Activa el sonido en el momento de guardar informacion]--

    if nombre == "titulo" then
        love.event.push("sonido_inicio")
        
    elseif nombre == "jugar" then
        love.event.push("sonido_jugando")
    end
    
end

function GestionEstados:cambiar(Estado_a_Cambiar, Parametros_Estado)--[Hace el cambio de los estados]--
    
    love.event.push("Parar_la_Musica")
    self.actual:salida()
    self.actual = self.estado[Estado_a_Cambiar]()
    self.nombre = Estado_a_Cambiar
    self.actual:ingresar(Parametros_Estado)
    
end

function GestionEstados:Guardar_posicion(estado,nombre)--[Guarda la informacion que ocurre en pantalla]--
     
    love.event.push("Parar_la_Musica")
    self.actual:salida()
    self.actual = estado
    self.nombre = nombre
    self.actual:ingresar(estado)
    self:musica(nombre)

    
end

function GestionEstados:actualizar(dt)--[Actualiza la el estado actual]--
    
    self.actual:actualizar(dt)
    
end

function GestionEstados:dibujar()
    
    self.actual:dibujar()
    
end