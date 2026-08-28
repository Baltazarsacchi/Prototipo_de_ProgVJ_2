ventana = {--[[Tabla de la venta]]

    ancho = 400,
    alto = 300,
    escala = 2
}

jugador = {--[[Tabla del Jugador]]
    
    x = 16,
    y = 16,
    ancho,
    alto,
    origen_x,
    origen_y ,
    velocidad = 75,
    sprite = nil,

    hitbox_x = 0,
    hitbox_y = 0
}

enemigos = {

    x,
    y,
    ancho,
    alto,
    origen_x,
    origen_y,
    velocidad = 50,
    sprite = nil,

    hitbox_x = 0,
    hitbox_y = 0
}

hitbox = false

function love.load()--[[Funcion donde creo la ventana y doy valores a algunos datos]]

    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)

    love.graphics.setDefaultFilter("nearest", "nearest")
    
    
    jugador.sprite = love.graphics.newImage("img/Walk.png")
    jugador.alto = jugador.sprite:getHeight()
    jugador.ancho = jugador.sprite:getWidth()
    jugador.origen_x = jugador.ancho / 2
    jugador.origen_y = jugador.alto / 2

    enemigos.x = 100
    enemigos.y = 100

    enemigos.sprite = love.graphics.newImage("img/enemigo_1.png")

   
    enemigos.ancho = enemigos.sprite:getWidth()
    enemigos.alto = enemigos.sprite:getHeight()

    enemigos.origen_x = enemigos.ancho/2
    enemigos.origen_y = enemigos.alto/2
   
    enemigos.velocidad = 50

    enemigos.hitbox_x = 0
    enemigos.hitbox_y = 0


    lienzo = love.graphics.newCanvas(ventana.ancho,ventana.alto)--[[Inicializo un lienzo]]
end

function love.keypressed(key)

    if key == "h" then
        hitbox = not hitbox
    end
    
end
function love.update(dt)--[[Movimiento inicial del jugador]]
    

      if love.keyboard.isDown("right") then

        jugador.x = jugador.x + (jugador.velocidad * dt)
       
    elseif love.keyboard.isDown("left") then

        jugador.x = jugador.x - (jugador.velocidad * dt)
        
    elseif love.keyboard.isDown("up") then

        jugador.y = jugador.y - (jugador.velocidad * dt)
       
    elseif love.keyboard.isDown("down") then

        jugador.y = jugador.y + (jugador.velocidad * dt)
        
    end

    local dis_x = math.abs(enemigos.x - jugador.x)
    local dis_y = math.abs(enemigos.y - jugador.y)

   if dis_x>dis_y then
     if enemigos.x< jugador.x then
        
       enemigos.x = enemigos.x + (enemigos.velocidad * dt)

    elseif enemigos.x>jugador.x then

        enemigos.x = enemigos.x - (enemigos.velocidad * dt)
    end
   else 
    
        if enemigos.y< jugador.y then
        
           enemigos.y = enemigos.y + (enemigos.velocidad * dt)

        elseif enemigos.y>jugador.y then

            enemigos.y = enemigos.y - (enemigos.velocidad * dt)

        end
    end
    enemigos.hitbox_x = enemigos.x - enemigos.origen_x
    enemigos.hitbox_y = enemigos.y - enemigos.origen_y
    jugador.hitbox_x = jugador.x - jugador.origen_x
    jugador.hitbox_y = jugador.y - jugador.origen_y
end
function debugHitbox()
    
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("line",jugador.hitbox_x,jugador.hitbox_y,jugador.ancho,jugador.alto)
    love.graphics.rectangle("line",enemigos.hitbox_x,enemigos.hitbox_y,enemigos.ancho,enemigos.alto)
    love.graphics.setColor(1,1,1)
    
end

function love.draw()--[[Dibuja en pantalla el lienzo con el jugador]]
   
    love.graphics.setCanvas(lienzo)
         
    love.graphics.clear()
    love.graphics.draw(jugador.sprite,jugador.x,jugador.y, 0, 1, 1, jugador.origen_x,jugador.origen_y)

    love.graphics.draw(enemigos.sprite,enemigos.x,enemigos.y, 0, 1, 1, enemigos.origen_x,enemigos.origen_y)

    if hitbox then
        debugHitbox()
    end

    love.graphics.setCanvas()
    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)

end
