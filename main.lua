ventana = {--[[Tabla de la venta]]

    ancho = 400,
    alto = 300,
    escala = 2
}

jugador = {--[[Tabla del Jugador]]
    
    x = 30,
    y = 30,
    ancho,
    alto,
    origen_x,
    origen_y ,
    velocidad = 75,
    sprite = nil,

    vida = 3,

    hitbox_x = 0,
    hitbox_y = 0
}

enemigos = {--[[Tablas enemigos]]

    x = 375,
    y = 275,
    ancho,
    alto,
    origen_x,
    origen_y,
    pos_inicial_x,
    pos_inicial_y,
    velocidad = 50,
    sprite = nil,

    hitbox_x = 0,
    hitbox_y = 0
}

hitbox = false
atrapado = false

sentido = 0


function love.load()--[[Funcion donde creo la ventana y doy valores a algunos datos]]

    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)

    love.graphics.setDefaultFilter("nearest", "nearest")
    
    jugador.x = ventana.ancho/2
    jugador.y = ventana.alto/2
    jugador.sprite = love.graphics.newImage("img/Walk.png")
    jugador.alto = jugador.sprite:getHeight()
    jugador.ancho = jugador.sprite:getWidth()
    jugador.origen_x = jugador.ancho / 2
    jugador.origen_y = jugador.alto / 2
    

    enemigos.pos_inicial_x = enemigos.x
    enemigos.pos_inicial_y = enemigos.y

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

function love.keypressed(key)--[[Tecla para ver la hitbox]]

    if key == "h" then
        hitbox = not hitbox
    end
    
end
function colisiones(x1,y1,ancho1,alto1,x2,y2,ancho2,alto2)--[[Controlador de colisiones]]
    return x1<x2+ancho2 and x2<x1+ancho1 and y1<y2+alto2 and y2<y1+alto1
end

function dano()

    jugador.vida = jugador.vida-1
    sentido = math.random(1,4)

     if sentido == 1 then
        enemigos.x = math.random(25,375)
        enemigos.y = 25
    elseif sentido == 2 then
        enemigos.x = math.random(25,375)
        enemigos.y = 275
    elseif sentido == 3 then
        enemigos.x = 25
        enemigos.y =  math.random(25,275)
    elseif sentido == 4 then
        enemigos.x = 375
        enemigos.y =  math.random(25,275)
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

    --[[Calculo de distancias con el jugador]]
        local dis_x = math.abs(enemigos.x - jugador.x)
        local dis_y = math.abs(enemigos.y - jugador.y)

    --[[Dependiendo la distancia que tiene el enemigo con el jugador se mueve hacia la direccion mas lejana]]
        if dis_x>dis_y then
     
            if enemigos.x<= jugador.x then
        
                enemigos.x = enemigos.x + (enemigos.velocidad * dt)

            elseif enemigos.x>jugador.x then

                enemigos.x = enemigos.x - (enemigos.velocidad * dt)
            end
        else 
    
            if enemigos.y<= jugador.y then
        
                enemigos.y = enemigos.y + (enemigos.velocidad * dt)

            elseif enemigos.y>jugador.y then

                enemigos.y = enemigos.y - (enemigos.velocidad * dt)

            end
        end

    --[[Calculo de las hitbox]]
        enemigos.hitbox_x = enemigos.x - enemigos.origen_x
        enemigos.hitbox_y = enemigos.y - enemigos.origen_y
        jugador.hitbox_x = jugador.x - jugador.origen_x
        jugador.hitbox_y = jugador.y - jugador.origen_y

        atrapado = colisiones(
            jugador.hitbox_x,
            jugador.hitbox_y,
            jugador.ancho,
            jugador.alto,
            enemigos.hitbox_x,
            enemigos.hitbox_y,
            enemigos.ancho,
            enemigos.alto
        ) 
end
function debugHitbox()--[[Muestra las hitbox en pantalla]]
    
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

        love.graphics.print("Vida : ",10,10,0,1,1)
        love.graphics.print(jugador.vida,45,10,0,1.1,1.1)
        
        if atrapado then
            love.graphics.setColor(1,0,0)
            love.graphics.print("Atrapado",0,0)
            love.graphics.setColor(1,1,1)
            dano()
        end
        if hitbox then
            debugHitbox()
        end
    love.graphics.setCanvas()
    
    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)

end
