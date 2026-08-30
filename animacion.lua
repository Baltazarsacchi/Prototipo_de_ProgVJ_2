
function CrearAnimacion(imagen, limite, ancho, alto, velocidad, esVertical,Posicion,tamano)
    local animacion = {}

    animacion.ancho = ancho
    animacion.alto = alto
    animacion.tam = tamano
    animacion.spritesheet = love.graphics.newImage(imagen)
    animacion.indice = 1
    animacion.velocidad = velocidad
    animacion.quads = {}
    animacion.activado = true
    animacion.limite = limite
    animacion.bool = esVertical
    if  animacion.bool then
        for i = 0, animacion.limite, 1 do
            table.insert(animacion.quads, love.graphics.newQuad(ancho * Posicion, alto * i, ancho, alto, animacion.spritesheet))
        end
    else
        for i = 0, animacion.limite, 1 do
            table.insert(animacion.quads, love.graphics.newQuad(ancho * i, alto* Posicion, ancho, alto, animacion.spritesheet))
        end
    end
    return animacion
end
function cambioDireccion(animacion,direccion)

    animacion.quads = {}
    
    if animacion.bool then
    
        for i = 0, animacion.limite, 1 do
            table.insert(animacion.quads, love.graphics.newQuad(16 * direccion, animacion.alto * i, animacion.ancho, animacion.alto, animacion.spritesheet))
        end
    else
        for i = 0, animacion.limite, 1 do
            table.insert(animacion.quads, love.graphics.newQuad(animacion.ancho * i, 16 * direccion, animacion.ancho, animacion.alto, animacion.spritesheet))
        end
    end

    
end
function ActualizarAnimacion(animacion,dt, unaVez)
    if animacion.activado then
        animacion.indice = animacion.indice + (animacion.velocidad * dt)
        if animacion.indice >= #animacion.quads + 1 then
            animacion.indice = 1
            if unaVez then
                animacion.activado = false
            end
        end
    end
end
function DibujarAnimacion(animacion, x, y, origen_x, origen_y)
    if animacion.activado then
        local i = math.floor(animacion.indice)
        love.graphics.draw(animacion.spritesheet, animacion.quads[i], x, y,0,animacion.tam,animacion.tam, origen_x, origen_y)
    end
end