Corrutinas = { lista = {} }


function Corrutinas:init(funcion)

    local c = { rutina = coroutine.create(funcion), espera = 0}

    table.insert(Corrutinas.lista,c)
    
   chequeo_estado(c,0)

   return c
    
end
function Corrutinas:actualizar(dt)

    for i = #Corrutinas.lista, 1, -1 do 

        local c = Corrutinas.lista[i]
        
        if not c.muerta then
            
            if type(c.espera) == "number" then
                
                c.espera = c.espera - dt
                
                if c.espera <= 0 then 
                    
                    chequeo_estado(c,dt)
                end
            
            elseif type(c.espera) == "function" then
                
                if c.espera() then 
                    
                    chequeo_estado(c,dt)
                end
            end
        end
        if c.muerta then 
            
            table.remove(Corrutinas.lista, i) 
        end
    end
    
end

function Corrutinas:limpiar()

    Corrutinas.lista = {}
    
end

function chequeo_estado(c, dt)

    local bien,espera = coroutine.resume(c.rutina,dt)
    if not bien then 
    
        error(debug.traceback(c.rutina, espera)) 
    end
    if coroutine.status(c.rutina) == "dead" then
        
        c.muerta = true
    else
        
        c.espera = espera or 0
    end

    
end

function esperar(segundos)
    
    return coroutine.yield(segundos) 
end

function esperarHasta(condicion) 

    return coroutine.yield(condicion) 
end

function esperarFrame()
    
    return coroutine.yield(0) 
end

return Corrutinas